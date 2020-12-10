//
//  XDCheckView.m
//  XDIM
//
//  Created by 小豆 on 2020/12/9.
//

#import "XDCheckView.h"

static CGFloat lineWidth = 1.0f;
static CGFloat boxDuriation = 0.5f;
static CGFloat checkDuration = 0.2f;

@interface XDCheckView ()<CAAnimationDelegate>

@end
@implementation XDCheckView

- (void)initSetting {
    self.backgroundColor = [UIColor clearColor];
    self.isSelected = NO;
    self.unCheckColor = [UIColor grayColor];
    self.checkColor = [UIColor redColor];
    self.checkBox = Square;
    self.checkState = Right;
    self.isShowBoxAnimation = NO;
    self.isShowCheckAnimation = NO;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor clearColor] set];
    //画线条
    switch (self.checkBox) {
        case Square:[self squareBox:rect];break;
        case Circular:[self circularBox:rect];break;
        default:break;
    }
}

//设置线条颜色
- (CGColorRef)lineColor {
    return (self.isSelected == NO) ? self.unCheckColor.CGColor : self.checkColor.CGColor;
}

//正方形
- (void)squareBox:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path closePath];
    [path stroke];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor =  [[UIColor clearColor] CGColor];
    shapeLayer.strokeColor = [self lineColor];
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    if (self.isShowBoxAnimation) {
        [self drawAnimation:shapeLayer duration:boxDuriation animationName:@"SquareBoxAnimation"];
    }
    if (self.isSelected) {
        if (self.isShowCheckAnimation) {
            CGFloat durTime = 0.0;
            if (self.isShowBoxAnimation) {
                durTime = 0.8 * boxDuriation;
            }
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, durTime * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^(void){
                switch (self.checkState) {
                    case Right:[self box_right:rect layer:shapeLayer];break;
                    case Wrong:[self box_wrong:rect layer:shapeLayer];break;
                    default:
                        break;
                }
            });
        }else {
            switch (self.checkState) {
                case Right:[self box_right:rect layer:shapeLayer];break;
                case Wrong:[self box_wrong:rect layer:shapeLayer];break;
                default:
                    break;
            }
        }
    }
}

//圆形
- (void)circularBox:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGFloat radius = width/2.f;
    if (height < width) {
        radius = height/2.f;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    [path addArcWithCenter:CGPointMake(width/2.f, height/2.f) radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:YES];
    [path stroke];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor =  [[UIColor clearColor] CGColor];
    shapeLayer.strokeColor = [self lineColor];
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    if (self.isShowBoxAnimation) {
        [self drawAnimation:shapeLayer duration:boxDuriation animationName:@"CircularBoxAnimation"];
    }
    if (self.isSelected) {
        if (self.isShowCheckAnimation) {
            CGFloat durTime = 0.0;
            if (self.isShowBoxAnimation) {
                durTime = 0.8 * boxDuriation;
            }
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, durTime * NSEC_PER_SEC);
            dispatch_after(time, dispatch_get_main_queue(), ^(void){
                switch (self.checkState) {
                    case Right:[self box_right:rect layer:shapeLayer];break;
                    case Wrong:[self box_wrong:rect layer:shapeLayer];break;
                    default:
                        break;
                }
            });
        }else {
            switch (self.checkState) {
                case Right:[self box_right:rect layer:shapeLayer];break;
                case Wrong:[self box_wrong:rect layer:shapeLayer];break;
                default:
                    break;
            }
        }
    }
}

//打钩
- (void)box_right:(CGRect)rect layer:(CAShapeLayer *)shapeLayer {
    
    for (CALayer *layer in shapeLayer.sublayers) {
        [layer removeAllAnimations];
    }
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = lineWidth;
    [path moveToPoint:CGPointMake(width*2.2/10,height*5.4/10)];
    [path addLineToPoint:CGPointMake(width*4.5/10,height*7/10)];
    [path addLineToPoint:CGPointMake(width*7.8/10,height*3/10)];
    [path stroke];
    CAShapeLayer *rightLayer = [CAShapeLayer layer];
    rightLayer.frame = self.bounds;
    rightLayer.fillColor =  [[UIColor clearColor] CGColor];
    rightLayer.strokeColor = [self lineColor];
    rightLayer.lineWidth = lineWidth;
    rightLayer.path = path.CGPath;
    [shapeLayer addSublayer:rightLayer];
    
    if (self.isShowCheckAnimation) {
        [self drawAnimation:rightLayer duration:checkDuration animationName:@"RightAnimation"];
    }
}

//打叉
- (void)box_wrong:(CGRect)rect layer:(CAShapeLayer *)shapeLayer {
    
    for (CALayer *layer in shapeLayer.sublayers) {
        [layer removeAllAnimations];
    }
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = lineWidth;
    [path moveToPoint:CGPointMake(width*2.2/10,height*3/10)];
    [path addLineToPoint:CGPointMake(width*7.8/10,height*7/10)];
    [path moveToPoint:CGPointMake(width*7.8/10,height*3/10)];
    [path addLineToPoint:CGPointMake(width*2.2/10,height*7/10)];
    [path stroke];
    CAShapeLayer *rightLayer = [CAShapeLayer layer];
    rightLayer.frame = self.bounds;
    rightLayer.fillColor =  [[UIColor clearColor] CGColor];
    rightLayer.strokeColor = [self lineColor];
    rightLayer.lineWidth = lineWidth;
    rightLayer.path = path.CGPath;
    [shapeLayer addSublayer:rightLayer];
    
    if (self.isShowCheckAnimation) {
        [self drawAnimation:rightLayer duration:checkDuration animationName:@"WrongAnimation"];
    }
}

//展示绘制动画
- (void)drawAnimation:(CAShapeLayer *)shapeLayer
             duration:(CGFloat)duration
        animationName:(NSString *)animationName {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.fromValue = @(0.0f);
    animation.toValue = @(1.0f);
    animation.delegate = self;
    [animation setValue:animationName forKey:@"animationName"];
    [shapeLayer addAnimation:animation forKey:nil];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    [self setNeedsDisplay];
}

- (void)setUnCheckColor:(UIColor *)unCheckColor {
    _unCheckColor = unCheckColor;
}

- (void)setCheckColor:(UIColor *)checkColor {
    _checkColor = checkColor;
}

- (void)setCheckBox:(CHECKBOX)checkBox {
    _checkBox = checkBox;
}

- (void)setCheckState:(CHECKSTATE)checkState {
    _checkState = checkState;
}

- (void)setIsShowBoxAnimation:(BOOL)isShowBoxAnimation {
    _isShowBoxAnimation = isShowBoxAnimation;
}

- (void)setIsShowAnimation:(BOOL)isShowCheckAnimation {
    _isShowCheckAnimation = isShowCheckAnimation;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSetting];
    }
    return self;
}

@end
