//
//  RSXmlParser.m
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import "RSXmlParser.h"
#import "Feeds.h"
#import "NSString+DateFormatter.h"
#import "NSXMLParser+SetDataWithDelegate.h"

@interface RSXmlParser () <NSXMLParserDelegate>

@property (nonatomic, copy) void (^completion)(NSArray<Feeds *> *, NSError *);

@property (nonatomic, strong) NSXMLParser *parser;

@property (nonatomic, strong) NSMutableDictionary *feedDictionary;
@property (nonatomic, strong) NSMutableDictionary *parsingDictionary;
@property (nonatomic, strong) NSMutableString *parsingString;
@property (nonatomic, strong) NSMutableArray *feeds;

@end

@implementation RSXmlParser

- (void)parseFeeds:(NSData *)data completion:(void (^)(NSArray<Feeds *> *, NSError *))completion {
    self.completion = completion;
    self.parser = [NSXMLParser setData:data withDelegate:self];
    [self.parser parse];
}

#pragma mark - ParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, parseError);
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.feeds = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:kFeedItem]) {
        self.feedDictionary = [NSMutableDictionary dictionary];
    } else if ([elementName isEqualToString:kFeedsTitle]) {
        self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:kFeedsLink]) {
        self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:kFeedsPubDate]) {
        self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:kFeedsDescription]) {
        self.parsingString = [NSMutableString string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:kFeedItem]) {
        Feeds *feedObj = [[Feeds alloc]initWithDictionary:self.feedDictionary];
        [self.feeds addObject:feedObj];
    } else if ([elementName isEqualToString:kFeedsTitle]) {
        self.feedDictionary[elementName] = self.parsingString;
    } else if ([elementName isEqualToString:kFeedsLink]) {
        self.feedDictionary[elementName] = self.parsingString;
    } else if ([elementName isEqualToString:kFeedsPubDate]) {
        self.feedDictionary[elementName] = [NSString dateFormatter:self.parsingString];
    } else if ([elementName isEqualToString:kFeedsDescription]) {
        self.feedDictionary[elementName] = self.parsingString;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.feeds, nil);
    }
}

@end
