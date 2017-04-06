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
#import "Masonry.h"


@interface YYBShowLoadingWithCircleRing()
@property (strong, nonatomic)  YYBCircleRingLoadingView *loadingView;
@property (strong, nonatomic)  UILabel *tipsLabel;
@end
@implementation YYBShowLoadingWithCircleRing
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.8, 46)]) {
        self.backgroundColor = [UIColor whiteColor];
        self.tipsLabel = [UILabel new];
        self.tipsLabel.text = title;
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.font = [UIFont systemFontOfSize:16.0f];
        self.tipsLabel.textColor = [self colorWithHex:0x3a4046];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        CGRect introRect = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20)
                                               options:0 attributes:@{
                                                                      NSFontAttributeName:self.tipsLabel.font,
                                                                      NSParagraphStyleAttributeName:paragraphStyle
                                                                      } context:nil];
        CGFloat width = introRect.size.width;
        width = ceil(width);
        CGRect tempframe = self.frame;
        if (width + 15 + 30  + 10 + 15 < tempframe.size.width) {
            tempframe.size.width = width + 15 + 30  + 10 + 15;
        }
        CGFloat height=[self findHeightForText:[[NSAttributedString alloc] initWithString:title] havingWidth:width andFont:self.tipsLabel.font];
        if (height > tempframe.size.height) {
            tempframe.size.height = height ;
        }
        self.frame = tempframe;

        self.loadingView = [YYBCircleRingLoadingView new];
        
        self.loadingView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.loadingView];
        [self.loadingView show];
        self.backgroundColor = [self colorWithHex:0x6F6F6F];
        self.layer.cornerRadius = 10.0;
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.loadingView.mas_right).offset(10);
            make.right.equalTo(@(-15));
            make.centerY.equalTo(self);
        }];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(30));
            make.centerY.equalTo(self);
            make.left.equalTo(@(15));
        }];
        
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
