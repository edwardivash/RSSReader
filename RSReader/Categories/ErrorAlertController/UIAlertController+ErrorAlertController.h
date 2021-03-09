//
//  UIAlertController+ErrorAlertController.h
//  RSSReader
//
//  Created by Eduard Ivash on 3.01.21.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (ErrorAlertController)

+ (UIAlertController *)showErrorAlertUrlFormat;
+ (UIAlertController *)showErrorAlertDublicateUrl;
+ (UIAlertController *)showAlertEmptyData:(UINavigationController *)nvc;

@end
