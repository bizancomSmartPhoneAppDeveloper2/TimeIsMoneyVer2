//
//  NPViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "NPViewController.h"

@interface NPViewController ()
@end

@implementation NPViewController
{
    Sound *mySound; //音源のインスタンス
    AppDelegate *app; //変数管理
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mySound = [[Sound alloc]init]; //音源のインスタンス初期化
    app = [[UIApplication sharedApplication] delegate]; //変数管理のデリゲート
    
    //背景クリックでソフトウェアキーボードを消す
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //もしprojectNameの中身が空でなければテキストフィールドにprojectNameの中身を表示 →　【？】「変数の中が空」は「0」でいいのか疑問【？】
    if (app.projectName != nil) {
        [self.prjhyouji setText: [NSString stringWithFormat:@"%@",app.projectName]];
    }
    
    //もしjikyuの中身が空でなければテキストフィールドにjikyuの中身を表示
    if (app.jikyu != 0) {
        NSNumber *num = [NSNumber numberWithFloat:app.jikyu]; //NSNumber型に変換
        [self.jikyuhyouji setText: [NSString stringWithFormat:@"%@",num]];
    }
    
    //もしhousyuの中身が空でなければテキストフィールドにhousyuの中身を表示
    if (app.housyu != 0) {
        NSNumber *num = [NSNumber numberWithFloat:app.housyu]; //NSNumber型に変換
        [self.housyuhyouji setText: [NSString stringWithFormat:@"%@",num]];
    }
    
}

//ソフトウェアキーボードを消すためのメソッド
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}

//プロジェクト名を入力した時の動作
- (IBAction)pjNameLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.projectName = text;
}

//時給を入力した時の動作
- (IBAction)jikyuLabel:(UITextField *)sender {
    //    月給から計算した時給をいれこみたいけど難しい。
    NSString *text = sender.text;
    app.jikyu = text.integerValue;
}

//報酬額を入力した時の動作
- (IBAction)housyuLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.housyu = text.integerValue;
}

- (IBAction)gekkyuBtn:(UIButton *)sender {
    [mySound soundCoin];
}
- (IBAction)okBtn:(UIButton *)sender {
    [mySound soundCoin];
    [app save]; //変数を保存
}

@end