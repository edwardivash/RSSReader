//
//  FeedListVC.m
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import "FeedListVC.h"
#import "Feeds.h"
#import "FeedTableViewCell.h"


@interface FeedListVC () <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic)NSMutableArray<Feeds*> *dataSource;
@property (retain, nonatomic) UITableView *feedTableView;
@end

@implementation FeedListVC

- (void)viewDidLoad {
    [super viewDidLoad];

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


#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    Feeds *feeds = self.dataSource[indexPath.row];
    [cell configureFeedItem:feeds];
    
    
    return cell;
}

#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self displayURL:self.dataSource[indexPath.row].link];
}

// Open URL

- (void)displayURL:(NSURL *)url {
    [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
}

- (void)dealloc
{
    [_feedTableView release];
    [_dataSource release];
    [super dealloc];
}

@end
