//
//  NSString+GetSubstringFromDescription.m
//  RSSReader
//
//  Created by Eduard Ivash on 15.02.21.
//

#import "NSString+GetSubstringFromDescription.h"

@implementation NSString (GetSubstringFromDescription)

+ (NSString *)getDescriptionsSubstringFromRSSDescription:(NSString *)descriptiongString {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\>[аА-яЯ0-9aA-zZ].*(\\. |\\.\\<)"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    NSString *result = [descriptiongString substringWithRange:[regex firstMatchInString:descriptiongString options:0 range:NSMakeRange(0, [descriptiongString length])].range];
    NSString *finalString = [[[[result stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@"a href=" withString:@""] stringByReplacingOccurrencesOfString:@"/a" withString:@""];
    return [result containsString:@">"] || [result containsString:@"<"] ? finalString : descriptiongString;
}

@end
