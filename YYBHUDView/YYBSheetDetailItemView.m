//
//  SheetDetailItemView.m
//  MotorolaRouter
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 yyb. All rights reserved.
//

#import "YYBSheetDetailItemView.h"
#import "Masonry.h"
#define btnHegith             49.0f
@implementation YYBSheetDetailItemView
{
    UILabel *_linLabel;
}

- (void)createDetailView:(NSString *)title andChoose:(BOOL)choose
{
    [self setUpViewWithTitle:title andChoose:choose];
}

- (void)setUpViewWithTitle:(NSString *)title andChoose:(BOOL)choose
{
    self.backgroundColor = [UIColor whiteColor];
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.titleLab = [self customLabel:YES];
    if ([self isNeedToCut:title]) {
        NSString *firstStr = [self handleStringWithString:title];
        NSString *secondStr = [self innerStringWithString:title];
        self.titleLab.attributedText = [self creatAttributedStringWithString:firstStr andSecStr:secondStr];
    }else{
        self.titleLab.text = title;
        self.titleLab.textColor = [self colorWithHex:0x82878d];
    }
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 24, 0, 0));
    }];
    
    _linLabel = [self customlinLine];
    [self addSubview:_linLabel];
    [_linLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.equalTo(@(24));
        make.right.equalTo(@(-24));
        make.bottom.equalTo(self);
    }];

    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:@"icon_checked_yyb"];
    self.imgView.hidden = !choose;
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(-24));
        make.width.and.height.mas_equalTo(@(21));
        make.centerY.equalTo(self);
    }];
}

- (void)spandLabelToPadding
{
    [_linLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
    }];
}

- (BOOL)isNeedToCut:(NSString *)str
{
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    NSRange range = [muStr rangeOfString:@"("];
    if (range.location != NSNotFound) {
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)handleStringWithString:(NSString *)str{
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    while (1) {
        NSRange range = [muStr rangeOfString:@"("];
        NSRange range1 = [muStr rangeOfString:@")"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    return muStr;
}

- (NSString *)innerStringWithString:(NSString *)str{
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    NSString *subStr;
    NSRange range = [muStr rangeOfString:@"("];
    NSRange range1 = [muStr rangeOfString:@")"];
    if (range.location != NSNotFound) {
        NSInteger loc = range.location;
        NSInteger len = range1.location - range.location;
        NSRange range2 = NSMakeRange(loc, len+1);
        subStr=[str substringWithRange:range2];
    }else{
        return nil;
    }
    return subStr;
}


#pragma mark - AttributedString
-(NSAttributedString *)creatAttributedStringWithString:(NSString *)firstStr
                                             andSecStr:(NSString *)secondStr
{
    NSString *descripeStr = [NSString stringWithFormat:@"%@ %@",firstStr,secondStr];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:descripeStr];
    NSRange firstRange = [descripeStr rangeOfString:firstStr];
    NSRange secondRange = [descripeStr rangeOfString:secondStr];
    [attributeString addAttribute:NSForegroundColorAttributeName
                            value:[self colorWithHex:0x3a4046]
                            range:firstRange];
    [attributeString addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:16]
                            range:firstRange];
    [attributeString addAttribute:NSForegroundColorAttributeName
                            value:[self colorWithHex:0x82878d]
                            range:secondRange];
    [attributeString addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:16]
                            range:secondRange];
    return attributeString;
}


- (void)btnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.imgView.hidden = NO;
    if (sender.selected) {
        if (self.callBtnClicked) {
            self.callBtnClicked(sender.tag);
        }
    }
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
    label.font = [UIFont systemFontOfSize:17.0f];
    label.numberOfLines = 0;
    label.textAlignment = alignmentleft ? NSTextAlignmentLeft :NSTextAlignmentCenter;
    return label;
}


- (UIColor *)colorWithHex:(NSInteger)colorInHex
{
    return [ UIColor colorWithRed: (( float ) (( colorInHex & 0xFF0000 ) >> 16 )) / 0xFF
                            green: (( float ) (( colorInHex & 0xFF00 ) >> 8 )) / 0xFF
                             blue: (( float ) ( colorInHex & 0xFF )) / 0xFF
                            alpha: 1.0 ];
}

@end
