//
//  ColorDefine.h
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/9.
//  Copyright © 2018年 李中航. All rights reserved.
//

#ifndef ColorDefine_h
#define ColorDefine_h

//用于存放宏定义颜色
//----------------------颜色----------------------------
#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0f green:((float)((hexValue & 0xFF00) >> 8))/255.0f blue:((float)(hexValue & 0xFF))/255.0f alpha:1.0]
#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define KRandomColor  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


#define kFont(x)                        [UIFont systemFontOfSize:x]

#define UIColorHex(hexValue)      [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0f green:((float)((hexValue & 0xFF00) >> 8))/255.0f blue:((float)(hexValue & 0xFF))/255.0f alpha:1.0]

#define kOrangeColor                    [UIColor orangeColor]
#define kBlackColor                     [UIColor blackColor]
#define kBlueColor                      [UIColor blueColor]
#define kClearColor                     [UIColor clearColor]
#define kGrayColor                      [UIColor grayColor]
#define kLightGrayColor                 [UIColor lightGrayColor]
#define kDarkGrayColor                  [UIColor darkGrayColor]
#define kWhiteColor                     [UIColor whiteColor]
#define kRedColor                       [UIColor redColor]
#define kPurpleColor                    [UIColor purpleColor]
#define KYellowColor                    [UIColor yellowColor]
#define kGreenColor                     [UIColor greenColor]

#define kGrayTextColor                  UIColorHex(0xCACACA)
#define kMainTextColor                  UIColorHex(0x333333)
#define kMainColor                      UIColorHex(0x4890F1)//主色调
#define kBackgroundColor                UIColorHex(0xEFEFF4) //TableView主背景色

//获取导航栏+状态栏的高度
#define getRectNavAndStatusHight self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
#endif /* ColorDefine_h */
