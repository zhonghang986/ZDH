//
//  DES3EncryptUtil.h
//  DES3加解密工具
//
//  Created by xc on 15/12/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3EncryptUtil : NSObject

// DES加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// DES解密方法
+ (NSString*)decrypt:(NSString*)encryptText;
+(NSString *)md5:(NSString *)md5Str;//MD5加密
+(NSString *)timeCompute;//获取时间差 需要md5加密的字符串
@end
