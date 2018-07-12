//
//  ZDHTabBarController.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/9.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHTabBarController.h"
#import "ZDHHomeViewController.h"
#import "ZDHLendingViewController.h"
#import "ZDHFindViewController.h"
#import "ZDHMineViewController.h"
#import "ZDHNotificationVC.h"
@interface ZDHTabBarController ()<UINavigationControllerDelegate>

@end

@implementation ZDHTabBarController
+(void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    attrs[NSForegroundColorAttributeName] = UIColorHex(0x999999);
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = UIColorHex(0x3CA9FF);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    [[UITabBar appearance] setBarTintColor: UIColorHex(0xffffff)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUpTabBrVC {
    
    [self addChildViewController:[[ZDHHomeViewController alloc] init] title:@"首页" defaultImageName:TabBar_Home_DefaultImage andSelectedImageName:TabBar_Home_SelectImage isHiddenNavigationBar:YES];
    
    [self addChildViewController:[[ZDHLendingViewController alloc] init] title:@"出借" defaultImageName:TabBar_Lending_DefaultImage andSelectedImageName:TabBar_Lending_SelectImage isHiddenNavigationBar:YES];
    
    [self addChildViewController:[[ZDHFindViewController alloc] init] title:@"发现" defaultImageName:TabBar_Fine_DefaultImage andSelectedImageName:TabBar_Fine_SelectImage isHiddenNavigationBar:NO];
    
    [self addChildViewController:[[ZDHMineViewController alloc] init] title:@"我的" defaultImageName:TabBar_Mine_DefaultImage andSelectedImageName:TabBar_Mine_SelectImage isHiddenNavigationBar:YES];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title  defaultImageName:(NSString *)imageName  andSelectedImageName:(NSString *)selectedImageName isHiddenNavigationBar:(BOOL)hidden{
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectedImage;
    ZDHNavigationController *nav = [[ZDHNavigationController alloc] initWithRootViewController:childController];
    nav.title = title;
    
    nav.delegate = self;
//    if (hidden) {
//        nav.navigationBar.hidden = YES;
//    }
   
    [self addChildViewController:nav];

}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[ZDHHomeViewController class]];
    BOOL isShowLendingPage = [viewController isKindOfClass:[ZDHLendingViewController class]];
    BOOL isShowMinePage = [viewController isKindOfClass:[ZDHMineViewController class]];
    BOOL isShowNotificationPage = [viewController isKindOfClass:[ZDHNotificationVC class]];
    if (isShowHomePage || isShowLendingPage || isShowMinePage || isShowNotificationPage) {
        
        [viewController.navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [viewController.navigationController setNavigationBarHidden:NO animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
