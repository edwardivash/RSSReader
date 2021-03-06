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
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"https://[a-z0-9]+.[a-z0-9./]+(rss|feed|xml)"
                                                                           options:0
                                                                             error:&error];

    NSTextCheckingResult *match = [regex firstMatchInString:stringChannel
                                                    options:0
                                                      range:NSMakeRange(0, [stringChannel length])];
    if (match) {
        NSRange matchRange = [match rangeAtIndex:0];
        NSString *number = [stringChannel substringWithRange:matchRange];
        [result addObject:number];
        NSLog(@"Number: %@", number);
    }
        
    [stringChannel release];
    return result;
}

@end
