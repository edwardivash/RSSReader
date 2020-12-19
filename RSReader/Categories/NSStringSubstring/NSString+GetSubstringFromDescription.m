//
//  NSString+GetSubstringFromDescription.m
//  RSSReader
//
//  Created by Eduard Ivash on 13.12.20.
//

#import "NSString+GetSubstringFromDescription.h"

@implementation NSString (GetSubstringFromDescription)

+(NSString *)descriptionsSubstring:(NSString *)descriptiongString {
    NSRange r1 = [descriptiongString rangeOfString:@"/>"];
    NSRange r2 = [descriptiongString rangeOfString:@"<b"];
    NSRange rSub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
    NSString *result = [descriptiongString substringWithRange:rSub];
    return result;
}

@end
