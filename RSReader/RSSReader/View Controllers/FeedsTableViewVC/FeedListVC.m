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
#import "UIAlertController+ShowAlertController.h"

NSString *const kNavigationBarTitle = @"RSSReader";
NSString *const kRefreshButtonName = @"refreshIcon";

@interface FeedListVC () <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UITableView *feedTableView;
@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) UIBarButtonItem *buttonWithActivityIndicator;
@property (retain, nonatomic) UIBarButtonItem *refreshButton;
@property (retain, nonatomic) FeedService *feedService;
@property (retain, nonatomic) RSXmlParser *parser;
@property (retain, nonatomic) NSArray<Feeds*> *dataSource;

@end

@implementation FeedListVC

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kNavigationBarTitle;
    [NSThread detachNewThreadSelector:@selector(feedsLoader) toTarget:self withObject:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self setupButtonWithActivityIndicator];
    [self.activityIndicator startAnimating];
}

#pragma mark - Getters

- (UITableView *)feedTableView {
    if (!_feedTableView) {
        _feedTableView = [UITableView new];
        _feedTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _feedTableView.delegate = self;
        _feedTableView.dataSource = self;
        [_feedTableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
        [self.view addSubview:_feedTableView];
        
        [NSLayoutConstraint activateConstraints:@[
            [_feedTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [_feedTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [_feedTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [_feedTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
        ]];
    }
    return _feedTableView;
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
    }
    return _buttonWithActivityIndicator;
}

- (UIBarButtonItem *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [[UIBarButtonItem alloc] init];
    }
    return _refreshButton;
}

- (RSXmlParser *)parser {
    if (!_parser) {
        _parser = [[RSXmlParser alloc] init];
    }
    return _parser;
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    [cell configureFeedItem:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *urlString = [NSString stringWithString:self.dataSource[indexPath.row].feedsLink];
    NSString *dataStr = [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURL *url = [NSURL URLWithString:dataStr];
    [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL openUrl) {
        NSLog(@"%@", openUrl ? @"Open URL":@"Can't open URL");
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - Feeds Loader

- (void)feedsLoader {
    typeof (self)weakSelf = self;
    if (!_feedService) {
        self.feedService = [[[FeedService alloc]initWithParser:self.parser] autorelease];
        [self.feedService loadFeeds:^(NSArray<Feeds *> *feedsArray, NSError * error) {
            if (!error) {
                weakSelf.dataSource = feedsArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.activityIndicator stopAnimating];
                    [weakSelf setupRefreshButton];
                    [weakSelf.feedTableView reloadData];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.activityIndicator startAnimating];
                    [weakSelf presentViewController:[UIAlertController showAlertControllerWithAction:self] animated:YES completion:nil];
                });
            }
        }];
    }
}

#pragma mark - Private Methods

- (void)setupButtonWithActivityIndicator {
    self.buttonWithActivityIndicator.customView = self.activityIndicator;
    self.navigationItem.rightBarButtonItem = self.buttonWithActivityIndicator;
}

- (void)setupRefreshButton {
    self.refreshButton.image = [UIImage imageNamed:kRefreshButtonName];
    self.refreshButton.target = self;
    self.refreshButton.action = @selector(refreshButtonAction);
    self.navigationItem.rightBarButtonItem = self.refreshButton;
}

- (void)refreshButtonAction {
    [self.feedTableView reloadData];
}


- (void)dealloc
{
    [_feedTableView release];
    [_activityIndicator release];
    [_buttonWithActivityIndicator release];
    [_refreshButton release];
    [_dataSource release];
    [_feedService release];
    [_parser release];
    [super dealloc];
}

@end
