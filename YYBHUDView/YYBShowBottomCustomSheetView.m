//
//  ShowBottomCustomSheetView.m
//  MotorolaRouter
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 yyb. All rights reserved.
//
#import "YYBShowBottomCustomSheetView.h"
#import "YYBSheetDetailItemView.h"
#import "Masonry.h"
#define SCREEN_BOUNDS         [UIScreen mainScreen].bounds
#define btnHegith             49.0f
#define gap             6.0f

@implementation YYBShowBottomCustomSheetView
{
    UIView *_contentView;
    CGFloat _headViewHeight;
    CGFloat _contentHeight;
    CGFloat _bottomViewHeight;
    NSArray *_otherTitles;
    UIView *_viewHead;
    UIView *_viewBody;
    NSString *_chooseTitle;
    NSString *_tittle;
    NSString *_cancelTitle;
    NSString *_confirmItem;
}

- (instancetype)initWithTitle:(NSString *)title
                  otherTitles:(NSArray *)otherTitles
               andCancelTitle:(NSString *)cancelTitle
                andChooseItem:(NSString *)chooseItem
               andConfirmItem:(NSString *)confirmItem
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _otherTitles = otherTitles;
        _tittle = title;
        _cancelTitle = cancelTitle;
        _contentView = [UIView new];
        _chooseTitle = chooseItem;
        _confirmItem = confirmItem;
        _contentView.backgroundColor = [UIColor clearColor];
        //表头   表身  中间间隔 表尾
        _bottomViewHeight = _confirmItem ? btnHegith *2+gap: btnHegith+gap;
        CGFloat height=  [self findHeightForText:[[NSAttributedString alloc] initWithString:_tittle]
                                     havingWidth:320
                                         andFont:[UIFont systemFontOfSize:14.0f]];
        _headViewHeight = height+24;
        _contentHeight = _headViewHeight +(_otherTitles.count) *btnHegith+_bottomViewHeight;
        _contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, _contentHeight);
        [self contentViewAddSubViewsWithTitle:_tittle
                                  otherTitles:_otherTitles];
        [self addSubview:_contentView];
    }
    return self;
}


- (void)contentViewAddSubViewsWithTitle:(NSString *)title
                            otherTitles:(NSArray *)otherTitles
{
    _viewHead = [self createViewHead:title];
    [_contentView addSubview:_viewHead];
    [_viewHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_headViewHeight));
        make.left.and.right.and.top.equalTo(_contentView);
    }];
    _viewBody = [UIView new];
    [_contentView addSubview:_viewBody];
    [_viewBody mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(otherTitles.count*btnHegith));
        make.left.and.right.equalTo(_contentView);
        make.top.mas_equalTo(_viewHead.mas_bottom);
    }];
    [self addBodySubViewsWithBody:_viewBody
                      otherTitles:otherTitles];
    
    UIView *viewFooter = [UIView new];
    [_contentView addSubview:viewFooter];
    if (_confirmItem) {
        [self createViewFooter:viewFooter andTittles:@[_confirmItem,_cancelTitle]];
    }else{
        [self createViewFooter:viewFooter andTittles:@[_cancelTitle]];
    }
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_bottomViewHeight));
        make.left.and.right.and.bottom.equalTo(_contentView);
    }];
}


- (UIView *)createViewHead:(NSString *)title
{
    UIView *viewHead = [UIView new];
    viewHead.backgroundColor = [UIColor whiteColor];
    UILabel *label = [self customLabel:NO];
    label.text = title;
    CGFloat height=  [self findHeightForText:[[NSAttributedString alloc] initWithString:title]
                                 havingWidth:320
                                     andFont:[UIFont systemFontOfSize:14.0f]];
    UILabel *linLabel1 = [self customlinLine];
    [viewHead addSubview:label];
    [viewHead addSubview:linLabel1];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewHead);
        make.width.mas_equalTo(@(320));
        make.top.mas_equalTo(@(12));
        make.height.mas_equalTo(@(height));
        make.bottom.mas_equalTo(@(-12));
    }];
    [linLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.and.right.and.bottom.equalTo(viewHead);
    }];
    return viewHead;
}


