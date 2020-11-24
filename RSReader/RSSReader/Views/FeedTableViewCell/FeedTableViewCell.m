//
//  FeedTableViewCell.m
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import "FeedTableViewCell.h"
#import "Feeds.h"

@implementation FeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureFeedItem:(Feeds *)feed {
    self.feedItem = feed;
    self.feedLabel.text = self.feedItem.feedsTitle;
    self.pubDateLabel.text = self.feedItem.feedsPubDate;
}


- (void)dealloc {
    [_feedLabel release];
    [_pubDateLabel release];
    [_feedItem release];
    [super dealloc];
}
@end
