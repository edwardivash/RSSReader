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

- (void)configureFeedItem:(Feeds *)feed indexPath:(NSIndexPath *)indexPath selectedButtonsInRows:(NSMutableIndexSet *)selectedButtons handler:(void(^)(void)) didTapHandler;

@end
