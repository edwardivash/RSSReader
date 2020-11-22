//
//  Feeds.m
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import "Feeds.h"

@implementation Feeds

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = [dictionary[@"title"]copy];
        _descript = [dictionary[@"description"]copy];
        _link = [dictionary[@"link"]copy];
        _pubDate = [[self parseDate:dictionary[@"pubDate"]]copy];
    }
    return self;
}

#pragma mark - Interface

-(NSString *)parseDate:(NSString *)oldDateString {
    NSString *fixedString = [oldDateString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSDateFormatter *oldFormatter = [NSDateFormatter new];
    [oldFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
    NSDate *oldDate = [oldFormatter dateFromString:fixedString];
    
    NSDateFormatter *newFormatter = [NSDateFormatter new];
    [newFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSString *formattedString = [newFormatter stringFromDate:oldDate];
    [oldFormatter release];
    [newFormatter release];
    return formattedString;
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
