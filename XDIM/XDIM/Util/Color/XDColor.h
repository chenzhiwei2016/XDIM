//
//  XDColor.h
//  XDIM
//
//  Created by 小豆 on 2020/11/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDColor : NSObject
/**
 *  根据十六进制字符串获得颜色
 *
 *  @param color 十六进制字符串
 *
 *  @return 颜色
 */
+ (UIColor *)GetColor:(NSString *)color;
/**
 *  根据十六进制字符串获得颜色
 *
 *  @param color 十六进制字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)GetColor:(NSString *)color alpha:(CGFloat)alpha;
/**
 *  获取随机颜色
 */
+ (UIColor *)GetRandomColor;

@end

NS_ASSUME_NONNULL_END
