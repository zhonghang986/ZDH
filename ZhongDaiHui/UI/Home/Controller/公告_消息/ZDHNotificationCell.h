//
//  ZDHNotificationCell.h
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/11.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDHNotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *content;
- (void)setValueForSubViews;
@end
