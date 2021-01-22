//
//  UIAlertController+ShowAlertController.h
//  RSSReader
//
//  Created by Eduard Ivash on 4.12.20.
//

#import <UIKit/UIKit.h>

@class FeedListVC;

@interface UIAlertController (ShowAlertController)

+ (UIAlertController *)showAlertControllerWithAction:(FeedListVC *)feedVC;

@end
