//
//  SetDataWithDelegate.m
//  RSSReader
//
//  Created by Eduard Ivash on 26.11.20.
//

#import <Foundation/Foundation.h>
#import "NSXMLParser+SetDataWithDelegate.h"

@implementation NSXMLParser(SetDataWithDelegate)

+(NSXMLParser *)setData:(NSData *)data withDelegate:(id<NSXMLParserDelegate>)delegate {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = delegate;
    [parser autorelease];
    return parser;
}

@end
