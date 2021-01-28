//
//  FeedTableViewCell.h
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import <UIKit/UIKit.h>

@class Feeds;

@interface FeedTableViewCell : UITableViewCell

- (void)configureFeedItem:(Feeds *)feed;

@end
