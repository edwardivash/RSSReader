//
//  NSObject+FeedsLoader.m
//  RSSReader
//
//  Created by Eduard Ivash on 28.11.20.
//

#import "NSObject+FeedsLoader.h"
#import "FeedListVC.h"

@implementation NSObject (FeedsLoader)

-(void)feedsLoader:(FeedService *)feedService feedViewController:(FeedListVC *)feedVC {
    
        if (!feedService) {
            feedService = [[[FeedService alloc]initWithParser:feedVC.parser]autorelease];
            [feedService loadFeeds:^(NSArray<Feeds *> *feedsArray, NSError * error) {
                if (!error) {
                    feedVC.dataSource = feedsArray;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [feedVC.feedTableView reloadData];
                    });
                } else {
                    NSLog(@"Error in feedsLoader.");
                }
            }];
        }
}

@end
