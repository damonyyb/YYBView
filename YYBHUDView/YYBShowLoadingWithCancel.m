//
//  ShowLoadingWithCancel.m
//  MotorolaRouter
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import "YYBShowLoadingWithCancel.h"
#import "UIView+TYAlertView.h"
#import "Masonry.h"

@implementation YYBShowLoadingWithCancel


- (instancetype)initWithTitle:(NSString *)title andmoreInfo:(NSString *)moreInfo;
{
    if (self = [super initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width * 0.8, 57)]) {
        self.backgroundColor = [self colorWithHex:0x6F6F6F];
        self.tipsLabel = [UILabel new];
        self.tipsLabel.text = title;
        self.tipsLabel.textAlignment = NSTextAlignmentLeft;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.font = [UIFont systemFontOfSize:15.0f];
        self.tipsLabel.textColor = [UIColor whiteColor];
        
        self.moreInfoLabel = [UILabel new];
        self.moreInfoLabel.text = moreInfo;
        self.moreInfoLabel.textAlignment = NSTextAlignmentLeft;
        self.moreInfoLabel.numberOfLines = 0;
        self.moreInfoLabel.font = [UIFont systemFontOfSize:13.0f];
        self.moreInfoLabel.textColor = [UIColor whiteColor];
        
        self.lineLabel = [UILabel new];
        self.lineLabel.backgroundColor = [UIColor whiteColor];
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.cancelBtn setImage :[UIImage imageNamed:@"icon_cancel_yyb"] forState:0];
        [self.cancelBtn setImage:[UIImage imageNamed:@"icon_cancel_pre_yyb"] forState:UIControlStateHighlighted];
        [self.cancelBtn setImage:[UIImage imageNamed:@"icon_cancel_pre_yyb"] forState:UIControlStateSelected];
        [self.cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:self.tipsLabel];
        [self addSubview:self.activityView];
        [self addSubview:self.moreInfoLabel];
        [self addSubview:self.lineLabel];
        [self addSubview:self.cancelBtn];
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(37));
            make.left.equalTo(@(8));
            make.centerY.equalTo(self);
        }];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(33));
            make.right.equalTo(@(-8));
            make.centerY.equalTo(self);
        }];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cancelBtn.mas_left).offset(-11);
            make.top.equalTo(@(5));
            make.bottom.equalTo(@(-5));
            make.width.equalTo(@(1));
        }];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.activityView.mas_right).offset(15);
            make.right.equalTo(self.lineLabel.mas_left).offset(-15);
            if (moreInfo && moreInfo.length > 0) {
                make.centerY.equalTo(self).offset(-10);
            }else{
                make.centerY.equalTo(self);
            }
        }];

        [self.moreInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (moreInfo && moreInfo.length > 0) {
                make.left.equalTo(self.activityView.mas_right).offset(15);
                make.right.equalTo(self.lineLabel.mas_left).offset(-15);
                make.centerY.equalTo(self).offset(10);
            }else{
                make.width.height.equalTo(@(1));
                make.left.bottom.equalTo(self);
            }
        }];
        
        
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
