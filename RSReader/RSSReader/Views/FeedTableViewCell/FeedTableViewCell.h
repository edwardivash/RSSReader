//
//  FeedTableViewCell.h
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import <UIKit/UIKit.h>
#import "Feeds.h"

@interface FeedTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *feedLabel;
@property (retain, nonatomic) IBOutlet UILabel *pubDateLabel;

-(void)configureFeedItem:(Feeds *)feed;

@end
