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

@property (nonatomic, retain) NSXMLParser *parser;

@property (nonatomic, retain) NSMutableDictionary *feedDictionary;
@property (nonatomic, retain) NSMutableDictionary *parsingDictionary;
@property (nonatomic, retain) NSMutableString *parsingString;
@property (nonatomic, retain) NSMutableArray *feeds;

@end

@implementation RSXmlParser

- (void)parseFeeds:(NSData *)data completion:(void (^)(NSArray<Feeds *> *, NSError *))completion {
    self.completion = completion;
    if (_completion) {
        self.parser = [NSXMLParser setData:data withDelegate:self];
        [self.parser parse];
    } else {
        NSLog(@"Nil completion");
    }
}

#pragma mark - ParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, parseError);
    }
    [self resetParserState];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.feeds = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"item"]) {
        self.feedDictionary = [NSMutableDictionary dictionary];
    } else if ([elementName isEqualToString:@"title"]) {
        self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:@"link"]) {
        self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:@"pubDate"]) {
        self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:@"description"]) {
        self.parsingString = [NSMutableString string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        Feeds *feedObj = [[Feeds alloc]initWithDictionary:self.feedDictionary];
        [self.feeds addObject:feedObj];
        [feedObj release];
    } else if ([elementName isEqualToString:@"title"]) {
        self.feedDictionary[elementName] = self.parsingString;
    } else if ([elementName isEqualToString:@"link"]) {
        self.feedDictionary[elementName] = self.parsingString;
    } else if ([elementName isEqualToString:@"pubDate"]) {
        self.feedDictionary[elementName] = [self.parsingString dateFormatter:self.parsingString];
    } else if ([elementName isEqualToString:@"description"]) {
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
    [self resetParserState];
}

#pragma mark - Private methods

- (void)resetParserState {
    [_completion release];
    _completion = nil;
    [_feeds release];
    _feeds = nil;
    [_parsingDictionary release];
    _parsingDictionary = nil;
    [_parsingString release];
    _parsingString = nil;
}

- (void)dealloc
{
    [_completion release];
    [_feedDictionary release];
    [_parsingString release];
    [_parsingDictionary release];
    [_feeds release];
    [_parser release];
    [super dealloc];
}

@end
