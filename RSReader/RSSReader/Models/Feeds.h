//
//  Feeds.h
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Feeds : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *descript;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *pubDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

//-(NSString *)parseDate:(NSString *)oldDateString;

@end

NS_ASSUME_NONNULL_END