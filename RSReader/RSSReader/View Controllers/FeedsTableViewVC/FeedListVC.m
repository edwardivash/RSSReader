//
//  FeedListVC.m
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import "FeedListVC.h"
#import "NSObject+FeedsLoader.h"

@interface FeedListVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation FeedListVC

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"RSSReader";
    [self feedsLoader:_feedService feedViewController:self];
}

#pragma mark - TableView getter customize

- (UITableView *)feedTableView {
    
    // Table view setup
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

- (void)dealloc
{
    [_feedTableView release];
    [_dataSource release];
    [_feedService release];
    [_feedService release];
    [_parser release];
    [super dealloc];
}

@end
