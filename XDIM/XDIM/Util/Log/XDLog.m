//
//  XDLog.m
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import "XDLog.h"
#import <UIKit/UIKit.h>

@interface XDLog ()
@property (nonatomic,assign) BOOL isOpenLog; //是否打开日志存储
@end

@implementation XDLog
/**
 * 日志
 */
+ (instancetype)LogManager {
    static XDLog *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XDLog alloc] init];
    });
    return manager;
}

- (void)setLogSaveDate:(NSInteger)logSaveDate {
    _logSaveDate = logSaveDate;
}

/**
 * 是否开启日志  默认关闭
 */
- (void)openLog:(BOOL)open {
    self.isOpenLog = open;
    if (open) {
        NSInteger logDay = [self compareCurrentDateWithLogDate];
        if (self.logSaveDate < 1) {
            self.logSaveDate = 30;
        }
        if (logDay > self.logSaveDate) {
            //删除日志文件
            [self deleteLogFile];
        }
        //创建日志文件
        [self createLogFile];
        
        //未捕获的Objective-C异常日志
        NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    }
}

//获取日志文件路径
- (NSString *)getLogFilePath {
    //将NSlog打印信息保存到Document目录下的XDLog.log中
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"XDLog.log"];//注意不是NSData!
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    return logFilePath;
}

/**
 * 创建日志文件
 */
- (void)createLogFile {
    UIDevice *device = [UIDevice currentDevice];
    //在模拟器不保存到文件中
    if([[device model] hasSuffix:@"Simulator"]){
        return;
    }
    //获取Log路径
    NSString *logFilePath = [self getLogFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logFilePath]) {
        //将log输入到文件
        //printf 会向标准输出(sedout)打印
        //NSLog  是向标准出错(stderr)打印
        freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
        freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    }
    //如果没有取出日志时间则保存当前时间
    if ([[self getLogDate] isEqualToString:@""]) {
        [self saveLogDate];
    }
    
}

/**
 * 删除日志文件
 */
- (void)deleteLogFile {
    NSString *logFilePath = [self getLogFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:logFilePath]) {
        [fileManager removeItemAtPath:logFilePath error:nil];
    }
    [self clearLogDate];
}

/**
 *  写入日志
 */
- (void)writeLog:(NSString *)logContent {
    if (!self.isOpenLog) {
        return;
    }
    //处理日志格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logStr = [NSString stringWithFormat:@"【XD------PrintStart】\r\n【- %@ -】console:%@\r\n【XD------PrintEnd】\r\n\r\n",dateStr,logContent];
    
    //获取Log路径
    NSString *logFilePath = [self getLogFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [logStr writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else {
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[logStr dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
}

void UncaughtExceptionHandler(NSException* exception)
{
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ];
    //异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ];
    //将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [strSymbols appendString: item ];
        [strSymbols appendString: @"\r\n" ];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"XDLog.log"];//注意不是NSData!
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *crashString = [NSString stringWithFormat:@"【XD------CrashStart】\r\n【- %@ -】[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]\r\n【XD------CrashEnd】\r\n\r\n", dateStr, name, reason, strSymbols];
    
    //把错误日志写到文件中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    //把错误日志发送到邮箱
    //   NSString *urlStr = [NSString stringWithFormat:@"mailto://test@163.com?subject=bug报告&body=感谢您的配合!<br><br><br>错误详情:<br>%@",crashString ];
    //    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    [[UIApplication sharedApplication] openURL:url];
}

/**
 * 日志每隔30天删除一次
 */
//存储日志文件创建日期
- (void)saveLogDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    [[NSUserDefaults standardUserDefaults] setValue:dateStr forKey:@"LOGDATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取日志文件的创建日期
- (NSString *)getLogDate {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"LOGDATE"];
}
//清空日志文件时间
- (void)clearLogDate {
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"LOGDATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//比较当前日期和创建日志文件的日期
- (NSInteger)compareCurrentDateWithLogDate {
    NSInteger day = 0;
    NSString *logDate = [self getLogDate];
    //如果没有取出日志时间则默认为0
    if ([logDate isEqualToString:@""]) {
        return day;
    }
    
    //获取当前日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *startDate = [dateFormatter dateFromString:logDate];
    NSDate *endDate = [dateFormatter dateFromString:currentDateStr];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
    //比较的结果是NSDateComponents类对象
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    day = delta.day;
    return day;
}

@end
