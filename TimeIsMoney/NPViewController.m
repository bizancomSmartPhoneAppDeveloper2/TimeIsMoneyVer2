//
//  NPViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "NPViewController.h"
//音源用のフレームワーク2つインポート
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface NPViewController ()
//音源用のプロパティを宣言
@property AVAudioPlayer *btnSound;
@end

@implementation NPViewController
{
    float housyu;
    NSString *projectName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景クリックでソフトウェアキーボードを消す
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //もしjikyuの中身が空でなければテキストフィールドにjikyuの中身を表示
    if (_jikyu != 0) {
        [self.jikyuhyouji setText: [NSString stringWithFormat:@"%ld",(long)_jikyu]];
    }
}

//ソフトウェアキーボードを消すためのメソッド
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}

//プロジェクト名を入力した時の動作
- (IBAction)pjNameLabel:(UITextField *)sender {
    NSString *text = sender.text;
    projectName = text;
}

//時給を入力した時の動作
- (IBAction)jikyuLabel:(UITextField *)sender {
//    月給から計算した時給をいれこみたいけど難しい。
    NSString *text = sender.text;
    _jikyu = text.integerValue;
}

//報酬額を入力した時の動作
- (IBAction)housyuLabel:(UITextField *)sender {
    NSString *text = sender.text;
    housyu = text.integerValue;
}


//必要な変数をCDに渡す
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"NPtoCD"] ) {
        CDViewController *cdvc = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数vcntlに値を渡している
        cdvc.jikyu = _jikyu;
        cdvc.housyu = housyu;
        cdvc.projectName = projectName;
    }
}

////必要な変数をMSに渡す????わからん
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    //Segueの特定
//    if ( [[segue identifier] isEqualToString:@"NPtoMS"] ) {
//        MSViewController *msctrl = [segue destinationViewController];
//        //ここで遷移先ビューのクラスの変数vcntlに値を渡している
//        msctrl.projectName = projectName;
//    }
//}

- (IBAction)gekkyuBtn:(UIButton *)sender {
    //音がなる
    NSString *path = [[NSBundle mainBundle]pathForResource:@"coin"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.btnSound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    [self.btnSound play];
}
- (IBAction)okBtn:(UIButton *)sender {
    //音がなる
    NSString *path = [[NSBundle mainBundle]pathForResource:@"coin"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.btnSound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    [self.btnSound play];
}

@end
