//
//  FeedListVC.h
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import <UIKit/UIKit.h>
#import "Feeds.h"
#import "FeedTableViewCell.h"
#import "FeedService.h"
#import "RSXmlParser.h"

@interface FeedListVC : UIViewController

@property (retain, nonatomic)NSArray<Feeds*> *dataSource;
@property (retain, nonatomic) UITableView *feedTableView;
@property (retain, nonatomic) FeedService *feedService;
@property (retain, nonatomic) RSXmlParser *parser;

@end
