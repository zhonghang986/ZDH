//
//  ZDHLaunchImage.m
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/5/23.
//  Copyright © 2018年 李中航. All rights reserved.
//

#import "ZDHLaunchImage.h"

@implementation ZDHLaunchImage

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animation) name:@"LaunchIamge" object:nil];
        
        self.image = [UIImage imageWithContentsOfFile:@"Launch"];
        
        self.animationImages = self.imageArray;

        self.animationRepeatCount = 1;
 
        self.animationDuration = 3;
    
    }
    return self;
}

- (void)animation {
    [self startAnimating];
    
    __block NSInteger second = 3;
   
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                [self stopAnimating];
                [self removeFromSuperview];
                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LaunchIamge" object:nil];
                dispatch_cancel(timer);
            } else {
                
                second--;
            }
        });
    });

    dispatch_resume(timer);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
