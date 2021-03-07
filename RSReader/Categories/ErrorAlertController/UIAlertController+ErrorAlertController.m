//
//  UIAlertController+ErrorAlertController.m
//  RSSReader
//
//  Created by Eduard Ivash on 3.01.21.
//

#import "UIAlertController+ErrorAlertController.h"
#import "UIAlertController+RSSAlertController.h"

NSString *const kAlertUrlFormatTitle = @"Wrong URL format.";
NSString *const kAlertUrlFormatMessage = @"Example: https://news.tut.by \nor https://tut.by/rss";
NSString *const kAlertDublicateUrlTitle = @"This channel already exists.";
NSString *const kAlertDublicateUrlMessage = @"Enter a new URL for a channel.";
NSString *const kAlertEmptyDataTitle = @"It is not possible to download data from this RSS feed channel.";
NSString *const kAlertEmptyDataMessage = @"Please edit url.";
NSString *const kOk = @"Ok";

@class RSSViewController;

@implementation UIAlertController (ErrorAlertController)

+ (UIAlertController *)showErrorAlertUrlFormat {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(kAlertUrlFormatTitle, @"") message:NSLocalizedString(kAlertUrlFormatMessage, @"") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(kOk, @"") style:UIAlertActionStyleCancel handler:nil];
    [errorAlertController addAction:okAction];
    return errorAlertController;
}

+(UIAlertController *)showErrorAlertDublicateUrl {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(kAlertDublicateUrlTitle, @"") message:NSLocalizedString(kAlertDublicateUrlMessage, @"") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(kOk, @"") style:UIAlertActionStyleCancel handler:nil];
    [errorAlertController addAction:okAction];
    return errorAlertController;
}

+(UIAlertController *)showAlertEmptyData:(UINavigationController *)nvc {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(kAlertEmptyDataTitle, @"") message:NSLocalizedString(kAlertEmptyDataMessage, @"") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [nvc popViewControllerAnimated:YES];
    }];
    [errorAlertController addAction:okAction];
    return errorAlertController;
}

@end
