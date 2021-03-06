//
//  UIAlertController+ErrorAlertController.m
//  RSSReader
//
//  Created by Eduard Ivash on 3.01.21.
//

#import "UIAlertController+ErrorAlertController.h"
#import "UIAlertController+RSSAlertController.h"

@class RSSViewController;

@implementation UIAlertController (ErrorAlertController)

+ (UIAlertController *)showErrorAlertUrlFormat {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"Wrong URL format." message:@"Example: https://news.tut.by \nor https://tut.by/rss" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [errorAlertController addAction:okAction];
    return errorAlertController;
}

+(UIAlertController *)showErrorAlertDublicateUrl {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"This channel already exists." message:@"Enter a new URL for a channel." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [errorAlertController addAction:okAction];
    return errorAlertController;
}

+(UIAlertController *)showAlertEmptyData:(UINavigationController *)nvc {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"It is not possible to download data from this RSS feed channel." message:@"Please edit url." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [nvc popViewControllerAnimated:YES];
    }];
    [errorAlertController addAction:okAction];
    return errorAlertController;
}

@end
