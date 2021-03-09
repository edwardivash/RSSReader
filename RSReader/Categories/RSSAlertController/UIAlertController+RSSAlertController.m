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

NSString *const kAlertAddWebSiteTitle = @"Add RSS Channel";
NSString *const kTextFieldPlaceholder = @"Please enter your URL";
NSString *const kCancel = @"Cancel";
NSString *const kSave = @"Save";

@implementation UIAlertController (RSSAlertController)

// Made in Mexico
+ (UIAlertController *)alertToAddInputRSSChannel:(RSSViewController *)rssVC {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kAlertAddWebSiteTitle, @"") message:@"" preferredStyle:UIAlertControllerStyleAlert];
    __block UITextField *textFieldURL;
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textFieldURL = textField;
        textFieldURL.placeholder = NSLocalizedString(kTextFieldPlaceholder, @"");
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(kCancel, @"") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *save = [UIAlertAction actionWithTitle:NSLocalizedString(kSave, @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
