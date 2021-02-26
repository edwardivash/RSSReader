//
//  FeedTableViewCell.h
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import <UIKit/UIKit.h>

extern NSString *const kSelectedImageName;
extern NSString *const kDisabledImageName;

@class Feeds;

@interface FeedTableViewCell : UITableViewCell

- (void)configureFeedItem:(Feeds *)feed indP:(NSIndexPath *)indexPath selectedButtonsInRows:(NSMutableArray *)selectedButtons completion:(void(^)(void)) feedItemConfiguration;

@end
