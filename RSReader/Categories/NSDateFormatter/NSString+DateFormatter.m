//
//  DateFormatter.m
//  RSSReader
//
//  Created by Eduard Ivash on 24.11.20.
//

#import <Foundation/Foundation.h>
#import "NSString+DateFormatter.h"

@implementation NSString (DateFormatter)

+ (NSString *)dateFormatter:(NSString *)oldDateString {
    if (oldDateString) {
        NSString *fixedString = [oldDateString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSDateFormatter *oldFormatter = [NSDateFormatter new];
        [oldFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
        NSDate *oldDate = [oldFormatter dateFromString:fixedString];
        
        NSDateFormatter *newFormatter = [NSDateFormatter new];
        [newFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        NSString *formattedString = [newFormatter stringFromDate:oldDate];
        [oldFormatter release];
        [newFormatter release];
        return formattedString;
    }
    NSLog(@"Empty string.");
    return nil;
}

@end
