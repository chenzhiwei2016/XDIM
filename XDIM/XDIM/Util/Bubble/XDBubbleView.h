//
//  XDBubbleView.h
//  XDIM
//
//  Created by 小豆 on 2020/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDBubbleView : UIView

@property (nonatomic, strong) UIColor * bubbleColor;//气泡的背景颜色 --- 默认白色

/// 绘制消息气泡
/// @param singleHeight 单行气泡的高度
/// @param isSendMessage 是否是发送消息的气泡
- (void)drawBubbleWithSingleHeight:(CGFloat)singleHeight isSendMessage:(BOOL)isSendMessage;
@end

NS_ASSUME_NONNULL_END
