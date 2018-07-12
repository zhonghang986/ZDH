//
//  ZDHNavigationTitleView.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/9.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHNavigationTitleView.h"

@implementation ZDHNavigationTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview];
    }
    return self;
}

- (void)addSubview {
    UIImageView *imageV = [UIImageView new];
    imageV.image = [UIImage imageNamed:@"66"];
    [self addSubview:imageV];

    __weak typeof(self) WeakSelf = self;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.centerY.equalTo(WeakSelf.mas_centerY);
    }];

    UILabel *lb = [UILabel new];
    lb.font = kFont(18);
    lb.textColor = kWhiteColor;
    lb.text = @"众贷汇";
    [self addSubview:lb];

    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV.mas_right).offset(5);
        make.centerY.equalTo(WeakSelf.mas_centerY);
    }];
    
}
- (void)layoutSubviews {
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
