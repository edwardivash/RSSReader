//
//  RSSViewController.m
//  RSSReader
//
//  Created by Eduard Ivash on 28.12.20.
//

#import "RSSViewController.h"
#import "FeedListVC.h"
#import "RSSCell.h"
#import "UIAlertController+RSSAlertController.h"
#import "UIAlertController+ErrorAlertController.h"
#import "NSString+URLStringValidator.h"
#import "FeedService.h"
#import "RSXmlParser.h"

NSString *const kNavTitle = @"RSSReader";
NSString *const kRSSCellId = @"RSSCellId";
NSString *const kRSSCellName = @"RSSCell";

@interface RSSViewController () <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>

@property (nonatomic, retain) UITableView *rssTableView;
@property (nonatomic, retain) UIBarButtonItem *channelButtonItem;
@property (nonatomic, retain) NSMutableArray *inputChannelUrls;

@end

@implementation RSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kNavTitle;
    self.navigationItem.rightBarButtonItem = self.channelButtonItem;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self retrieveDataFromDocFile];
    [self.rssTableView reloadData];
    NSLog(@"%@", NSHomeDirectory());
}

#pragma mark - Getters

- (UITableView *)rssTableView {
    if (!_rssTableView) {
        _rssTableView = [UITableView new];
        _rssTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _rssTableView.delegate = self;
        _rssTableView.dataSource = self;
        [_rssTableView registerNib:[UINib nibWithNibName:kRSSCellName bundle:nil] forCellReuseIdentifier:kRSSCellId];
        [self.view addSubview:_rssTableView];
        
        [NSLayoutConstraint activateConstraints:@[
            [_rssTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [_rssTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [_rssTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
            [_rssTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
        ]];
    }
    return _rssTableView;
}

- (UIBarButtonItem *)channelButtonItem {
    if (!_channelButtonItem) {
        _channelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showRSSAlertController)];
    }
    return _channelButtonItem;
}

- (NSMutableArray *)inputChannelUrls {
    if (!_inputChannelUrls) {
        _inputChannelUrls = [[NSMutableArray alloc] init];
    }
    return _inputChannelUrls;
}

#pragma mark - Table View Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSCell *rssCell = [tableView dequeueReusableCellWithIdentifier:kRSSCellId forIndexPath:indexPath];
    [rssCell configureRssChannels:[self.inputChannelUrls objectAtIndex:indexPath.row]];
    return rssCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.inputChannelUrls.count;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedListVC *feedsVC = [[FeedListVC alloc] init];
    feedsVC.stringWithChannelUrl = self.inputChannelUrls[indexPath.row];
    [self.navigationController pushViewController:feedsVC animated:YES];
    [feedsVC release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.inputChannelUrls removeObjectAtIndex:indexPath.row];
        [self removeDataFromDocFile:indexPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.rssTableView reloadData];
        });
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if (editing && !self.rssTableView.isEditing) {
        [self.rssTableView setEditing:YES animated:YES];
    } else {
        [self.rssTableView setEditing:NO animated:NO];
    }
}

#pragma mark - Private Methods

- (void)showRSSAlertController {
    [self presentViewController:[UIAlertController addWebSite:self] animated:YES completion:nil];
}

#pragma mark - Data management in App Documents

- (void)saveDataInDocFile:(NSString *)channelUrl {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"channels.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath: path]) {
        path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"channels.txt"] ];
    }

    if ([fileManager fileExistsAtPath: path]) {
        self.inputChannelUrls = [[[NSMutableArray alloc] initWithContentsOfFile: path] autorelease];
    } else {
        self.inputChannelUrls = [[[NSMutableArray alloc] init] autorelease];
    }

    [self.inputChannelUrls addObject:channelUrl];
    [self.inputChannelUrls writeToFile:path atomically:YES];
}

- (void)removeDataFromDocFile:(NSIndexPath *)indexPath {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"channels.txt"];
    NSMutableArray *mutArray = [NSMutableArray arrayWithContentsOfFile:(NSString *)path];
    [mutArray removeObjectAtIndex:indexPath.row];
    [mutArray writeToFile:path atomically:YES];
}

- (void)retrieveDataFromDocFile {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"channels.txt"];

    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        path = [[NSBundle mainBundle] pathForResource:@"channels" ofType:@"txt"];
    }

    NSMutableArray *mutArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    self.inputChannelUrls = mutArray;
    [mutArray release];
}


- (void)dealloc
{
    [_rssTableView release];
    [_channelButtonItem release];
    [_inputChannelUrls release];
    [super dealloc];
}

@end
