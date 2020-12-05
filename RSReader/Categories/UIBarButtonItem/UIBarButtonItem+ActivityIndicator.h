//
//  UIBarButtonItem+ActivityIndicator.h
//  RSSReader
//
//  Created by Eduard Ivash on 4.12.20.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ActivityIndicator)

+(UIBarButtonItem *)setupActivityIndicator:(UIActivityIndicatorView *)indicator animating:(BOOL)animating;

@end
