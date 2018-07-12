//
//  AppDelegate.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/5/21.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "AppDelegate.h"
#import "ZDHLaunchImage.h"
#import "ZDHTabBarController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ZDHTabBarController *tabBarVC = [[ZDHTabBarController alloc] initWithNibName:nil bundle:nil];
    [tabBarVC setUpTabBrVC];
    self.window.rootViewController = tabBarVC;
    
    [self.window makeKeyAndVisible];
    
//    [self addLunchImage];
    
    return YES;
}

- (void)addLunchImage {
    ZDHLaunchImage *launchimage = [[ZDHLaunchImage alloc] initWithFrame:self.window.bounds];
    
    [self.window addSubview:launchimage];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 1; i < 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"Launch%d", i];
        
        NSString *filepath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
        
        UIImage *image = [UIImage imageWithContentsOfFile:filepath];
        
        [arr addObject:image];
    }
    
    launchimage.animationImages = arr;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LaunchIamge" object:nil userInfo:nil];
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
