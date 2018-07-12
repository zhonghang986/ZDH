//
//  ZDHNavigationController.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/9.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHNavigationController.h"
#import "ZDHHomeViewController.h"

@interface ZDHNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZDHNavigationController

+(void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];

    navBar.barTintColor = kMainColor;
//    navBar.tintColor = kWhiteColor;
    navBar.translucent = NO;
    
    [navBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    
    // 导航栏设置字体颜色值
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = kWhiteColor;
    att[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:att];
    
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = kBlackColor;
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    itemAttrs[NSShadowAttributeName] = [ NSShadow new];
    
    //返回按钮偏移量
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    [appearance setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:itemAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
}

-  (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return self.childViewControllers.count > 1;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.backButton setImage:[UIImage imageNamed:@"03"] forState:UIControlStateNormal];
        [self.backButton setImage:[UIImage imageNamed:@"03"] forState:UIControlStateHighlighted];
        [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.backButton sizeToFit];
        self.backButton.contentEdgeInsets = UIEdgeInsetsMake(5, -10, 5, 5);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
        viewController.navigationItem.leftBarButtonItem.customView.frame = CGRectMake(0, 0, 40, 40);
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
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
