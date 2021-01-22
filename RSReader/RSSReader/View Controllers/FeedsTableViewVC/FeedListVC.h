//
//  FeedListVC.h
//  RSSReader
//
//  Created by Eduard Ivash on 17.11.20.
//

#import <UIKit/UIKit.h>

@interface FeedListVC : UIViewController

@property (retain, nonatomic, readonly) UIActivityIndicatorView *activityIndicator;
- (void)setupRefreshButton;

@end
