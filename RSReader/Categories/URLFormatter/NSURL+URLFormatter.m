//
//  NSURL+URLFormatter.m
//  RSSReader
//
//  Created by Eduard Ivash on 15.01.21.
//

#import "NSURL+URLFormatter.h"

@implementation NSURL (URLFormatter)

+ (NSURL *)urlFormatter:(NSString *)urlString {
    NSMutableArray *array = [NSMutableArray array];
    NSMutableString *resultString = [NSMutableString string];
    for (int i = 0; i < [urlString length]; i++) {
            NSString *ch = [urlString substringWithRange:NSMakeRange(i, 1)];
            [array addObject:ch];
        }
        for (int j = 0; j < array.count; j++) {
            if ([array[j] isEqual: @"\n"] || [array[j] isEqual: @"\t"]) {
                break;
            }
            [resultString appendString:array[j]];
        }
    return [NSURL URLWithString:resultString];
}

@end
