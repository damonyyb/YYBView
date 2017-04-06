//
//  ShowLoadingWithCircleRing.m
//  MotorolaRouter
//
//  Created by mac on 17/3/15.
//  Copyright © 2017年 yyb. All rights reserved.
//

#import "YYBShowLoadingWithCircleRing.h"
#import "YYBCircleRingLoadingView.h"
#import "UIView+TYAlertView.h"
@interface YYBShowLoadingWithCircleRing()
@property (strong, nonatomic)  YYBCircleRingLoadingView *loadingView;
@property (strong, nonatomic)  UILabel *tipsLabel;
@end
@implementation YYBShowLoadingWithCircleRing
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 180, 46)]) {
         CGFloat height=[self findHeightForText:[[NSAttributedString alloc] initWithString:title] havingWidth:102 andFont:[UIFont systemFontOfSize:16.0f]];
        if (self.frame.size.height<height) {
            self.frame = CGRectMake(0, 0, 180, height);
        }
        self.backgroundColor = [UIColor whiteColor];
        self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, (self.frame.size.height-height)/2, 110, height)];
        self.tipsLabel.text = title;
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.font = [UIFont systemFontOfSize:16.0f];
        self.tipsLabel.textColor = [self colorWithHex:0x3a4046];
        self.loadingView = [[YYBCircleRingLoadingView alloc] initWithFrame:CGRectMake(14,(self.frame.size.height-30)/2 , 30, 30)];
        self.loadingView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.loadingView];
        [self.loadingView show];
        self.backgroundColor = [self colorWithHex:0x6F6F6F];
        self.layer.cornerRadius = 10.0;
    }
    return self;
}


- (UIColor *)colorWithHex:(NSInteger)colorInHex
{
    return [ UIColor colorWithRed: (( float ) (( colorInHex & 0xFF0000 ) >> 16 )) / 0xFF
                            green: (( float ) (( colorInHex & 0xFF00 ) >> 8 )) / 0xFF
                             blue: (( float ) ( colorInHex & 0xFF )) / 0xFF
                            alpha: 1.0 ];
}

- (CGFloat)findHeightForText:(NSAttributedString *)text
                 havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    [textView setFont:font];
    CGSize size = [textView sizeThatFits:CGSizeMake(widthValue, FLT_MAX)];
    return size.height;
}

@end
