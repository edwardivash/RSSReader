//
//  Feeds.h
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import <Foundation/Foundation.h>

extern NSString *const kFeedItem;
extern NSString *const kFeedsTitle;
extern NSString *const kFeedsDescription;
extern NSString *const kFeedsLink;
extern NSString *const kFeedsPubDate;

@interface Feeds : NSObject

@property (nonatomic,copy) NSString *feedsItem;
@property (nonatomic,copy) NSString *feedsTitle;
@property (nonatomic,copy) NSString *feedsDescription;
@property (nonatomic,copy) NSString *feedsLink;
@property (nonatomic,copy) NSString *feedsPubDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
