//
//  Feeds.m
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import "Feeds.h"

NSString *const kFeedItem = @"item";
NSString *const kFeedsTitle = @"title";
NSString *const kFeedsDescription = @"description";
NSString *const kFeedsLink = @"link";
NSString *const kFeedsPubDate = @"pubDate";

@implementation Feeds

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        _feedsItem = [dictionary[kFeedItem]copy];
        _feedsTitle = [dictionary[kFeedsTitle]copy];
        _feedsDescription = [dictionary[kFeedsDescription]copy];
        _feedsLink = [dictionary[kFeedsLink]copy];
        _feedsPubDate = [dictionary[kFeedsPubDate]copy];
    }
    return self;
}

@end
