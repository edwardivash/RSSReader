//
//  FeedService.h
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Feeds;

@interface FeedService : NSObject

- (void)loadFeeds:(void (^)(NSArray<Feeds *> *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END