//
//  ShowLoadingCenterView.m
//  MotorolaRouter
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import "YYBShowLoadingCenterView.h"
#import "UIView+TYAlertView.h"
#import "Masonry.h"

@implementation YYBShowLoadingCenterView

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.7, 148)]) {
        self.backgroundColor = [UIColor whiteColor];
        self.tipsLabel = [UILabel new];
        self.tipsLabel.text = title;
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.font = [UIFont systemFontOfSize:16.0f];
        self.tipsLabel.textColor = [self colorWithHex:0x3a4046];
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activity.color = [self colorWithHex:0xAAAAAA];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.activity];
        self.layer.cornerRadius = 10.0;
        [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(40));
            make.top.equalTo(@(27));
            make.centerX.equalTo(self);
        }];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(20));
            make.right.equalTo(@(-20));
            make.top.equalTo(self.activity.mas_bottom).offset(20);
        }];
    }
    return self;
}


- (void)show
{
    if (!self.activity.isAnimating) {
         [self.activity startAnimating];
    }
    [self  showInWindow];
}


- (void)hide
{
    if (self.activity.isAnimating) {
        [self.activity stopAnimating];
    }
    [self hideView];
}



- (UIColor *)colorWithHex:(NSInteger)colorInHex
{
    return [ UIColor colorWithRed: (( float ) (( colorInHex & 0xFF0000 ) >> 16 )) / 0xFF
                            green: (( float ) (( colorInHex & 0xFF00 ) >> 8 )) / 0xFF
                             blue: (( float ) ( colorInHex & 0xFF )) / 0xFF
                            alpha: 1.0 ];
}
@end
