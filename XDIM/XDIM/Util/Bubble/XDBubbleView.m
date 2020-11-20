//
//  XDBubbleView.m
//  XDIM
//
//  Created by 小豆 on 2020/11/19.
//

#import "XDBubbleView.h"

@interface XDBubbleView ()
@property (nonatomic,assign) CGFloat m_singleHeight;
@property (nonatomic,assign) BOOL m_isSendMessage;
@end
@implementation XDBubbleView

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.bubbleColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setBubbleColor:(UIColor *)bubbleColor {
    _bubbleColor = bubbleColor;
    self.backgroundColor = bubbleColor;
}

- (void)drawBubbleWithSingleHeight:(CGFloat)singleHeight isSendMessage:(BOOL)isSendMessage {
    self.m_singleHeight = singleHeight;
    self.m_isSendMessage = isSendMessage;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self.bubbleColor set]; //设置线条颜色
    
    CGFloat sanjiao = 6;
    CGFloat coner = 6;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    
    if (self.m_isSendMessage) {
        [path moveToPoint:CGPointMake(width - sanjiao - coner, 0)];
        [path addQuadCurveToPoint:CGPointMake(width - sanjiao, coner) controlPoint:CGPointMake(width - sanjiao, 0)];
        [path addLineToPoint:CGPointMake(width - sanjiao, self.m_singleHeight/2.f - sanjiao/2.f)];
        [path addLineToPoint:CGPointMake(width, self.m_singleHeight/2.f)];//三角形的边
        [path addLineToPoint:CGPointMake(width - sanjiao, self.m_singleHeight/2.f + sanjiao/2.f)];//三角形的边
        [path addLineToPoint:CGPointMake(width - sanjiao, height - coner)];
        [path addQuadCurveToPoint:CGPointMake(width - sanjiao - coner, height) controlPoint:CGPointMake(width - sanjiao, height)];
        [path addLineToPoint:CGPointMake(coner, height)];
        [path addQuadCurveToPoint:CGPointMake(0, height - coner) controlPoint:CGPointMake(0, height)];
        [path addLineToPoint:CGPointMake(0, coner)];
        [path addQuadCurveToPoint:CGPointMake(coner, 0) controlPoint:CGPointMake(0, 0)];
    }else {
        [path moveToPoint:CGPointMake(sanjiao + coner, 0)];
        [path addQuadCurveToPoint:CGPointMake(sanjiao, coner) controlPoint:CGPointMake(sanjiao, 0)];
        [path addLineToPoint:CGPointMake(sanjiao, self.m_singleHeight/2.f - sanjiao/2.f)];
        [path addLineToPoint:CGPointMake(0, self.m_singleHeight/2.f)];//三角形的边
        [path addLineToPoint:CGPointMake(sanjiao, self.m_singleHeight/2.f + sanjiao/2.f)];//三角形的边
        [path addLineToPoint:CGPointMake(sanjiao, height - coner)];
        [path addQuadCurveToPoint:CGPointMake(sanjiao + coner, height) controlPoint:CGPointMake(sanjiao, height)];
        [path addLineToPoint:CGPointMake(width - coner, height)];
        [path addQuadCurveToPoint:CGPointMake(width, height - coner) controlPoint:CGPointMake(width, height)];
        [path addLineToPoint:CGPointMake(width, coner)];
        [path addQuadCurveToPoint:CGPointMake(width - coner, 0) controlPoint:CGPointMake(width, 0)];
    }
    
    [path closePath];
    [path fill];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    
}

@end
