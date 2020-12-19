//
//  FeedTableViewCell.h
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import <UIKit/UIKit.h>

@class Feeds;

@interface FeedTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *descriptionButton;
@property (retain, nonatomic) UITextView *descTextView;

-(void)configureFeedItem:(Feeds *)feed;

@end
