//
//  ZDHHomeCell.h
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/10.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDHHomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *borrowType;
@property (weak, nonatomic) IBOutlet UILabel *term;
@property (weak, nonatomic) IBOutlet UILabel *Amount;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *activity;
@property (weak, nonatomic) IBOutlet UIImageView *interestRateImage;
@property (weak, nonatomic) IBOutlet UILabel *interestRate;

@end
