//
//  NSString+URLStringValidator.m
//  RSSReader
//
//  Created by Eduard Ivash on 3.01.21.
//

#import "NSString+URLStringValidator.h"

@implementation NSString (URLStringValidator)

+ (BOOL)validateUrl:(NSString *)candidate {
    NSString *urlRegEx =
    @"https://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

@end
