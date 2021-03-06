//
//  UIAlertController+RSSAlertController.m
//  RSSReader
//
//  Created by Eduard Ivash on 28.12.20.
//

#import "UIAlertController+RSSAlertController.h"
#import "RSSViewController.h"
#import "NSString+URLStringValidator.h"
#import "UIAlertController+ErrorAlertController.h"
#import "FeedService.h"
#import "HtmlParser.h"

@implementation UIAlertController (RSSAlertController)

// Made in Mexico
+ (UIAlertController *)addWebSite:(RSSViewController *)rssVC {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add RSS Channel" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    __block UITextField *textFieldURL;
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textFieldURL = textField;
        textFieldURL.placeholder = @"Please enter your URL";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![NSString validateUrl:textFieldURL.text]) {
            [rssVC presentViewController:[UIAlertController showErrorAlertUrlFormat] animated:YES completion:nil];
            NSLog(@"Failed validation");
        } else {
            if ([textFieldURL.text containsString:@"/rss"] || [textFieldURL.text containsString:@"/rss.xml"]) {
                if (![rssVC.inputChannelUrls containsObject:textFieldURL.text]) {
                    [rssVC saveDataInDocFile:textFieldURL.text];
                    [rssVC.rssTableView reloadData];
                } else {
                    [rssVC presentViewController:[UIAlertController showErrorAlertDublicateUrl] animated:YES completion:nil];
                }
            }
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:textFieldURL.text]];
            NSArray *channels = [HtmlParser parseHtmlFromData:data];
            for (NSString *strChannel in channels) {
                if (![rssVC.inputChannelUrls containsObject:strChannel]) {
                    [rssVC saveDataInDocFile:strChannel];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [rssVC.rssTableView reloadData];
                    });
                } else {
                    [rssVC presentViewController:[UIAlertController showErrorAlertDublicateUrl] animated:YES completion:nil];
                }
                NSLog(@"Validated");
            }
        }
    }];
    [alert addAction:cancel];
    [alert addAction:save];
    return alert;
}

@end
