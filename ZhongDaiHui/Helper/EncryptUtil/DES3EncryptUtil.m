//
//  DES3EncryptUtil.m
//  DES3加解密工具
//  Created by xc on 15/12/18.
//  Copyright © 2015年 xc. All rights reserved.

#import "DES3EncryptUtil.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "MyBase64.h"

//秘钥
#define gkey            @"123456789012345678901234"
//向量
#define gIv             @"01234567"

#define gtime           @"2000-01-01 00:00:00" //时间差的最开始时间
@implementation DES3EncryptUtil

+ (NSString *)timeCompute{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *lastDate = [formatter dateFromString:gtime];
    NSTimeInterval firstStamp = [lastDate timeIntervalSince1970];
    
    NSDate *second = [NSDate date];
    NSTimeInterval secondTimeZone = [second timeIntervalSince1970];
    
    double min =  secondTimeZone - firstStamp;
    int s = min / 60;
    NSString *ser = [NSString stringWithFormat:@"%d", s];
    NSString *ser1 =[ser substringWithRange:NSMakeRange(0, ser.length -2)];
    return ser1;
}

+(NSString *)md5:(NSString *)md5Str{
    md5Str = [NSString stringWithFormat:@"%@%@", md5Str, gIv];//字符串拼接key 进行加密
    const char *cStr = [md5Str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
    
}
// 加密方法
+ (NSString*)encrypt:(NSString*)plainText {
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [MyBase64 base64EncodedStringFrom:myData];
    
    result = [result stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    result = [result stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    return result;
}

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText {
    encryptText = [encryptText stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    encryptText = [encryptText stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    NSData *encryptData = [MyBase64 dataWithBase64EncodedString:encryptText];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    return result;
}

@end
