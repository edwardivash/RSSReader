//
//  FeedService.m
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import "FeedService.h"
#import "RSXmlParser.h"
#import "RSSViewController.h"

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

- (NSString *)urlString {
    if (!_urlString) {
        _urlString = [[NSMutableString alloc] init];
    }
    return _urlString;
}

- (void)loadFeeds:(void (^)(NSArray<Feeds *> *, NSError *))completion {
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil,error);
            NSLog(@"Error - %@",error);
            return;
        }

        [self.parser parseFeeds:data completion:completion];
    }];
    [dataTask resume];
}

@end
