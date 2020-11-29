//
//  NSObject+FeedsLoader.h
//  RSSReader
//
//  Created by Eduard Ivash on 28.11.20.
//

#import <Foundation/Foundation.h>
#import "FeedListVC.h"

@interface NSObject (FeedsLoader)

-(void)feedsLoader:(FeedService *)feedService feedViewController:(FeedListVC *)feedVC;

@end
