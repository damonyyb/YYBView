//
//  ViewController.m
//  YYBExample
//
//  Created by mac on 17/4/5.
//  Copyright © 2017年 yyb. All rights reserved.
//

#import "ViewController.h"
#import "YYBShowBottomCustomSheetView.h"
#import "UIView+TYAlertView.h"
#import "YYBShowLoadingWithCircleRing.h"
#import "YYBShowKnowInfoView.h"
#import "YYBShowLoadingWithCancel.h"
#import "YYBShowLoadingCenterView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (IBAction)showBottomCustomSheetView1Clicked:(UIButton *)sender
{
    [self showBottomCustomSheetView1];
}


- (IBAction)showBottomCustomSheetView2Clicked:(UIButton *)sender
{
    [self showBottomCustomSheetView2];
}


- (IBAction)showShowLoadingWithCircleRingClicked:(UIButton *)sender
{
    [self showShowLoadingWithCircleRing];
}


- (void)showShowLoadingWithCircleRing
{
    YYBShowLoadingWithCircleRing *circleRing = [[YYBShowLoadingWithCircleRing alloc]initWithTitle:@"正在保存设置"];
    [circleRing showInWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [circleRing hideView];
    });
}

- (IBAction)showKnowInfoViewClicked:(UIButton *)sender
{
    [self showKnowInfoView];
}


- (IBAction)showLoadingWithCancelClicked:(UIButton *)sender
{
    [self showLoadingWithCancel];
}


- (IBAction)showLoadingCenterViewClicked:(UIButton *)sender
{
    [self showLoadingCenterView];
}

- (void)showLoadingCenterView
{
    YYBShowLoadingCenterView *loadingView =[[YYBShowLoadingCenterView alloc]initWithTitle:@"设置成功，设备正在重启大约需要15秒，请稍等"];
    [loadingView show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [loadingView hide];
    });

}


- (void)showLoadingWithCancel
{
    YYBShowLoadingWithCancel *waitingView=
    [[YYBShowLoadingWithCancel alloc] initWithTitle:@"正在为您检测数据"andmoreInfo:@"(该过程大约需要25秒)"];
    [waitingView show];
    waitingView.hitCancelCallBack = ^(){
        NSLog(@"取消");
    };
}


- (void)showKnowInfoView
{
    YYBShowKnowInfoView  *showView = [[YYBShowKnowInfoView alloc]initWithTitle:@"当前登录已过期或帐号已在其他设备登录" andKnowTitle:@"知道了"];
    [showView showInWindow];
}

- (void)showBottomCustomSheetView1
{
    YYBShowBottomCustomSheetView *sheeView =
    [[YYBShowBottomCustomSheetView alloc]initWithTitle:@"在设置的时间段范围内，需要重启设备，是否继续？"
                                           otherTitles:nil
                                        andCancelTitle:@"取消"
                                         andChooseItem:nil
                                        andConfirmItem:@"确认"];
    [sheeView show];
    sheeView.callFooterViewBtnClickedBack= ^(NSInteger tag) {
        
    };
}


- (void)showBottomCustomSheetView2
{
    NSArray *otherTitles = @[@"heinan (河南)",@"nanchang (南昌)",@"hunanhubei (湖南/湖北)",@"hunan2 (湖南/湖北)",@"Other Plus (其他区域)"];
    YYBShowBottomCustomSheetView *sheeView =
    [[YYBShowBottomCustomSheetView alloc]initWithTitle:@"选择区域"
                                        otherTitles:otherTitles
                                     andCancelTitle:@"取消"
                                      andChooseItem:@"nanchang (南昌)"
                                     andConfirmItem:nil];
    [sheeView show];
    sheeView.callSelectedNumBack = ^(NSInteger tag){
        NSLog(@"%@",otherTitles[tag]);
    };

}
@end
