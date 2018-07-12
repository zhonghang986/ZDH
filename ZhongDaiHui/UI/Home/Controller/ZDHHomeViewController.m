//
//  ZDHHomeViewController.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/9.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHHomeViewController.h"
#import "ZDHNavigationTitleView.h"
#import "ZDHFooterViewCollectionViewCell.h"
#import "ZDHOperationalDataVC.h"
#import "ZDHPlatformIntroductionVC.h"
#import "ZDHRiskControlVC.h"
#import "ZDHNotificationVC.h"
#import "TXScrollLabelView.h"
#import "HW3DBannerView.h"
#import "ZDHBannerViewDetailVC.h"
#import "ZDHHomeCell.h"
@interface ZDHHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,TXScrollLabelViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSArray *footerCollectionCellImages;
@property (weak, nonatomic) IBOutlet UIView *ScrollLable;
@property (weak, nonatomic) IBOutlet UIView *BannerView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *totalLending;
@property (weak, nonatomic) IBOutlet UILabel *TotalRevenue;

@end

@implementation ZDHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    [self createNav];
    
    [self addScrollLable];
    
    [self addFooter];
    
    [self addbannerView];
    
    [self addTableViewCell];
    
    [self updateUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)updateUI {
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    moneyFormatter.positiveFormat = @"###,##0.00";
    NSString *totalLengding = [moneyFormatter stringFromNumber:@(531418441.32)];
    self.totalLending.text = totalLengding;
    
    NSString *TotalRevenue = [moneyFormatter stringFromNumber:@(12324567.21)];
    self.TotalRevenue.text = TotalRevenue;
}
#pragma mark - 自定义Cell
- (void)addTableViewCell {
    [self.tableview registerNib:[UINib nibWithNibName:@"ZDHHomeCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 185;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDHHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    return cell;
}
#pragma mark - 添加Banner图
- (void)addbannerView {
    NSArray *arr = @[
        @"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",
        @"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",
        @"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg"
        ];
    
    HW3DBannerView *bannerView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 161) imageSpacing:10 imageWidth:Main_Screen_Width - 56 data:arr];
    
    bannerView.initAlpha = 0.5; // 设置两边卡片的透明度
    bannerView.imageRadius = 10; // 设置卡片圆角
    bannerView.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
    bannerView.autoScroll = NO;
    bannerView.curPageControlColor = kMainColor;
    bannerView.otherPageControlColor = UIColorFromRGB(168, 172, 176);
    // 设置要加载的图片
    bannerView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
    [self.BannerView addSubview:bannerView];
    
    __weak typeof(self) weakSelf = self;
    bannerView.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调
        NSLog(@"%ld", (long)currentIndex);
        ZDHBannerViewDetailVC *bannerDetailvc = [[ZDHBannerViewDetailVC alloc] init];
        bannerDetailvc.title = @"详情";
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.navigationController pushViewController:bannerDetailvc animated:YES];
        });
        
    };
}
#pragma mark - 添加footer
- (void)addFooter {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.footerCollectionCellImages = @[@"55", @"56", @"57"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZDHFooterViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
}

#pragma mark - 添加轮播通知
- (void)addScrollLable {
    NSArray *scrollTexts = @[@"深圳市巨尊互联网金融服务有限公司,",
                             @"深圳市巨尊互联网金wdwdw融服务有限公司,",
                             @"深圳市巨尊互联网efdwefdw金融服务有限公司,"
                             ];
    
    TXScrollLabelView *scrollLabelView = nil;
    
    
    scrollLabelView = [TXScrollLabelView scrollWithTextArray:scrollTexts type:TXScrollLabelViewTypeFlipNoRepeat velocity:2 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    
    //偏好(Optional), Preference,if you want.
    scrollLabelView.tx_centerX  = [UIScreen mainScreen].bounds.size.width * 0.5;
    scrollLabelView.font = [UIFont systemFontOfSize:13];
    scrollLabelView.backgroundColor = kWhiteColor;
    
    /** Step3: 设置代理进行回调 */
    scrollLabelView.scrollLabelViewDelegate = self;
    
    /** Step4: 布局(Required) */
    scrollLabelView.frame = CGRectMake(0, 5, self.ScrollLable.frame.size.width, 34);
    
    [self.ScrollLable addSubview:scrollLabelView];
    /** Step5: 开始滚动(Start scrolling!) */
    [scrollLabelView beginScrolling];
}

#pragma mark - 跑马灯
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@--%ld",text, index);
    ZDHNotificationVC *notificationvc = [[ZDHNotificationVC alloc] init];
    notificationvc.title = @"公告";
    [self.navigationController pushViewController:notificationvc animated:YES];
}

#pragma mark - 更多
- (IBAction)moreAction:(UIButton *)sender {
    ZDHNotificationVC *notificationvc = [[ZDHNotificationVC alloc] init];
    notificationvc.type = 1;
    [self.navigationController pushViewController:notificationvc animated:YES];
}

#pragma mark -- 拨打客服电话
- (IBAction)callPhone:(UIButton *)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"15738881741"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:callWebview];
    });
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.footerCollectionCellImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"collectionCell";
    ZDHFooterViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.iamge.image = [UIImage imageNamed:self.footerCollectionCellImages[indexPath.row]];
    return cell;
    
}

