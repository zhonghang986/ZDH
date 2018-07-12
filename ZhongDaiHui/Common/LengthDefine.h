//
//  LengthDefine.h
//  ZhongDaiHui
//
//  Created by 李中航 on 2018/7/9.
//  Copyright © 2018年 李中航. All rights reserved.
//

#ifndef LengthDefine_h
#define LengthDefine_h

//获取导航栏+状态栏的高度
#define getRectNavAndStatusHight self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#endif /* LengthDefine_h */
