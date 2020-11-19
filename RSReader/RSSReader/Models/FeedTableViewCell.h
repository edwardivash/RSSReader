//
//  FeedTableViewCell.h
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import <UIKit/UIKit.h>
#import "Feeds.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *feedLabel;
@property (retain, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (retain,nonatomic) Feeds *feedItem;

-(void)configureFeedItem:(Feeds *)feed;

@end

NS_ASSUME_NONNULL_END
