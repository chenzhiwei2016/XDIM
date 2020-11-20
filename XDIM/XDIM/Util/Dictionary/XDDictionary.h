//
//  XDDictionary.h
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDDictionary : NSObject

/**
 * 获取字典的json字符串,将中文编码
 */
+ (NSString*)getDicDescription:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
