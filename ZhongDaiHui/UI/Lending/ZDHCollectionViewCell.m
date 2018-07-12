//
//  ZDHCollectionViewCell.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/9.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHCollectionViewCell.h"

@implementation ZDHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.button.layer.cornerRadius = 3;
    self.button.layer.borderWidth = 1;
    self.button.layer.borderColor = UIColorFromRGB(78, 82, 86).CGColor;
    self.button.layer.masksToBounds = YES;
    // Initialization code
}

@end
