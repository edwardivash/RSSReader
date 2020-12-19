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
#import "WebViewController.h"

NSString *const kNavigationBarTitle = @"RSSReader";
NSString *const kCellId = @"CellId";
NSString *const kSelectedImageName = @"buttonActive";
NSString *const kDisabledImageName = @"buttonDisabled";

@interface FeedListVC () <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) UITableView *feedTableView;
@property (retain, nonatomic) FeedService *feedService;
@property (retain, nonatomic) RSXmlParser *parser;
@property (retain, nonatomic) NSArray<Feeds*>*dataSource;

@end

@implementation FeedListVC

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kNavigationBarTitle;
    [self feedsLoader];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
}

#pragma mark - Feeds Loader Private Method

-(void)feedsLoader {
    
        if (!self.feedService) {
            self.feedService = [[[FeedService alloc]initWithParser:self.parser]autorelease];
            [self.feedService loadFeeds:^(NSArray<Feeds *> *feedsArray, NSError * error) {
                if (!error) {
                    self.dataSource = feedsArray;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.feedTableView reloadData];
                    });
                } else {
                    NSLog(@"Error - %@",error);
                }
            }];
        }
}

#pragma mark - TableView getter customize

- (UITableView *)feedTableView {
    
    if (!_feedTableView) {
        _feedTableView = [UITableView new];
        _feedTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _feedTableView.delegate = self;
        _feedTableView.dataSource = self;
        [_feedTableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil] forCellReuseIdentifier:kCellId];
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

#pragma mark - Parser Getter

- (RSXmlParser *)parser {
    _parser = [RSXmlParser new];
    return _parser;
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    [cell configureFeedItem:self.dataSource[indexPath.row]];
    cell.descriptionButton.tag = indexPath.row;
    [cell.descTextView setHidden:YES];
    [cell.descriptionButton setImage:[UIImage imageNamed:kDisabledImageName] forState:UIControlStateNormal];
    [cell.descriptionButton addTarget:self action:@selector(checkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - CellButtonAction

-(void)checkButtonAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    FeedTableViewCell *feedCell = (FeedTableViewCell *)[_feedTableView cellForRowAtIndexPath:indexPath];
    if ([feedCell.descriptionButton.imageView.image isEqual:[UIImage imageNamed:kDisabledImageName]]) {
        [feedCell.descriptionButton setImage:[UIImage imageNamed:kSelectedImageName] forState:UIControlStateNormal];
        [feedCell.descTextView setHidden:NO];
    } else {
        [feedCell.descriptionButton setImage:[UIImage imageNamed:kDisabledImageName] forState:UIControlStateNormal];
        [feedCell.descTextView setHidden:YES];
    }
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
    return UITableViewAutomaticDimension;
}


- (void)dealloc
{
    [_feedTableView release];
    [_dataSource release];
    [_feedService release];
    [_parser release];
    [super dealloc];
}

@end
