//
//  Feeds.h
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Feeds : NSObject

@property (nonatomic,copy) NSString *feedsTitle;
@property (nonatomic,copy) NSString *feedsDescription;
@property (nonatomic,copy) NSString *feedsLink;
@property (nonatomic,copy) NSString *feedsPubDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
