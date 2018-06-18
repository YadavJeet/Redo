//
//  AppDelegate.m
//  REDO
//
//  Created by apple on 09/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "AppDelegate.h"
#import "PayPalMobile.h"
#import <SDWebImage/SDImageCache.h>
#import "SWRevealViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <IQKeyboardReturnKeyHandler.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *bundledPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"CustomPathImages"];
    [[SDImageCache sharedImageCache] addReadOnlyCachePath:bundledPath];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
  [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction: @"AabMGV8THYhemt6PX3CqrvkKyjYT4DNhQnGba4kEFaVh24AiwveYE4GBSnIfUyFg5Er_CipW2KTcw_Wg", PayPalEnvironmentSandbox :@"AacCkntSa9Nnb1Oaj9z5l_dgCorjz_SUyCCV7GFvtqJRbTwc2KTYozf_KmXL8HroducUY7vZUCC1Qqj9"}];
    
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    if ([session valueForKey:@"login"]) {
        UIStoryboard *mainstory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWRevealViewController *home = [mainstory instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nil;
        self.window.rootViewController = nav;
        
    }
    
    return YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
