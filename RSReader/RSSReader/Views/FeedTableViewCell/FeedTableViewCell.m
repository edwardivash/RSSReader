//
//  FeedTableViewCell.m
//  RSSReader
//
//  Created by Eduard Ivash on 18.11.20.
//

#import "FeedTableViewCell.h"
#import "Feeds.h"

@implementation FeedTableViewCell

- (void)configureFeedItem:(Feeds *)feed {
    self.feedLabel.text = feed.feedsTitle;
    self.pubDateLabel.text = feed.feedsPubDate;
}

- (void)dealloc {
    [_feedLabel release];
    [_pubDateLabel release];
    [super dealloc];
}

@end
