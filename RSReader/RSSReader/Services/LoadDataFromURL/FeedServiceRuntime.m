//
//  FeedServiceRuntime.m
//  RSSReader
//
//  Created by Eduard Ivash on 15.03.21.
//

//
//  FeedServiceRuntime.m
//  RSSReader
//
//  Created by Eduard Ivash on 15.03.21.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "FeedService.h"
#import "Feeds.h"
#import "RSParserProtocol.h"

typedef void(^Completion)(NSArray<Feeds *> *, NSError *);
const char *kClassName = "FeedServiceRuntime";
const char *kPropertyUrlString = "urlString";
const char *kParser = "parser";

Class FeedServiceRuntime;

#pragma mark - Prototypes

void addUrlStringProperty(void);
void addInitWithParser(void);
void addLoadFeedsMethodWithBlock(void);

#pragma mark - Register runtime class

void registerFeedServiceRuntimeClass() {
    FeedServiceRuntime = objc_allocateClassPair([NSObject class], kClassName, 0);
    addUrlStringProperty();
    addInitWithParser();
    addLoadFeedsMethodWithBlock();
    objc_registerClassPair(FeedServiceRuntime);
}

#pragma mark - Url string property

void addUrlStringProperty() {
    const char *objectGettersTypes = [[NSString stringWithFormat:@"%s%s%s",@encode(id),@encode(id),@encode(SEL)] UTF8String];
    const char *objectSetterTypes = [[NSString stringWithFormat:@"%s%s%s%s",@encode(void),@encode(id),@encode(SEL),@encode(id)] UTF8String];

    class_addIvar(FeedServiceRuntime, kPropertyUrlString, sizeof(id), log2(sizeof(id)), @encode(id));

    IMP urlStringGetterIMP = imp_implementationWithBlock(^(id self){
        Ivar urlStringIvar = class_getInstanceVariable(FeedServiceRuntime, kPropertyUrlString);
        return object_getIvar(self, urlStringIvar);
    });
    class_addMethod(FeedServiceRuntime, @selector(urlString), urlStringGetterIMP, objectGettersTypes);

    IMP urlStringSetterIMP = imp_implementationWithBlock(^(id self, NSString *setterUrlString){
        Ivar urlStringIvar = class_getInstanceVariable(FeedServiceRuntime, kPropertyUrlString);
        object_setIvar(self, urlStringIvar, [setterUrlString copy]);
    });
    class_addMethod(FeedServiceRuntime, @selector(setUrlString:), urlStringSetterIMP, objectSetterTypes);
}

#pragma mark - Initializator with parser

void addInitWithParser() {
    const char *initTypes = [[NSString stringWithFormat:@"%s%s%s",@encode(id),@encode(id),@encode(SEL)] UTF8String];
    const char *objectGettersTypes = [[NSString stringWithFormat:@"%s%s%s",@encode(id),@encode(id),@encode(SEL)] UTF8String];

    class_addIvar(FeedServiceRuntime, kParser, sizeof(id), log2(sizeof(id)), @encode(id));

    Ivar parserIvar = class_getInstanceVariable(FeedServiceRuntime, kParser);

    IMP parserIMP = imp_implementationWithBlock(^(id self) {
        return object_getIvar(self, parserIvar);
    });
    class_addMethod(FeedServiceRuntime, @selector(parser), parserIMP, objectGettersTypes);

    IMP initIMP = imp_implementationWithBlock(^(id self, id parser){
        object_setIvar(self, parserIvar, parser);
        return self;
    });
    class_addMethod(FeedServiceRuntime, @selector(initWithParser:), initIMP, initTypes);
}

#pragma mark - Feeds load method

void addLoadFeedsMethodWithBlock() {
    const char *blockTypes = [[NSString stringWithFormat:@"%s%s%s%s",@encode(void),@encode(id),@encode(SEL),@encode(id)] UTF8String];
    IMP loadFeedsIMP = imp_implementationWithBlock(^(id  self, Completion completion) {
        NSURL *url = [NSURL URLWithString:[self urlString]];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                completion(nil,error);
                NSLog(@"Error - %@",error);
                return;
            }

            [[self parser] parseFeeds:data completion:completion];
        }];
        [dataTask resume];
    });
    class_addMethod(FeedServiceRuntime, @selector(loadFeeds:), loadFeedsIMP, blockTypes);
}
