//
//  AppDelegate.m
//  RSSReader
//
//  Created by Eduard Ivash on 16.11.20.
//

#import "AppDelegate.h"
#import "FeedListVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window = window;
    FeedListVC *vc = [[FeedListVC alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self.window setRootViewController:nvc];
    [self.window makeKeyAndVisible];
    
    [vc release];
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
