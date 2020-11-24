//
//  FeedService.m
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import "FeedService.h"
#import "RSXmlParser.h"

@implementation FeedService

- (instancetype)initWithParser:(id<RSParserProtocol>)parser {
    self = [super init];
    if (self) {
        _parser = parser;
    }
    return self;
}


- (void)loadFeeds:(void (^)(NSArray<Feeds *> *, NSError *))completion {
    NSURL *url = [NSURL URLWithString:@"https://news.tut.by/rss/index.rss"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil,error);
            NSLog(@"Eror in load feeds method!");
            return;
        }

        [self.parser parseFeeds:data completion:completion];
    }];
    
    [dataTask resume];
}


- (void)dealloc
{
    [_parser release];
    [super dealloc];
}

@end
