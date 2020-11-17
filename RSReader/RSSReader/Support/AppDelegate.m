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
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    FeedListVC *vc = [[FeedListVC alloc]initWithNibName:@"FeedListVC" bundle:nil];
    
    [self.window setRootViewController:vc];
    [self.window makeKeyAndVisible];
    
    [vc release];
    [_window release];
    
    return YES;
}


- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
