//
//  UIAlertController+RSSAlertController.h
//  RSSReader
//
//  Created by Eduard Ivash on 28.12.20.
//

#import <UIKit/UIKit.h>

@class RSSViewController;

@interface UIAlertController (RSSAlertController)

+ (UIAlertController *)alertToAddInputRSSChannel:(RSSViewController *)rssVC;

@end
