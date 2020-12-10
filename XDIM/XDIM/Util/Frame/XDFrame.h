//
//  XDFrame.h
//  XDIM
//
//  Created by 小豆 on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDFrame : NSObject
/*
 * 获取高尺寸
 */
+(CGFloat)getHeightSwitchInch:(CGFloat)inch;
/*
 * 获取宽尺寸
 */
+(CGFloat)getWidthSwitchInch:(CGFloat)inch;
@end

NS_ASSUME_NONNULL_END
