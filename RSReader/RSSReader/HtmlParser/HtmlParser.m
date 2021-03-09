//
//  HtmlParser.m
//  RSSReader
//
//  Created by Eduard Ivash on 13.01.21.
//

#import "HtmlParser.h"
#import "UIAlertController+ErrorAlertController.h"

@implementation HtmlParser

+ (NSArray *)parseHtmlFromData:(NSData *)data {
    NSMutableArray *result = [NSMutableArray array];
    NSString *stringChannel = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"href=\"https://\\w*[a-z0-9.]\\w*[a-z0-9.]\\w*[a-z0-9.].*(feed|\\.rss|\\.xml|\\.feed)"
                                                                           options:0
                                                                             error:&error];
    long channelsCount = [regex numberOfMatchesInString:stringChannel
                                                options:0
                                                  range:NSMakeRange(0, [stringChannel length])];
    if (channelsCount > 0) {
        NSArray *matches = [regex matchesInString:stringChannel
                                          options:0
                                            range:NSMakeRange(0, [stringChannel length])];
        
        for (NSTextCheckingResult *match in matches) {
            NSString *matchText = [[stringChannel substringWithRange:[match range]] stringByReplacingOccurrencesOfString:@"href=\"" withString:@""];
            [result addObject:matchText];
            NSLog(@"Found String:%@\n", matchText);
        }
    } else {
        NSLog(@"Channels count is %ld.",channelsCount);
    }
    
    [stringChannel release];
    return result;
}

@end
