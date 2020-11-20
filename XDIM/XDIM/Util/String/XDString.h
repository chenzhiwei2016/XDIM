//
//  XDString.h
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDString : NSObject

/**
 *判断字符串是否为非空
 *@param string destination string
 *@return YES or NO
 */
+(BOOL)checkIsNotEmptyString:(NSString *)string;

/**
 *处理空字符串
 *@param string destination string
 *@return 处理过的字符串
 */
+(NSString *)dealEmptyString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
