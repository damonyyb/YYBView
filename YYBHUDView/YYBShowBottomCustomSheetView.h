//
//  ShowBottomCustomSheetView.h
//  MotorolaRouter
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 yyb. All rights reserved.
//  底部弹框

#import <UIKit/UIKit.h>
typedef void (^CallSelectedNumBack) (NSInteger tag);
typedef void (^CallFooterViewBtnClickedBack) (NSInteger tag);
typedef void (^CallShowSuccess) (BOOL success);
@interface YYBShowBottomCustomSheetView : UIView
- (instancetype)initWithTitle:(NSString *)title
                  otherTitles:(NSArray *)otherTitles
               andCancelTitle:(NSString *)cancelTitle
               andChooseItem:(NSString *)chooseItem
            andConfirmItem:(NSString *)confirmItem;
- (void)show;
- (void)hideAnimation;
- (void)directHide;

@property (nonatomic,strong) CallSelectedNumBack callSelectedNumBack;
@property (nonatomic,strong) CallFooterViewBtnClickedBack callFooterViewBtnClickedBack;
@property (nonatomic,strong) CallShowSuccess callShowSuccess;
@end
