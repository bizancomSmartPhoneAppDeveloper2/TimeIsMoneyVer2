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
    
    float housyu;
    NSString *projectName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mySound = [[Sound alloc]init]; //音源のインスタンス初期化

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


- (IBAction)gekkyuBtn:(UIButton *)sender {
    [mySound soundCoin];
}

- (IBAction)okBtn:(UIButton *)sender {
    [mySound soundCoin];
}

@end
