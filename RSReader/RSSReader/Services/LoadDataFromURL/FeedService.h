//
//  FeedService.h
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import <Foundation/Foundation.h>
#import "RSParserProtocol.h"

@class Feeds;

@interface FeedService : NSObject

- (void)loadFeeds:(void (^)(NSArray<Feeds *> *, NSError *))completion;
- (instancetype)initWithParser:(id<RSParserProtocol>)parser;

@end
