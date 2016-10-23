//
//  AppDelegate.m
//  RushRepairDemo
//
//  Created by xxcao on 2016/10/21.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "UIManager.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "MBProgressController.h"
#import "RushRepairDemo-Swift.h"
#import "UIImage+TYLaunchImage.h"
#import "UIView+TYLaunchAnimation.h"
#import "TYLaunchFadeScaleAnimation.h"

@interface AppDelegate ()<BMKGeneralDelegate>

@property(nonatomic, strong)BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    //初始化地图
    [self initBaiduMap];
//    跳转dash board
    MMDrawerController *rootViewController = [UIManager initGlobalUI];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    //launch image
    UIImageView *screenImageView = [[UIImageView alloc] initWithImage:[UIImage ty_getLaunchImage]];
    [screenImageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeScaleAnimation]
                                    completion:^(BOOL finished) {
                                        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                                        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                                    }];
    return YES;
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

#pragma -mark
- (void)initBaiduMap {
    self.mapManager = [[BMKMapManager alloc] init];
    
    BOOL res = [self.mapManager start:@"UYPTGiqKRF5HlpSjAbwkjO61bcvgmeGC"
                      generalDelegate:self];
    if (!res) {
        [[MBProgressController sharedInstance] showTipsOnlyText:@"初始化地图数据失败"  AndDelay:1.5];
    }

    //        //初始化导航
    //        BNCoreServices.getInstance().initServices(BaiDuMap_key)
    //        BNCoreServices.getInstance().startAsyn({
    //            Q_Log(message: "导航启动成功")
    //            }) {
    //            Q_Log(message: "导航启动失败")
    //        }
}

/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError {
    NSLog(@"Map Error Code is:%d",iError);
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError {
    NSLog(@"Map Permiss Error Code is:%d",iError);
}

@end

@implementation UINavigationBar (CustomImage)
- (UIImage *)barBackground {
    UIImage *img = [Common drawImageSize:Size(Screen_Width, 44.0) Color:ColorRGB(48.0, 111.0, 235.0)];
    return [img stretchableImageWithLeftCapWidth:0 topCapHeight:20];
}

- (void)didMoveToSuperview {
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
        if (iOS7) {
            [self setBarStyle:UIBarStyleBlack];
        }
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor blackColor];
        shadow.shadowOffset = Size(0.5, 0.5);
        NSDictionary *dic = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                              NSShadowAttributeName : shadow,
                              NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0]};
        [self setTitleTextAttributes:dic];
    }
}

@end
