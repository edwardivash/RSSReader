//
//  HtmlParser.h
//  RSSReader
//
//  Created by Eduard Ivash on 13.01.21.
//

#import <Foundation/Foundation.h>

@interface HtmlParser : NSObject

+ (NSArray *)parseHtmlFromData:(NSData *)data;

@end


