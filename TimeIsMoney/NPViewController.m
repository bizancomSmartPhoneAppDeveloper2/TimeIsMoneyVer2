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
}


//ソフトウェアキーボードを消すためのメソッド
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}


//ここを改造する必要あり
-(void)save{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //ここややこしい
    int cnt =  0;
    NSNumber *num = [defaults objectForKey:@"プロジェクトカウント"];
    if (num ) {
        cnt = num.intValue +1;
    } else{
        cnt = 1;
    }
    
    
    NSString *str = [NSString stringWithFormat: @"プロジェクト_%03d", cnt];

    //プロジェクト名を保存
    [dic setObject: app.projectName  forKey: @"プロジェクト名"];
    
    //クライアント名を保存（未記入の場合は「その他」）
    [dic setObject: app.clientName  forKey: @"クライアント名"];
    
    //ジャンル名を保存（未記入の場合は「その他」）
    [dic setObject: app.genreName  forKey: @"ジャンル名"];

    //報酬を保存
    num = [NSNumber numberWithFloat:app.housyu];
    [dic setValue: num  forKey: @"報酬"];
    
    //dicとして保存
    [defaults setObject:dic forKey: str];
    
    num = [[NSNumber alloc]initWithInt:cnt];
    [defaults setObject:num forKey:@"プロジェクトカウント"];//プロジェクトの数？？
    
    //確認用？プロジェクトカウントの数をNSLogで出力
    NSNumber *num2 = [defaults objectForKey:@"プロジェクトカウント"];
    NSLog(@"カウント：%d",num2.intValue);
}


//プロジェクト名を入力した時の動作
- (IBAction)pjNameLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.projectName = text;
}

//クライアント名
- (IBAction)clientLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.clientName = text;
}

//ジャンル
- (IBAction)genreLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.genreName = text;
}

//報酬額を入力した時の動作
- (IBAction)housyuLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.housyu = text.integerValue;
}

//OKボタン
- (IBAction)okBtn:(UIButton *)sender {
    [mySound soundCoin]; //音を鳴らす
    [self save]; //変数を保存
}
@end