//
//  ShowLoadingCenterView.h
//  MotorolaRouter
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 yyb. All rights reserved.
//  图片正在加载提示HUD

#import <UIKit/UIKit.h>

@interface YYBShowLoadingCenterView : UIView
@property (strong, nonatomic) UILabel *tipsLabel;
@property (strong, nonatomic) UIActivityIndicatorView *activity;


- (instancetype)initWithTitle:(NSString *)title;
- (void)show;
- (void)hide;

@end
