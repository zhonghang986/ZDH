//
//  ViewController.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/5/21.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
