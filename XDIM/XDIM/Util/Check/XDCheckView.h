//
//  XDCheckView.h
//  XDIM
//
//  Created by 小豆 on 2020/12/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CHECKBOX) {
    Square, //正方形
    Circular, //圆形
};

typedef NS_ENUM(NSUInteger, CHECKSTATE) {
    Right,  //打钩
    Wrong,  //打叉
};

@interface XDCheckView : UIView
//是否选中 --- 默认未选中
@property (nonatomic,assign) BOOL isSelected;

#pragma ---- 颜色
//未选中状态下的颜色 --- 默认灰色
@property (nonatomic, strong) UIColor * unCheckColor;
//选中状态下的颜色 --- 默认红色
@property (nonatomic, strong) UIColor * checkColor;

#pragma ---- 形状
//外框形状 --- 默认正方形
@property (nonatomic,assign) CHECKBOX checkBox;
//标记 --- 默认打钩
@property (nonatomic,assign) CHECKSTATE checkState;

#pragma ---- 动画
//是否展示外框动画 --- 默认不展示
@property (nonatomic,assign) BOOL isShowBoxAnimation;
//是否展示打钩或者打叉动画 --- 默认不展示
@property (nonatomic,assign) BOOL isShowCheckAnimation;
@end

NS_ASSUME_NONNULL_END
