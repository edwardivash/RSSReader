//
//  UIBarButtonItem+ActivityIndicator.m
//  RSSReader
//
//  Created by Eduard Ivash on 4.12.20.
//

#import "UIBarButtonItem+ActivityIndicator.h"

@implementation UIBarButtonItem (ActivityIndicator)

+(UIBarButtonItem *)setupActivityIndicator:(UIActivityIndicatorView *)indicator animating:(BOOL)animating {
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem * barButton = [[[UIBarButtonItem alloc] initWithCustomView:indicator]autorelease];
    BOOL flag = animating;
    flag ? [indicator startAnimating] : [indicator stopAnimating];
    [indicator release];
    return barButton;
}

@end
