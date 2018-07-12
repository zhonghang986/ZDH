//
//  ZDHPageControl.m
//  无限轮播图
//
//  Created by 李中航 on 2018/7/10.
//  Copyright © 2018年 SK丿希望. All rights reserved.
//

#import "ZDHPageControl.h"

@implementation ZDHPageControl

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIView *subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 5;
        size.width = 10;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, size.width, size.height)];
        subview.layer.cornerRadius = 2.5;
        subview.layer.masksToBounds = YES;
    }
}























/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
