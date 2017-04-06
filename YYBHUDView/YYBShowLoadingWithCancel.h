//
//  ShowLoadingWithCancel.h
//  MotorolaRouter
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 yyb. All rights reserved.
//  菊花可取消hud

#import <UIKit/UIKit.h>

typedef void(^HitCancel)();

@interface YYBShowLoadingWithCancel : UIView
@property (strong, nonatomic)  UILabel *tipsLabel;
@property (strong, nonatomic)  UILabel *moreInfoLabel;
@property (strong, nonatomic)  UIActivityIndicatorView *activityView;
@property (strong, nonatomic)  UILabel *lineLabel;
@property (strong, nonatomic)  UIButton *cancelBtn;
@property (strong, nonatomic)  HitCancel hitCancelCallBack;

- (instancetype)initWithTitle:(NSString *)title andmoreInfo:(NSString *)moreInfo;
- (void)show;
@end
