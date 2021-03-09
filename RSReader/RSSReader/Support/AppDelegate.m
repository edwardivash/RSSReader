//
//  AppDelegate.m
//  RSSReader
//
//  Created by Eduard Ivash on 16.11.20.
//

#import "AppDelegate.h"
#import "RSSViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window = window;
    self.window.backgroundColor = UIColor.whiteColor;
    RSSViewController *rssVC = [RSSViewController new];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:rssVC];
    
    [self.window setRootViewController:nvc];
    [self.window makeKeyAndVisible];
    
    [rssVC release];
    [nvc release];
    [window release];
    
    return YES;
}


- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
