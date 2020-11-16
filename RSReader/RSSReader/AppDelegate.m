//
//  AppDelegate.m
//  RSSReader
//
//  Created by Eduard Ivash on 16.11.20.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    ViewController *vc = [[ViewController alloc]init];
    
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:vc];
    
    return YES;
}



@end
