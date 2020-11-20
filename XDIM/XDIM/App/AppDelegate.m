//
//  AppDelegate.m
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import "AppDelegate.h"
#import "XDLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    XDLoginViewController *VC = [[XDLoginViewController alloc] init];
    VC.videoName = @"xiayu";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window.rootViewController = nav;
    
    [[XDLog LogManager] openLog:YES];
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