//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    ZDHOperationalDataVC *operatVC = [[ZDHOperationalDataVC alloc] init];
    operatVC.title = OperationalDataTitle;
    ZDHPlatformIntroductionVC *introductionVC = [[ZDHPlatformIntroductionVC alloc] init];
    introductionVC.title = PlatformIntroductionTitle;
    ZDHRiskControlVC *riskVC = [[ZDHRiskControlVC alloc] init];
    riskVC.title = RiskControlTitle;
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:operatVC animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:introductionVC animated:YES];
            break;
        default:
            [self.navigationController pushViewController:riskVC animated:YES];
            break;
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark  创建导航栏
- (void)createNav{
    if (getRectNavAndStatusHight == 88) {
        //iPhone X
        // 在主线程异步加载，使下面的方法最后执行，防止其他的控件挡住了导航栏
        dispatch_async(dispatch_get_main_queue(), ^{
            // 创建假的导航栏
            UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 88)];
            
            navView.backgroundColor = kMainColor;
            [self.view addSubview:navView];
            
            // 创建导航拦左边按钮
            UIButton *left = [UIButton buttonWithType:UIButtonTypeSystem];
            [left setImage:[[UIImage imageNamed:@"01-2"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            [left addTarget:self action:@selector(leftAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [navView addSubview:left];
            
            // 创建导航栏右边按钮
            UIButton *right= [UIButton buttonWithType:UIButtonTypeSystem];
            [right setImage:[[UIImage imageNamed:@"02"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            [navView addSubview:right];
            
            [right addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];
            // 创建导航栏的titleLabel
            ZDHNavigationTitleView *titleView = [[ZDHNavigationTitleView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 42, 44, 84, 44)];
            
            [navView addSubview:titleView];
            
            [left mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(16);
                make.centerY.equalTo(titleView.mas_centerY);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
            
            [right mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-13);
                make.centerY.equalTo(titleView.mas_centerY);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
        });
    }
    else {
        // 在主线程异步加载，使下面的方法最后执行，防止其他的控件挡住了导航栏
        dispatch_async(dispatch_get_main_queue(), ^{
            // 创建假的导航栏
            UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
            navView.backgroundColor = kMainColor;
            [self.view addSubview:navView];
            // 创建导航拦左边按钮
            UIButton *left = [UIButton buttonWithType:UIButtonTypeSystem];
            [left setImage:[[UIImage imageNamed:@"01-2"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            [left addTarget:self action:@selector(leftAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [navView addSubview:left];
            
            // 创建导航栏右边按钮
            UIButton *right= [UIButton buttonWithType:UIButtonTypeSystem];
            [right setImage:[[UIImage imageNamed:@"02"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            [navView addSubview:right];
            [right addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];

            // 创建导航栏的titleLabel
            ZDHNavigationTitleView *titleView = [[ZDHNavigationTitleView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, 20, 100, 44)];
            [navView addSubview:titleView];
            
            [left mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(16);
                make.centerY.equalTo(titleView.mas_centerY);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
            
            [right mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-16);
                make.centerY.equalTo(titleView.mas_centerY);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
        });
    }
    
}

- (void)messageAction:(UIButton *)sender {
    ZDHNotificationVC *messageVC = [[ZDHNotificationVC alloc] init];
    messageVC.type = 2;
    [self.navigationController pushViewController:messageVC animated:YES];
}

#pragma mark - 签到
- (void)leftAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"签到成功" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
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
