//
//  RSSViewController.h
//  RSSReader
//
//  Created by Eduard Ivash on 28.12.20.

#import <UIKit/UIKit.h>

@interface RSSViewController : UIViewController

@property (nonatomic, retain, readonly) NSMutableArray *inputChannelUrls;
@property (nonatomic, retain, readonly) UITableView *rssTableView;
- (void)saveDataInDocFile:(NSString *)channelUrl;

@end
