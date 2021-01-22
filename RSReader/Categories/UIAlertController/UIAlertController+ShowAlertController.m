//
//  UIAlertController+ShowAlertController.m
//  RSSReader
//
//  Created by Eduard Ivash on 4.12.20.
//

#import "UIAlertController+ShowAlertController.h"
#import "FeedListVC.h"

@implementation UIAlertController (ShowAlertController)

+ (UIAlertController *)showAlertControllerWithAction:(FeedListVC *)feedVC {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Unable to load data.", @"") message:NSLocalizedString(@"Check your internet connection.", @"") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [feedVC.activityIndicator stopAnimating];
        [feedVC setupRefreshButton];
    }];
    [alert addAction:okAction];
    return alert;
}

@end
