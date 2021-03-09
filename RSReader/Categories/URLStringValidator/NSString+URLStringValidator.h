//
//  NSString+URLStringValidator.h
//  RSSReader
//
//  Created by Eduard Ivash on 3.01.21.
//

#import <Foundation/Foundation.h>

@interface NSString (URLStringValidator)

+ (BOOL)validateUrl:(NSString *)candidate;

@end
