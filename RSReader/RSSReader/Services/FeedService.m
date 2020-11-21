//
//  FeedService.m
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import "FeedService.h"
#import "RSXmlParser.h"

@implementation FeedService

- (void)loadFeeds:(void (^)(NSArray<Feeds *> *, NSError *))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://news.tut.by/rss/index.rss"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        } else {
            RSXmlParser *parser = [[RSXmlParser alloc]init];
            [parser parseFeeds:data completion:completion];
            [parser release];
        }
    }];

    [dataTask resume];
}

@end
