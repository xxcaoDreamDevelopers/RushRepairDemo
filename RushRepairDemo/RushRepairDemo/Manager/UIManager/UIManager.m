//
//  UIManager.m
//  PMS
//
//  Created by xxcao on 16/5/6.
//  Copyright © 2016年 齐云猛. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MMDrawerVisualState.h"
#import "RootViewController.h"
#import "UIManager.h"

@implementation UIManager

+ (MMDrawerController *)initGlobalUI {
    LeftMenuViewController *leftSideDrawerViewController = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController" bundle:nil];
    
    NSString *nibName = @"RootViewController";
    if (isIPhone5) {
        nibName = @"RootViewController_4";
    } else if (isIPhone6) {
        nibName = @"RootViewController_4.7";
    } else if (isIPhone6P) {
        nibName = @"RootViewController_5.5";
    }
    
    RootViewController *centerViewController = [[RootViewController alloc] initWithNibName:nibName bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    
    
    MMDrawerController *drawerController = [[MMDrawerController alloc]
                                            initWithCenterViewController:navigationController
                                            leftDrawerViewController:leftSideDrawerViewController
                                            rightDrawerViewController:nil];
    [drawerController setShowsShadow:YES];
    [drawerController setRestorationIdentifier:@"MMDrawer"];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeCustom];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setDrawerVisualStateBlock:[MMDrawerVisualState swingingDoorVisualStateBlock]];

    //自定义手势
    [drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        BOOL shouldRecognizeTouch = NO;
//        if(drawerController.openSide == MMDrawerSideNone &&
//           [gesture isKindOfClass:[UIPanGestureRecognizer class]]){
//            UINavigationController *nav = (UINavigationController *)drawerController.centerViewController;
//            //判断哪个控制器可以滑到抽屉
//            if([nav.topViewController isKindOfClass:[MainViewController class]]
//               )
//            {
//                shouldRecognizeTouch = YES;//返回yes表示可以滑动到左右侧抽屉
//            }
//        }
        return shouldRecognizeTouch;
    }];
    
    return drawerController;
}

@end
