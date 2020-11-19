//
//  RSXmlParser.m
//  RSSReader
//
//  Created by Eduard Ivash on 19.11.20.
//

#import "RSXmlParser.h"
#import "Feeds.h"

@interface RSXmlParser () <NSXMLParserDelegate>

@property (nonatomic, copy) void (^completion)(NSArray<Feeds *> *, NSError *);

@property (nonatomic, retain) NSMutableDictionary *feedDictionary;
@property (nonatomic, retain) NSMutableDictionary *parsingDictionary;
@property (nonatomic, retain) NSMutableString *parsingString;
@property (nonatomic, retain) NSMutableArray *feeds;

@end

@implementation RSXmlParser

- (void)parseFeeds:(NSData *)data completion:(void (^)(NSArray<Feeds *> *, NSError *))completion {
    self.completion = completion;
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = self;
    [parser parse];
    [parser release];
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
    
    if ([elementName isEqualToString:@"title"]) {
      self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:@"url"]) {
      self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:@"pubDate"]) {
      self.parsingString = [NSMutableString string];
    } else if ([elementName isEqualToString:@"description"]) {
      self.parsingString = [NSMutableString string];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];
}

//- (void)parser:(NSXMLParser *)parser
// didEndElement:(NSString *)elementName
//  namespaceURI:(NSString *)namespaceURI
// qualifiedName:(NSString *)qName {
//
//    if (self.parsingString) {
//        [self.parsingDictionary setObject:self.parsingString forKey:elementName];
//        [_parsingString release];
//        self.parsingString = nil;
//    }
//
//    if ([elementName isEqualToString:@"feed"] {
//        [self.feedDictionary setObject:self.parsingDictionary forKey:elementName];
//        self.parsingDictionary = nil;
//    } else if ([elementName isEqualToString:@"avatarUrl"]) {
//        [self.feedDictionary addEntriesFromDictionary:self.parsingDictionary];
//        self.parsingDictionary = nil;
//    } else if ([elementName isEqualToString:@"user"]) {
//        Feeds *feed = [[Feeds alloc] initWithDictionary:self.feedDictionary];
//        self.feedDictionary = nil;
//        [self.feeds addObject:feed];
//    }
//}

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
    [super dealloc];
}

@end
