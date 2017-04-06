//
//  ShowKnowInfoView.h
//  MotorolaRouter
//
//  Created by mac on 16/12/19.
//  Copyright © 2016年 yyb. All rights reserved.
//  提示并确定信息

#import <UIKit/UIKit.h>
typedef void(^HitOK)();

@interface YYBShowKnowInfoView : UIView

@property (strong, nonatomic)  UILabel *tipsLabel;
@property (strong, nonatomic)  UILabel *lineLab;
@property (strong, nonatomic)  UIButton *knowBtn;

- (instancetype)initWithTitle:(NSString *)title andKnowTitle:(NSString *)knowTitle;
@property (nonatomic,strong) HitOK hitOkCallBack;
@end
