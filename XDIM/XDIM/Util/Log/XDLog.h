//
//  XDLog.h
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  使用须知
 *  在 info.list 中增加 Application supports iTunes file sharing，并将值设为YES
 *  不支持模拟器
 */

@interface XDLog : NSObject

@property (nonatomic,assign) NSInteger logSaveDate;//日志文件存储天数(>=1)，默认30天

/**
 * 日志
 */
+ (instancetype)LogManager;

/**
 * 是否开启日志  默认关闭
 */
- (void)openLog:(BOOL)open;

/**
 *  写入日志
 */
- (void)writeLog:(NSString *)logContent;



@end

NS_ASSUME_NONNULL_END
