//
//  Feeds.m
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import "Feeds.h"

@implementation Feeds

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _title = [dictionary[@"title"]copy];
        _descript = [dictionary[@"description"]copy];
        _link = [dictionary[@"link"]copy];
        _pubDate = [dictionary[@"pubDate"]copy];
    }
    return self;
}

#pragma mark - Interface

-(NSString *)parseDate:(NSString *)oldDateString {
    NSDateFormatter *oldFormatter = [NSDateFormatter new];
    [oldFormatter setDateFormat:@"EE, d LLLL YYYY HH:mm:ss Z"];
    NSDate *oldDate = [oldFormatter dateFromString:oldDateString];

    NSDateFormatter *newFormatter = [NSDateFormatter new];
    [newFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *newDateString = [newFormatter stringFromDate:oldDate];
    [oldFormatter release];
    [newFormatter release];
    return newDateString;
}

- (void)dealloc
{
    [_title release];
    [_pubDate release];
    [_descript release];
    [_link release];
    [super dealloc];
}

@end
