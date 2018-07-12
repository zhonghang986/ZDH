//
//  ZDHNotificationVC.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/10.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHNotificationVC.h"
#import "ZDHMessageCell.h"
#import "ZDHNotificationCell.h"
@interface ZDHNotificationVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UILabel *main_title;
@property (nonatomic, weak) UIButton *subtitle;
@property (nonatomic, weak) UIButton *subtitle2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZDHNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    
    [self registerCell];
    // Do any additional setup after loading the view from its nib.
}
- (void)registerCell {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.type == 1) {
            [weakSelf post];
        }
        else{
            [weakSelf postMessage];
        }
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        if (weakSelf.type == 1) {
            [weakSelf post];
        }
        else {
            [weakSelf postMessage];
        }
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDHNotificationCell" bundle:nil] forCellReuseIdentifier:@"ZDHNotificationCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDHMessageCell" bundle:nil] forCellReuseIdentifier:@"ZDHMessageCell"];
    
}

- (void)post {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)postMessage {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) {
        ZDHNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDHNotificationCell" forIndexPath:indexPath];
        [cell setValueForSubViews];
        return cell;
    }else {
        ZDHMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDHMessageCell" forIndexPath:indexPath];
        return cell;
    }
    
}

#pragma mark  创建导航栏
- (void)createNav{
        // 在主线程异步加载，使下面的方法最后执行，防止其他的控件挡住了导航栏
    dispatch_async(dispatch_get_main_queue(), ^{
        // 创建假的导航栏
        UIView *navView = [[UIView alloc] init];
        if (getRectNavAndStatusHight == 88) {
            navView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 88);
        }else {
            navView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        }
        navView.backgroundColor = kMainColor;
        [self.view addSubview:navView];
        
        // 创建导航拦左边按钮
        UIButton *left = [UIButton buttonWithType:UIButtonTypeSystem];
        [left setImage:[[UIImage imageNamed:@"03"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
        [left addTarget:self action:@selector(leftAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [navView addSubview:left];
        
        // 主标题
        UILabel *main_title = [UILabel new];
        
        main_title.font = kFont(18);
        main_title.textColor = kWhiteColor;
        [navView addSubview:main_title];
        
        self.main_title = main_title;
        // 副标题
        UIButton *subtitle = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [subtitle setTitle:MessageTitle forState:(UIControlStateNormal)];
        [subtitle setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        subtitle.alpha = 0.5;
        subtitle.titleLabel.font = kFont(15);
        [navView addSubview:subtitle];
        self.subtitle = subtitle;
        
        [subtitle addTarget:self action:@selector(subtitleAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 副标题2
        UIButton *subtitle2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [subtitle2 setTitle:NotificationTitle forState:(UIControlStateNormal)];
        [subtitle2 setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        subtitle2.alpha = 0.5;
        subtitle2.titleLabel.font = kFont(15);
        [navView addSubview:subtitle2];
        self.subtitle2 = subtitle2;
        [subtitle2 addTarget:self action:@selector(subtitle2Action:) forControlEvents:(UIControlEventTouchUpInside)];
        
        if (self.type == 1) {
            main_title.text = NotificationTitle;
            subtitle2.hidden = YES;
            subtitle.hidden = NO;
        }else {
            main_title.text = MessageTitle;
            subtitle.hidden = YES;
            subtitle2.hidden = NO;
        }
        
        if (getRectNavAndStatusHight == 88) {
            [left mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(10);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(44);
                make.top.offset(44);
            }];
            [main_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(44);
                make.centerX.equalTo(navView.mas_centerX);
                make.height.mas_equalTo(44);
            }];
            
            [subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(main_title.mas_centerY).offset(3);
                make.left.mas_equalTo(main_title.mas_right).offset(30);
            }];
            
            [subtitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(main_title.mas_centerY).offset(3);
                make.right.mas_equalTo(main_title.mas_left).offset(-30);
            }];
        }else {
            [left mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(10);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(44);
                make.top.offset(20);
            }];
            [main_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(20);
                make.centerX.equalTo(navView.mas_centerX);
                make.height.mas_equalTo(44);
            }];
            
            [subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(main_title.mas_centerY).offset(3);
                make.left.mas_equalTo(main_title.mas_right).offset(30);
            }];
            
            [subtitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(main_title.mas_centerY).offset(3);
                make.right.mas_equalTo(main_title.mas_left).offset(-30);
            }];
        }
        
    });

}
- (void)subtitle2Action:(UIButton *)sender {
    self.main_title.text = @"公告";
    self.subtitle2.hidden = YES;
    self.subtitle.hidden = NO;
}

- (void)subtitleAction:(UIButton *)sender {
    self.main_title.text = @"消息";
    self.subtitle2.hidden = NO;
    self.subtitle.hidden = YES;
    
//    if ([self.subtitle.titleLabel.text isEqualToString:@"消息"]) {
//        self.subtitle.titleLabel.text = @"公告";
//        self.main_title.text = @"消息";
//        [self.subtitle mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.main_title.mas_centerY).offset(3);
//            make.right.mas_equalTo(self.main_title.mas_left).offset(-30);
//        }];
//    }else {
//        sender.titleLabel.text = @"消息";
//        self.main_title.text = @"公告";
//        [sender mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.main_title.mas_centerY).offset(3);
//            make.left.mas_equalTo(self.main_title.mas_right).offset(30);
//        }];
//    }
}

- (void)leftAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
