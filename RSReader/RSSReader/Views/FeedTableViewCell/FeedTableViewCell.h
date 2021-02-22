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

- (void)configureFeedItem:(Feeds *)feed arrayOfRows:(NSMutableArray *)selectedRows indP:(NSIndexPath *)indexPath completion:(void(^)(UITableViewCell *cell, CGSize selectedCellSize, NSError *error)) feedItemConfiguration;

@end
