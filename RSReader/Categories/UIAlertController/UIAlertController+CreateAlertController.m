//
//  UIAlertController+ShowAlertController.m
//  RSSReader
//
//  Created by Eduard Ivash on 4.12.20.
//

#import "UIAlertController+CreateAlertController.h"
#import "FeedListVC.h"

NSString *const kAlertTitle = @"Unable to load data.";
NSString *const kMessage = @"Check your internet connection.";
NSString *const kOkActionTitle = @"Ok";

@implementation UIAlertController (CreateAlertController)

+ (UIAlertController *)createAlertControllerWithAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(kAlertTitle, @"") message:NSLocalizedString(kMessage, @"") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:kOkActionTitle style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    return alert;
}

@end
