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
        _title = dictionary[@"title"];
        _descript = dictionary[@"description"];
        _link = [[NSURL URLWithString:dictionary[@"url"]]retain];
        _pubDate = [[self dateFormatter:dictionary[@"pubDate"]]retain];
    }
    return self;
}


-(NSDate *)dateFormatter:(NSString *)str {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"EEE, d MMM yyy";
    NSDate *date = [formatter dateFromString:str];
    [formatter release];
    return date;
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
