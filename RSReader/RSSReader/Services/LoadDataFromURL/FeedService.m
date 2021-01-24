//
//  FeedService.m
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import "FeedService.h"
#import "RSXmlParser.h"

NSString *const kUrl = @"https://news.tut.by/rss/index.rss";

@interface FeedService ()

@property (nonatomic, retain) id<RSParserProtocol> parser;

@end

@implementation FeedService

- (instancetype)initWithParser:(id<RSParserProtocol>)parser {
    self = [super init];
    if (self) {
        _parser = parser;
    }
    return self;
}

- (void)loadFeeds:(void (^)(NSArray<Feeds *> *, NSError *))completion {
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kUrl] options:NSDataReadingMapped error:&error];
    
        if (error) {
            completion(nil,error);
            return;
        }
    
        [self.parser parseFeeds:data completion:completion];
}

- (void)dealloc
{
    [_parser release];
    [super dealloc];
}

@end
