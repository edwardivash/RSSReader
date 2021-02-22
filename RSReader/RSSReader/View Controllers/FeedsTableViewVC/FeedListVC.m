//
//  FeedListVC.m
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import "FeedListVC.h"
#import "FeedTableViewCell.h"
#import "FeedService.h"
#import "RSXmlParser.h"
#import "Feeds.h"
#import "UIAlertController+CreateAlertController.h"
#import "WebViewController.h"

NSString *const kNavigationBarTitle = @"RSSReader";
NSString *const kRefreshButtonName = @"refreshIcon";
NSString *const kCellId = @"CellId";
NSString *const kFeedCellName = @"FeedTableViewCell";
CGFloat defaultHeightCell = 150;
CGFloat extendedCell;

@interface FeedListVC () <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UITableView *feedTableView;
@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) UIBarButtonItem *buttonWithActivityIndicator;
@property (retain, nonatomic) UIBarButtonItem *refreshButton;
@property (retain, nonatomic) FeedService *feedService;
@property (retain, nonatomic) RSXmlParser *parser;
@property (retain, nonatomic) NSArray<Feeds*> *dataSource;
@property (retain, nonatomic) NSMutableArray<NSIndexPath *>*selectedButtonsRows;

@end

@implementation FeedListVC

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kNavigationBarTitle;
    [self setTableViewLayout];
    [self feedsLoader];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
}

#pragma mark - Feeds Loader

- (void)feedsLoader {
    __block typeof (self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf setupButtonWithActivityIndicator];
        [weakSelf.activityIndicator startAnimating];
    });
    [self.feedService loadFeeds:^(NSArray<Feeds *> *feedsArray, NSError * error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf presentViewController:[UIAlertController createAlertControllerWithAction] animated:YES completion:nil];
            });
        } else {
            weakSelf.dataSource = feedsArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.feedTableView reloadData];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf setupRefreshButton];
        });
    }];
}

#pragma mark - Getters

- (UITableView *)feedTableView {
    if (!_feedTableView) {
        _feedTableView = [UITableView new];
        _feedTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _feedTableView.delegate = self;
        _feedTableView.dataSource = self;
        [_feedTableView registerNib:[UINib nibWithNibName:kFeedCellName bundle:nil] forCellReuseIdentifier:kCellId];
    }
    return _feedTableView;
}

- (FeedService *)feedService {
    if (!_feedService) {
        _feedService = [[FeedService alloc] initWithParser: self.parser];
    }
    return _feedService;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] init];
    }
    return _activityIndicator;
}

- (UIBarButtonItem *)buttonWithActivityIndicator {
    if (!_buttonWithActivityIndicator) {
        _buttonWithActivityIndicator = [[UIBarButtonItem alloc] init];
        _buttonWithActivityIndicator.customView = self.activityIndicator;
    }
    return _buttonWithActivityIndicator;
}

- (UIBarButtonItem *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [[UIBarButtonItem alloc] init];
        _refreshButton.image = [UIImage imageNamed:kRefreshButtonName];
        _refreshButton.target = self;
        _refreshButton.action = @selector(refreshButtonAction);
    }
    return _refreshButton;
}

- (RSXmlParser *)parser {
    if (!_parser) {
        _parser = [[RSXmlParser alloc] init];
    }
    return _parser;
}

- (NSMutableArray<NSIndexPath *> *)selectedButtonsRows {
    if (!_selectedButtonsRows) {
        _selectedButtonsRows = [[NSMutableArray alloc] init];
    }
    return _selectedButtonsRows;
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    typeof (self)weakSelf = self;

    [cell configureFeedItem:self.dataSource[indexPath.row] arrayOfRows:self.selectedButtonsRows indP:indexPath completion:^(UITableViewCell *cell, CGSize selectedCellSize, NSError *error) {
    
        if (!cell) {
            NSLog(@"%@",error);
            return;
        }
        
        NSIndexPath *path = [tableView indexPathForCell:cell];
        BOOL isContained = [self.selectedButtonsRows containsObject:path];
        isContained ? [weakSelf.selectedButtonsRows removeObject:path] :             [weakSelf.selectedButtonsRows addObject:path];
        isContained = !isContained;
        
        if (isContained) {
            extendedCell = selectedCellSize.height;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            [weakSelf.feedTableView beginUpdates];
            [weakSelf.feedTableView endUpdates];
        }];
    }];
    
     return cell;
}
     
#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *urlString = [NSString stringWithString:self.dataSource[indexPath.row].feedsLink];
    NSString *dataStr = [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    WebViewController *webVC = [[WebViewController alloc]init];
    [webVC.stringWithURL addObject:dataStr];
    [self.navigationController pushViewController:webVC animated:YES];
    [self.feedTableView deselectRowAtIndexPath:[self.feedTableView indexPathForSelectedRow] animated:YES];
    [webVC release];
}
     
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.selectedButtonsRows containsObject:indexPath]) {
        return extendedCell + defaultHeightCell;
    }
    return defaultHeightCell;
}


#pragma mark - Private Methods

- (void)setTableViewLayout {
    [self.view addSubview:self.feedTableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.feedTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.feedTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.feedTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.feedTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}
     
- (void)setupButtonWithActivityIndicator {
    self.navigationItem.rightBarButtonItem = self.buttonWithActivityIndicator;
}

- (void)setupRefreshButton {
    self.navigationItem.rightBarButtonItem = self.refreshButton;
}

- (void)refreshButtonAction {
    [NSThread detachNewThreadSelector:@selector(feedsLoader) toTarget:self withObject:nil];
}


- (void)dealloc {
    [_feedTableView release];
    [_activityIndicator release];
    [_buttonWithActivityIndicator release];
    [_refreshButton release];
    [_dataSource release];
    [_feedService release];
    [_parser release];
    [_selectedButtonsRows release];
    [super dealloc];
}
     
     @end
