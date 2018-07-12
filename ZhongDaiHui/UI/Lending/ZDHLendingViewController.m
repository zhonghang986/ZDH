//
//  ZDHLendingViewController.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/9.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHLendingViewController.h"
#import "ZDHCollectionViewCell.h"
@interface ZDHLendingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UIView *navView;
@property (nonatomic, weak) UIView *bottomLine;
@property (nonatomic, weak) UIView *baseview;
@property (nonatomic, assign) BOOL baseViewHidden;
@property (nonatomic, strong) NSMutableArray *dataAttay;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ZDHLendingViewController
- (NSMutableArray *)dataAttay {
    if (!_dataAttay) {
        _dataAttay = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataAttay;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.baseViewHidden = YES;
    NSArray *arr = @[@"标的类型：", @"年化收益：",@"借款期限：", @"项目状态："];
    [self.dataAttay addObjectsFromArray:arr];
    
    NSArray *typeArr = @[@"全部",@"车辆质押",@"企业借款"];
    NSArray *rateArr = @[@"全部",@"10%以下",@"10%-15%",@"15%以上"];
    NSArray *termArr = @[@"全部", @"3个月以下",@"3-6个月",@"6-12个月"];
    NSArray *statusArr = @[@"全部",@"可出借", @"待放款",@"还款中"];
    [self.dataSource addObject:typeArr];
    [self.dataSource addObject:rateArr];
    [self.dataSource addObject:termArr];
    [self.dataSource addObject:statusArr];
    // Do any additional setup after loading the view from its nib.
}

- (void)createNav{
    if (getRectNavAndStatusHight == 88) {
        //iPhone X
        // 在主线程异步加载，使下面的方法最后执行，防止其他的控件挡住了导航栏
        dispatch_async(dispatch_get_main_queue(), ^{
            // 创建假的导航栏
            UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 88)];
            navView.backgroundColor = kMainColor;
            [self.view addSubview:navView];
            self.navView = navView;
            UIButton *allBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [allBt setTitle:@"全部" forState:(UIControlStateNormal)];
            [allBt addTarget:self action:@selector(allAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [allBt setTintColor:kWhiteColor];
            allBt.titleLabel.font = kFont(16);
            [navView addSubview:allBt];
            
            UIButton *pledgeBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [pledgeBt setTitle:@"车辆质押" forState:(UIControlStateNormal)];
            [pledgeBt addTarget:self action:@selector(pledgeAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [pledgeBt setTintColor:kWhiteColor];
            pledgeBt.titleLabel.font = kFont(16);
            [navView addSubview:pledgeBt];
            
            UIButton *companyBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [companyBt setTitle:@"企业借款" forState:(UIControlStateNormal)];
            [companyBt addTarget:self action:@selector(companyAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [companyBt setTintColor:kWhiteColor];
            companyBt.titleLabel.font = kFont(16);
            [navView addSubview:companyBt];
            
            [allBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(44);
                make.left.offset(16);
                make.height.mas_equalTo(44);
                make.width.mas_equalTo(75);
            }];
            
            [pledgeBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(allBt.mas_centerY).offset(0);
                make.left.mas_equalTo(allBt.mas_right).offset(0);
                make.height.equalTo(allBt.mas_height);
                make.width.equalTo(allBt.mas_width);
            }];
            
            [companyBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(allBt.mas_centerY).offset(0);
                make.left.mas_equalTo(pledgeBt.mas_right).offset(16);
                make.height.equalTo(allBt.mas_height);
                make.width.equalTo(allBt.mas_width);
            }];
            
            UIView *bottomLine = [UIView new];
            bottomLine.backgroundColor = UIColorFromRGB(18, 111, 241);
            [navView addSubview:bottomLine];
            self.bottomLine = bottomLine;
            
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(navView.mas_bottom).offset(0);
                make.height.mas_equalTo(1);
                make.left.mas_equalTo(allBt.mas_left).offset(0);
                make.right.mas_equalTo(allBt.mas_right).offset(0);
            }];
            
            UIButton *seletionBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [seletionBt setImage:[[UIImage imageNamed:@"34"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            [seletionBt addTarget:self action:@selector(selectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [navView addSubview:seletionBt];
            
            [seletionBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(allBt.mas_centerY);
                make.right.mas_offset(-20);
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
            self.navView = navView;
            
            UIButton *allBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [allBt setTitle:@"全部" forState:(UIControlStateNormal)];
            [allBt addTarget:self action:@selector(allAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [allBt setTintColor:kWhiteColor];
            allBt.titleLabel.font = kFont(16);
            [navView addSubview:allBt];
            
            UIButton *pledgeBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [pledgeBt setTitle:@"车辆质押" forState:(UIControlStateNormal)];
            [pledgeBt addTarget:self action:@selector(pledgeAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [pledgeBt setTintColor:kWhiteColor];
            pledgeBt.titleLabel.font = kFont(16);
            [navView addSubview:pledgeBt];
            
            UIButton *companyBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [companyBt setTitle:@"企业借款" forState:(UIControlStateNormal)];
            [companyBt addTarget:self action:@selector(companyAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [companyBt setTintColor:kWhiteColor];
            companyBt.titleLabel.font = kFont(16);
            [navView addSubview:companyBt];
            
            [allBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(20);
                make.left.offset(16);
                make.height.mas_equalTo(44);
                make.width.mas_equalTo(75);
            }];
            
            [pledgeBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(allBt.mas_centerY).offset(0);
                make.left.mas_equalTo(allBt.mas_right).offset(0);
                make.height.equalTo(allBt.mas_height);
                make.width.equalTo(allBt.mas_width);
            }];
            
            [companyBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(allBt.mas_centerY).offset(0);
                make.left.mas_equalTo(pledgeBt.mas_right).offset(16);
                make.height.equalTo(allBt.mas_height);
                make.width.equalTo(allBt.mas_width);
            }];
            
            UIView *bottomLine = [UIView new];
            bottomLine.backgroundColor = UIColorFromRGB(18, 111, 241);
            [navView addSubview:bottomLine];
            self.bottomLine = bottomLine;
            
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(navView.mas_bottom).offset(0);
                make.height.mas_equalTo(1);
                make.left.mas_equalTo(allBt.mas_left).offset(0);
                make.right.mas_equalTo(allBt.mas_right).offset(0);
            }];
            
            UIButton *seletionBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [seletionBt setImage:[[UIImage imageNamed:@"34"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] forState:(UIControlStateNormal)];
            [seletionBt addTarget:self action:@selector(selectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [navView addSubview:seletionBt];
            
            [seletionBt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(allBt.mas_centerY);
                make.right.mas_offset(-20);
            }];
          
        });
    }
    
}

- (void)selectionAction:(UIButton *)sender {
    if (self.baseViewHidden) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *baseview = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame)+1, Main_Screen_Width, Main_Screen_Height-self.navView.frame.size.height)];
        
        baseview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [window addSubview:baseview];
        
        self.baseview = baseview;
        self.baseViewHidden = NO;
        
        [self addSelectionTableView];

    }
    else {
        [self.baseview removeFromSuperview];
        self.baseViewHidden = YES;
    }
}

- (void)addSelectionTableView {
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置区头的大小
    flowLayout.headerReferenceSize = CGSizeMake(Main_Screen_Width, 45);
    //设置item大小
    flowLayout.itemSize =CGSizeMake((Main_Screen_Width-95)/4, 31.5);
    
    
    //设置区边间距
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
    
    //设置最小间距
    
    [flowLayout setMinimumInteritemSpacing:0];
    
    [flowLayout setMinimumLineSpacing:0];
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, 415) collectionViewLayout:flowLayout];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.opaque = NO;
    
    collectionView.backgroundColor = self.view.backgroundColor;
    [collectionView registerNib:[UINib nibWithNibName:@"ZDHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.baseview addSubview:collectionView];
    
    [UIView animateWithDuration:0.5 animations:^{
        collectionView.frame = CGRectMake(0, 0, Main_Screen_Width, 415);
    }];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataAttay.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *arr = self.dataSource[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"collectionCell";
    ZDHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    NSString *str = self.dataSource[indexPath.section][indexPath.row];
    [cell.button setTitle:str forState:(UIControlStateNormal)];
    cell.button.userInteractionEnabled = NO;
    if (indexPath.row == 0) {
        cell.button.backgroundColor = kMainColor;
        [cell.button setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        cell.button.layer.borderColor = kMainColor.CGColor;
    }
    return cell;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(Main_Screen_Width, 53);
    }else{
        return CGSizeMake(Main_Screen_Width, 43);
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return CGSizeMake(Main_Screen_Width, 86);
    }else{
        return CGSizeMake(0, 0);
    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView = nil;
    // 区头
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor = kWhiteColor;
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, Main_Screen_Width, 30)];
        if (indexPath.section == 0) {
            lb.frame = CGRectMake(25, 30, Main_Screen_Width, 13);
        }
        else {
            lb.frame = CGRectMake(25, 20, Main_Screen_Width, 13);
        }
        lb.text = self.dataAttay[indexPath.section];
        lb.font = kFont(13);
        lb.textColor = UIColorFromRGB(34, 38, 42);
        [view addSubview:lb];
        reusableView = view;
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 86)];
        UIImageView *lineimage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, Main_Screen_Width-50, 1)];
        
        [footerView addSubview:lineimage];
        UIButton *resetBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
        resetBt.frame = CGRectMake(25, 41, (Main_Screen_Width-95)/2, 40);
        [resetBt setTitle:@"重置" forState:(UIControlStateNormal)];
        [resetBt setTitleColor:kMainColor forState:(UIControlStateNormal)];
        resetBt.titleLabel.font = kFont(15);
        [footerView addSubview:resetBt];
        resetBt.layer.borderColor = kMainColor.CGColor;
        resetBt.layer.borderWidth = 1;
        resetBt.layer.cornerRadius = 3;
        resetBt.layer.masksToBounds = YES;
        
        
        UIButton *selectBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
        selectBt.frame = CGRectMake(CGRectGetMaxX(resetBt.frame)+45, 41, (Main_Screen_Width-95)/2, 40);
        [selectBt setTitle:@"确定" forState:(UIControlStateNormal)];
        [selectBt setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
        selectBt.titleLabel.font = kFont(15);
        selectBt.backgroundColor = kMainColor;
        
        [footerView addSubview:selectBt];
        selectBt.layer.cornerRadius = 3;
        selectBt.layer.masksToBounds = YES;
        [footer addSubview:footerView];
        reusableView = footer;
        
    }
    return reusableView;
}


//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    NSLog(@"%ld--%ld", indexPath.section, indexPath.row);
    ZDHCollectionViewCell *cell = (ZDHCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.button.layer.borderColor = kMainColor.CGColor;
    cell.button.backgroundColor = kMainColor;
    [cell.button setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 86)];
    UIImageView *lineimage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, Main_Screen_Width-50, 1)];

    [footerView addSubview:lineimage];
    UIButton *resetBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    resetBt.frame = CGRectMake(25, 41, (Main_Screen_Width-95)/2, 40);
    [resetBt setTitle:@"重置" forState:(UIControlStateNormal)];
    [resetBt setTitleColor:kMainColor forState:(UIControlStateNormal)];
    resetBt.titleLabel.font = kFont(15);
    [footerView addSubview:resetBt];
    resetBt.layer.borderColor = kMainColor.CGColor;
    resetBt.layer.borderWidth = 1;
    resetBt.layer.cornerRadius = 3;
    resetBt.layer.masksToBounds = YES;


    UIButton *selectBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    selectBt.frame = CGRectMake(CGRectGetMaxX(resetBt.frame)+45, 41, (Main_Screen_Width-95)/2, 40);
    [selectBt setTitle:@"确定" forState:(UIControlStateNormal)];
    [selectBt setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    selectBt.titleLabel.font = kFont(15);
    selectBt.backgroundColor = kMainColor;

    [footerView addSubview:selectBt];
    selectBt.layer.cornerRadius = 3;
    selectBt.layer.masksToBounds = YES;
    return footerView;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 86;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 10;
//}

- (void)allAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [weakSelf.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sender.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(sender.mas_left).offset(0);
        make.right.mas_equalTo(sender.mas_right).offset(0);
    }];
}
- (void)pledgeAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    
    [weakSelf.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sender.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(sender.mas_left).offset(0);
        make.right.mas_equalTo(sender.mas_right).offset(0);
    }];
}

- (void)companyAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    
    [weakSelf.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sender.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(sender.mas_left).offset(0);
        make.right.mas_equalTo(sender.mas_right).offset(0);
    }];
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
