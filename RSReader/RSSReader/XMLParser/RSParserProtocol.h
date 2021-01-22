//
//  RSParserProtocol.h
//  RSSReader
//
//  Created by Eduard Ivash on 24.11.20.
//

#import <Foundation/Foundation.h>

@class Feeds;

@protocol RSParserProtocol <NSObject>

- (void)parseFeeds:(NSData *)data completion:(void(^)(NSArray<Feeds *> *, NSError *))completion;

@end
