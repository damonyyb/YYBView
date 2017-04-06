//
//  ShowKnowInfoView.m
//  MotorolaRouter
//
//  Created by mac on 16/12/19.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import "YYBShowKnowInfoView.h"
#import "UIView+TYAlertView.h"

@implementation YYBShowKnowInfoView

- (instancetype)initWithTitle:(NSString *)title andKnowTitle:(NSString *)knowTitle
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 266, 150)]) {
        self.backgroundColor = [UIColor whiteColor];
        self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 36, 223, 40)];
        self.tipsLabel.text = title;
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.font = [UIFont systemFontOfSize:16.0f];
        self.tipsLabel.textColor = [self colorWithHex:0x3a4046];
        self.lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 106, 266, 1)];
        self.lineLab.backgroundColor = [self colorWithHex:0xdddddd];
        self.knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.knowBtn.frame = CGRectMake(0, 107, 266, 40);
        [self.knowBtn setTitle:knowTitle forState:UIControlStateNormal];
        [self.knowBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.knowBtn setTitleColor:[self colorWithHex:0x399DE3] forState:UIControlStateNormal];
        
        [self addSubview:self.tipsLabel];
        [self addSubview:self.lineLab];
        [self addSubview:self.knowBtn];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.0;
    }
    return self;
}

- (void)cancelAction:(id)sender {
    [self hideView];
    if (self.hitOkCallBack) {
        self.hitOkCallBack();
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
