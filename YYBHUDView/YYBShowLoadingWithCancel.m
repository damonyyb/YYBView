//
//  ShowLoadingWithCancel.m
//  MotorolaRouter
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import "YYBShowLoadingWithCancel.h"
#import "UIView+TYAlertView.h"


@implementation YYBShowLoadingWithCancel


- (instancetype)initWithTitle:(NSString *)title andmoreInfo:(NSString *)moreInfo;
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 300, 57)]) {
        self.backgroundColor = [self colorWithHex:0x6F6F6F];
        self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 12, 186, 18)];
        self.tipsLabel.text = title;
        self.tipsLabel.textAlignment = NSTextAlignmentLeft;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.font = [UIFont systemFontOfSize:15.0f];
        self.tipsLabel.textColor = [UIColor whiteColor];
        
        self.moreInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 31, 186, 16)];
        self.moreInfoLabel.text = moreInfo;
        self.moreInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.moreInfoLabel.numberOfLines = 0;
        self.moreInfoLabel.font = [UIFont systemFontOfSize:13.0f];
        self.moreInfoLabel.textColor = [UIColor whiteColor];
        
        self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(248, 9, 1, 40)];
        self.lineLabel.backgroundColor = [UIColor whiteColor];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.cancelBtn setImage :[UIImage imageNamed:@"icon_cancel_yyb"] forState:0];
        [self.cancelBtn setImage:[UIImage imageNamed:@"icon_cancel_pre_yyb"] forState:UIControlStateHighlighted];
        [self.cancelBtn setImage:[UIImage imageNamed:@"icon_cancel_pre_yyb"] forState:UIControlStateSelected];
        [self.cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn.frame = CGRectMake(259, 13, 33, 32);
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityView.frame = CGRectMake(8, 10, 37, 37);
        [self addSubview:self.tipsLabel];
        [self addSubview:self.activityView];
        [self addSubview:self.moreInfoLabel];
        [self addSubview:self.lineLabel];
        [self addSubview:self.cancelBtn];
        
        self.layer.cornerRadius = 8.0;
    }
    return self;
}

- (void)show
{
    if (!self.activityView.isAnimating) {
        [self.activityView startAnimating];
    }
    [self showInWindow];
}


- (void)cancel:(UIButton *)sender {
    [self hideView];
    if (self.hitCancelCallBack) {
        self.hitCancelCallBack();
    }
}

- (UIColor *)colorWithHex:(NSInteger)colorInHex
{
    return [ UIColor colorWithRed: (( float ) (( colorInHex & 0xFF0000 ) >> 16 )) / 0xFF
                            green: (( float ) (( colorInHex & 0xFF00 ) >> 8 )) / 0xFF
                             blue: (( float ) ( colorInHex & 0xFF )) / 0xFF
                            alpha: 1.0 ];
}
@end
