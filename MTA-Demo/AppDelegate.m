//
//  AppDelegate.m
//  MTA-Demo
//
//  Created by WQY on 12-12-10.
//  Copyright (c) 2012年 developer. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "MTA.h"
#import "MTAConfig.h"

@implementation AppDelegate

//- (void)dealloc
//{
//    [_window release];
//    [_tabBarController release];
//    [super dealloc];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

    //[[MTAConfig getInstance] setCustomerUserID:@"1234"];
    
    //[[MTAConfig getInstance] setMaxReportEventLength:1280];
    
    //Old Appkey "DemoApp@MTA"   IG4BJ2YGZ14F
    //[MTA startWithAppkey:@"IG4BJ2YGZ14F"];
    
    //[[MTAConfig getInstance] setCustomerUserID:@"1234"];
    
    //自定义ifa
//    [[MTAConfig getInstance] setIfa:@"myIfa"];
     [[MTAConfig getInstance] setAutoExceptionCaught:false];
    
    [[MTAConfig getInstance] setSmartReporting:YES];
    
    [[MTAConfig getInstance] setReportStrategy:MTA_STRATEGY_INSTANT];

    //自定义crash处理函数，可以获取到mta生成的crash信息
    void (^errorCallback)(NSString *) = ^(NSString * errorString)
    {
        NSLog(@"error_callback %@",errorString);
    };
    [[MTAConfig getInstance] setCrashCallback:errorCallback];
    
    [[MTAConfig getInstance] setDebugEnable:true];
    
    //开发key
    [MTA startWithAppkey:@"I2E3KXDU1E2W"];
    //[MTA startWithAppkey:@"123"];
    
    //[MTA reportQQ:@"5059175"];
    
    //[MTA reportAccount:@"5059175" type:1 ext:@"test"];
    /*
    if(![MTA startWithAppkey:@"I8S27BWQ6HYL" checkedSdkVersion:MTA_SDK_VERSION]){
        //handle exception
    }
     */
    
    
    //[MTA startWithAppkey:@"DemoApp@MTA" checkedSdkVersion:@"0.9.0"];
    //[MTA startWithAppkey:@"DemoApp@MTA"];
    //[MTA trackGameUser:@"g123" world:@"sz1" level:@"10"];

    //[MTA trackError:@"I'm error"];
    
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// 统计应用时长,结束时打点
	[MTA trackActiveEnd];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// 统计应用时长,开始时打点
	[MTA trackActiveBegin];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
