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


//入力内容を保存するためのメソッド
-(void)save{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    //プロジェクト名を保存
    [dic setObject: app.projectName  forKey: @"プロジェクト名"];

    //クライアント名を保存（未記入の場合は「その他」）
    if (app.clientName == nil) {
        [dic setObject: @"その他"  forKey: @"クライアント名"];
    }else{
        [dic setObject: app.clientName  forKey: @"クライアント名"];
    }

    //ジャンル名を保存（未記入の場合は「その他」）
    if (app.genreName == nil) {
        [dic setObject: @"その他"  forKey: @"ジャンル名"];
    }else{
        [dic setObject: app.genreName  forKey: @"ジャンル名"];
    }

    //報酬を保存
    NSNumber *num = [NSNumber numberWithFloat:app.housyu];
    [dic setValue: num  forKey: @"報酬"];
    
    //経過時間を0として保存prjTime
    [dic setValue: 0  forKey: @"経過時間"];
    
    //進行中プロジェクトの配列の中身が空の場合初期化する
    NSInteger dataCount;
    dataCount = app.nowProject.count;
    if (dataCount == 0) {
        app.nowProject = [[NSMutableArray alloc] init];
    }

    //進行中プロジェクトの配列の最後に保存
    [app.nowProject addObject:app.projectName];
    
    //userdefaultsでdicと配列を保存
    [defaults setObject:dic forKey: app.projectName];
    [defaults setObject:app.nowProject forKey:@"進行中"];
}


//プロジェクト名を入力した時の動作
- (IBAction)pjNameLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.projectName = text;
}

//クライアント名を入力した時の動作
- (IBAction)clientLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.clientName = text;
}

//ジャンル名を入力した時の動作
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
    //同じプロジェクト名があるかどうか検索
    BOOL flg = [app.nowProject containsObject:app.projectName];
    BOOL flg2 = [app.finishProject containsObject:app.projectName];
    
    //プロジェクト名未記入の場合警告が出る
    if(app.projectName == nil){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"登録できません"
                              message:@"\nプロジェクト名を入力してください。"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];

    //同じプロジェクト名があった場合警告が出る（進行中）
    }else if (flg == YES) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"登録できません"
                              message:@"\n同じ名前のプロジェクトが存在します。\nプロジェクト名を変更してください。"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
        //同じプロジェクト名があった場合警告が出る（終了済）
    }else if (flg2 == YES) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"登録できません"
                              message:@"\n同じ名前のプロジェクトが存在します。\nプロジェクト名を変更してください。"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
    //報酬未記入の場合警告が出る
    }else if(app.housyu == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"登録できません"
                              message:@"\n報酬額を入力してください。"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }else{
        [self save]; //変数を保存
        [mySound soundCoin]; //音を鳴らす
        [self performSegueWithIdentifier:@"NPtoTop" sender:self]; //NPtoTop Segueを実行
    }
}
@end