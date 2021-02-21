//
//  NSString+GetSubstringFromDescription.m
//  RSSReader
//
//  Created by Eduard Ivash on 15.02.21.
//

#import "NSString+GetSubstringFromDescription.h"

@implementation NSString (GetSubstringFromDescription)

+ (NSString *)getDescriptionsSubstringFromRSSDescription:(NSString *)descriptiongString {
    NSRange r1 = [descriptiongString rangeOfString:@"/>"];
    NSRange r2 = [descriptiongString rangeOfString:@"<b"];
    NSRange rSub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
    return [descriptiongString substringWithRange:rSub];
}

@end
