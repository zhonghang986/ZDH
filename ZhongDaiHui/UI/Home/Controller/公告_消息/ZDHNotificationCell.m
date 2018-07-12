//
//  ZDHNotificationCell.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/11.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHNotificationCell.h"

@implementation ZDHNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setValueForSubViews {
    self.Title.text = @"关于富民银行存管通知关于富民银行存管通知关于富民银行存管通知关于富民银行存管通知";
    self.content.text = @"关于富民银行存管通关于富民银行存管通知关于富民银行存管通关于富民银行存管通知关于富民银行存管通关于富民银行存管通知关于富民银行存管通关于富民银行存管通知关于富民银行存管通关于富民银行存管通知关于富民银行存管通关于富民银行存管通知";
    
    //富文本方式设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 7;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
    self.content.attributedText = [[NSAttributedString alloc]initWithString:self.content.text attributes:attributes];
    [self.content sizeToFit];
//    NSLog(@"设置富文本后,lineBreakMode样式 : %ld",(long)label.lineBreakMode);
    
    //将lineBreakMode样式改回在末尾显示省略号的样式
    self.content.lineBreakMode = NSLineBreakByTruncatingTail;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
