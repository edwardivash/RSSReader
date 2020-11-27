//
//  NSXMLParser+SetDataWithDelegate.h
//  RSSReader
//
//  Created by Eduard Ivash on 26.11.20.
//

#import <Foundation/Foundation.h>

@interface NSXMLParser (SetDataWithDelegate)

+(NSXMLParser *)setData:(NSData *)data withDelegate:(id<NSXMLParserDelegate>)delegate;

@end