- (void)addBodySubViewsWithBody:(UIView  *)viewBody
                    otherTitles:(NSArray *)otherTitles
{
    UIView *lastView = nil;
    for (NSInteger i=0; i<otherTitles.count; i++) {
        YYBSheetDetailItemView  *sheetDetailItemView = [YYBSheetDetailItemView new];
        [viewBody addSubview:sheetDetailItemView];
        BOOL choose = [otherTitles[i] isEqualToString:_chooseTitle] ? YES : NO;
        [sheetDetailItemView createDetailView:otherTitles[i] andChoose:choose];
        sheetDetailItemView.btn.tag = i;
        
        sheetDetailItemView.callBtnClicked = ^(NSInteger tag) {
            if (![_chooseTitle isEqualToString:_otherTitles[i]]) {
                if (self.callSelectedNumBack) {
                    self.callSelectedNumBack(tag);
                }
            }
            [self hideAnimation];
        };
        
        [sheetDetailItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentView);
            make.height.mas_equalTo(@(btnHegith));
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                make.top.mas_equalTo(viewBody.mas_top);
            }
        }];
        if (i == otherTitles.count -1) {
            [sheetDetailItemView spandLabelToPadding];
        }
        lastView = sheetDetailItemView;
    }
}


- (void)createViewFooter:(UIView  *)viewFooter andTittles:(NSArray *)titles
{
    viewFooter.backgroundColor = [UIColor whiteColor];
    UIView *lastView = nil;
    for (NSInteger i=0; i<titles.count; i++) {
        UIButton *btn = [self customButton2:titles[i]];
        [viewFooter addSubview:btn];
        btn.tag = titles.count-i+1000 -1;
        [btn addTarget:self action:@selector(footerBtnClicked:)
                  forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(_contentView);
            make.height.mas_equalTo(@(btnHegith));
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                make.top.mas_equalTo(viewFooter.mas_top);
            }
        }];
        lastView = btn;
    }

    UIView *view = [UIView new];
    view.backgroundColor = [self colorWithHex:0xf3f4f6];
    [viewFooter addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(gap));
        make.left.and.right.equalTo(viewFooter);
        make.top.mas_equalTo(lastView.mas_top);
    }];
}


- (void)footerBtnClicked:(UIButton *)sender
{
    if (sender.tag - 1000 != 0) {
        if (self.callFooterViewBtnClickedBack) {
            self.callFooterViewBtnClickedBack(sender.tag - 1000);
        }
    }
    [self hideAnimation];
}


- (void)show
{

    self.userInteractionEnabled = NO;
    [self setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0]];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.6]];
        _contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-_contentHeight, [UIScreen mainScreen].bounds.size.width, _contentHeight);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        if (self.callShowSuccess) {
            self.callShowSuccess(YES);
        }
    }];
}


- (void)hideAnimation
{
    [self setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0]];
        _contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, _contentHeight);
    }completion:^(BOOL finished) {
        if (finished) {
            [self directHide];
        }
    }];
}

- (void)directHide
{
    self.userInteractionEnabled = YES;
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (CGFloat)findHeightForText:(NSAttributedString *)text
                 havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    [textView setFont:font];
    CGSize size = [textView sizeThatFits:CGSizeMake(widthValue, FLT_MAX)];
    return size.height;
}


- (UIColor *)colorWithHex:(NSInteger)colorInHex
{
    return [ UIColor colorWithRed: (( float ) (( colorInHex & 0xFF0000 ) >> 16 )) / 0xFF
                            green: (( float ) (( colorInHex & 0xFF00 ) >> 8 )) / 0xFF
                             blue: (( float ) ( colorInHex & 0xFF )) / 0xFF
                            alpha: 1.0 ];
}


- (UILabel *)customlinLine
{
    UILabel *linLabel = [[UILabel alloc] init];
    linLabel.backgroundColor = [self colorWithHex:0xDDDDDD];
    return linLabel;
}


- (UILabel *)customLabel:(BOOL)alignmentleft
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.numberOfLines = 0;
    label.textAlignment = alignmentleft ? NSTextAlignmentLeft :NSTextAlignmentCenter;
    label.textColor = [self colorWithHex:0x82878D];
    label.backgroundColor = [UIColor whiteColor];
    return label;
}


- (UIButton *)customButton2:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [btn setTitleColor:[self colorWithHex:0x3a4046] forState:0];
    btn.backgroundColor = [UIColor whiteColor];
    return btn;
}

@end
