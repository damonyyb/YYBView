//
//  pieview.m
//  circleTry
//
//  Created by mac on 16/12/9.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import "YYBCircleRingLoadingView.h"
#define radius 7

#define PI 3.14159265358979323846
@interface YYBCircleRingLoadingView ()
@property (nonatomic,strong) CABasicAnimation *animation;
@end
@implementation YYBCircleRingLoadingView

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画大圆
    UIColor*aColor = [UIColor darkGrayColor];
    CGContextSetFillColorWithColor(ctx, aColor.CGColor);
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius*2, 0, 2*PI, 0);
    CGContextDrawPath(ctx, kCGPathFill);
    
    //画扇形，
    aColor = [UIColor whiteColor];
    CGContextSetFillColorWithColor(ctx, aColor.CGColor);
    CGContextMoveToPoint(ctx, self.frame.size.width/2, self.frame.size.height/2);
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius*2,  -60 * PI / 180, -120 * PI / 180, 1);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill);
    
    //画填充圆
    aColor = [self colorWithHex:0x6F6F6F];
    CGContextSetFillColorWithColor(ctx, aColor.CGColor);
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius*2-2, 0, 2*PI, 0);
    CGContextDrawPath(ctx, kCGPathFill);
}

- (UIColor *)colorWithHex:(NSInteger)colorInHex
{
    return [ UIColor colorWithRed: (( float ) (( colorInHex & 0xFF0000 ) >> 16 )) / 0xFF
                            green: (( float ) (( colorInHex & 0xFF00 ) >> 8 )) / 0xFF
                             blue: (( float ) ( colorInHex & 0xFF )) / 0xFF
                            alpha: 1.0 ];
}

- (void)show{
    // 添加隐式动画
    _animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _animation.duration = 1;
    _animation.toValue = @(2*M_PI);
    _animation.repeatCount = MAXFLOAT;
    self.alpha = 0.f;
    // 显示并执行动画
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.f;
        [self.layer addAnimation:_animation forKey:nil];
    }];
}
-(void)hide {
    [UIView animateWithDuration:0.3f animations:^{
        // _animation.repeatCount = 0;
        self.alpha = 0.f;
    }completion:^(BOOL finished) {
        _animation.repeatCount = MAXFLOAT;
    }];
}
@end
