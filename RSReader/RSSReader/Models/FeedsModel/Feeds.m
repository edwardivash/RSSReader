//
//  Feeds.m
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import "Feeds.h"

@implementation Feeds

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary.count || !dictionary) {
        NSLog(@"Dictionary is empty.");
        return nil;
    } else {
        self = [super init];
        _feedsTitle = [dictionary[@"title"] copy];
        _feedsDescription = [dictionary[@"description"] copy];
        _feedsLink = [dictionary[@"link"] copy];
        _feedsPubDate = [dictionary[@"pubDate"] copy];
        
        return self;
    }
}

- (void)dealloc
{
    [_feedsTitle release];
    [_feedsPubDate release];
    [_feedsDescription release];
    [_feedsLink release];
    [super dealloc];
}

@end
