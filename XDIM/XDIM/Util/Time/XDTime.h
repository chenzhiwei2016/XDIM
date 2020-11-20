//
//  XDTime.h
//  XDIM
//
//  Created by 小豆 on 2020/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDTime : NSObject
//获取当前时间
+ (NSString *)getCurrentDate;
//获取时间戳
+ (NSString *)getCurrentTimeStamp;
//时间戳取差值
+ (long long)getDurationStartTime:(NSString *)startTime endTime:(NSString *)endTime;
//计算时间差 --- 返回秒
+ (NSString *)pleaseInsertStarTime:(NSString *)startTime andInsertEndTime:(NSString *)endTime;
@end

NS_ASSUME_NONNULL_END
