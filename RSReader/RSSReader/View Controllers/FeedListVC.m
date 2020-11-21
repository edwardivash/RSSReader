//
//  FeedListVC.m
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import "FeedListVC.h"
#import "Feeds.h"
#import "FeedTableViewCell.h"
#import "FeedService.h"


@interface FeedListVC () <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic)NSArray<Feeds*> *dataSource;
@property (retain, nonatomic) UITableView *feedTableView;
@property (retain, nonatomic) FeedService *feedService;

@end

@implementation FeedListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self feedsLoader];
    [self setupViews];
}


-(void)setupViews {
    
    // Navigation items setup
    self.navigationItem.title = @"RSSReader";
    
    // Table view setup
    self.feedTableView = [[UITableView alloc]init];
    self.feedTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    [self.feedTableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
    [self.view addSubview:self.feedTableView];
    
    [NSLayoutConstraint activateConstraints:@[
    [self.feedTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [self.feedTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [self.feedTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
    [self.feedTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
}

#pragma mark - Feeds load

-(void)feedsLoader {
    FeedService *feedService = [[FeedService alloc]init];
    NSArray *dataArray = [[NSArray alloc]init];
    self.feedService = feedService;
    self.dataSource = dataArray;
    __block typeof (self)weakSelf = self;
    [self.feedService loadFeeds:^(NSArray<Feeds *> *feedsArray, NSError * error) {
        weakSelf.dataSource = feedsArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.feedTableView reloadData];
        });
    }];
    
    [feedService release];
    [dataArray release];
}


#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    cell.feedItem = self.dataSource[indexPath.row];
    [cell configureFeedItem:cell.feedItem];
    
    return cell;
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *urlString = self.dataSource[indexPath.row].link;
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL openUrl) {
        NSLog(@"%@", openUrl ? @"Yes":@"NO");
        }];
    [url autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)dealloc
{
    [_feedTableView release];
    [_dataSource release];
    [_feedService release];
    [super dealloc];
}

@end
