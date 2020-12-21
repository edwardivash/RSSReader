//
//  UIBarButtonItem+BarButtonItemSetup.m
//  RSSReader
//
//  Created by Eduard Ivash on 21.12.20.
//

#import "UIBarButtonItem+BarButtonItemSetup.h"

@implementation UIBarButtonItem (BarButtonItemSetup)

+(UIBarButtonItem *)setupBarButtonItem:(UIActivityIndicatorView *)indicator animating:(BOOL)animating {
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem * barButton = [[[UIBarButtonItem alloc] initWithCustomView:indicator]autorelease];
    BOOL flag = animating;
    flag ? [indicator startAnimating] : [indicator stopAnimating];
    [indicator release];
    return barButton;
}

@end
