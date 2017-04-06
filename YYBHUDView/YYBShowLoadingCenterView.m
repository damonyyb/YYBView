//
//  ShowLoadingCenterView.m
//  MotorolaRouter
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import "YYBShowLoadingCenterView.h"
#import "UIView+TYAlertView.h"

@implementation YYBShowLoadingCenterView

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 260, 148)]) {
        self.backgroundColor = [UIColor whiteColor];
        self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 88, 220, 40)];
        self.tipsLabel.text = title;
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.font = [UIFont systemFontOfSize:16.0f];
        self.tipsLabel.textColor = [self colorWithHex:0x3a4046];
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activity.color = [self colorWithHex:0xAAAAAA];
        self.activity.frame = CGRectMake(110, 27, 40, 40);
        [self addSubview:self.tipsLabel];
        [self addSubview:self.activity];
        self.layer.cornerRadius = 10.0;
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
