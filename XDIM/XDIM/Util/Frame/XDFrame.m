//
//  XDFrame.m
//  XDIM
//
//  Created by 小豆 on 2020/12/2.
//

#import "XDFrame.h"

@implementation XDFrame

/*
 * 获取高尺寸
 */
+(CGFloat)getHeightSwitchInch:(CGFloat)inch {
    return inch/1334 * [[UIScreen mainScreen] bounds].size.height;
}
/*
 * 获取宽尺寸
 */
+(CGFloat)getWidthSwitchInch:(CGFloat)inch {
    return inch/750 * [[UIScreen mainScreen] bounds].size.width;
}

@end
