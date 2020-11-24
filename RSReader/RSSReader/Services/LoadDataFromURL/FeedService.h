//
//  FeedService.h
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import <Foundation/Foundation.h>
#import "RSParserProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class Feeds;

@interface FeedService : NSObject

@property (nonatomic, retain) id<RSParserProtocol> parser;
- (void)loadFeeds:(void (^)(NSArray<Feeds *> *, NSError *))completion;
- (instancetype)initWithParser:(id<RSParserProtocol>)parser;

@end

NS_ASSUME_NONNULL_END
