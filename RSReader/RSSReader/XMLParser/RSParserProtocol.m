//
//  RSParserProtocol.m
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import <Foundation/Foundation.h>

@class Feeds;

@protocol RSParserProtocol <NSObject>

-(void)parseFeeds:(NSData *)data completion:(void(^)(NSArray<Feeds *> *, NSError *))completion;


@end
