//
//  XDTime.m
//  XDIM
//
//  Created by 小豆 on 2020/11/19.
//

#import "XDTime.h"

@implementation XDTime
//获取当前时间
+ (NSString *)getCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

//获取时间戳
+ (NSString *)getCurrentTimeStamp {
    NSDate *datenow = [NSDate date];//现在时间
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    NSString *ts = [NSString stringWithFormat:@"%ld",(long)timeSp];//时间戳的值
    return ts;
}

/**持续时间*/
+ (long long)getDurationStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    if (startTime && endTime) {
        long long aTime = [endTime longLongValue] - [startTime longLongValue];
        return aTime;
    } else {
        return -1;
    }
}

///计算时间差 --- 返回秒
+ (NSString *)pleaseInsertStarTime:(NSString *)startTime andInsertEndTime:(NSString *)endTime {
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:startTime];
    NSDate *date2 = [formatter dateFromString:endTime];
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    NSInteger mint = ((cmps.year * (365 * 24 * 60  * 60)) + (cmps.month * (30 * 24 * 60 * 60)) + (cmps.day * (24 * 60 * 60)) + (cmps.hour * (60 * 60)) + (cmps.minute * (60)) + cmps.second);
    return [NSString stringWithFormat:@"%d",(int)mint];
}
@end
