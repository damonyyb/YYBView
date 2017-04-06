//
//  SheetDetailItemView.h
//  MotorolaRouter
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 yyb. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CallBtnClicked) (NSInteger tag);

@interface YYBSheetDetailItemView : UIView

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) CallBtnClicked callBtnClicked;

- (void)createDetailView:(NSString *)title andChoose:(BOOL)choose;
- (void)spandLabelToPadding;


@end
