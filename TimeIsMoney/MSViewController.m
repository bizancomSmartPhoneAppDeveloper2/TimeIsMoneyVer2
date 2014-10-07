//
//  MSViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "MSViewController.h"


@interface MSViewController ()
@end

@implementation MSViewController{
    Sound *mySound; //音源クラスのインスタンス
    AppDelegate *app; //変数管理
    
    //このクラスでしか使わない変数
    NSInteger gekkyu;
    NSInteger workTime;
    NSInteger weekHoliday;
    //計算に使う変数
    NSInteger workDays;
    NSInteger totalWorkTime;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mySound = [[Sound alloc]init]; //音源クラスのインスタンス初期化
    app = [[UIApplication sharedApplication] delegate]; //変数管理のデリゲート
    
    //それぞれの変数に0を代入（計算ボタンを押すと落ちてしまうため）
    gekkyu = 0;
    workTime = 0;
    weekHoliday = 0;
    
    //背景クリックでソフトウェアキーボードを消す
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//計算するボタンをおした時の動作
- (IBAction)keisanButton {
    //!!!ToDo!!! 多すぎる数字を入力した時にエラーが出るようにする。（ポップアップが理想）
    //時給を計算する
    //週休から月の勤務日数を割り出す
    workDays = ((7-weekHoliday)*4)+2;
    if (weekHoliday>3) {
        workDays--;
    }
    //勤務日数に労働時間をかけて一ヶ月の労働時間を割り出す
    totalWorkTime = workDays*workTime;
    //月給を総労働時間で割って時給を算出する
    app.jikyu = gekkyu/totalWorkTime;
    //目標時給をラベルに表示する（jikyuLabel）
    NSNumber *num = [NSNumber numberWithFloat:app.jikyu]; //NSNumber型に変換
    self.jikyuLabel.text = [NSString stringWithFormat:@"%@",num];
    
    
    [self closeSoftKeyboard];//ソフトウェアキーボードを閉じる
    [mySound soundCoin]; //コインの音
    
}

//月給を入力した時の動作
- (IBAction)monthlySalaryText:(UITextField *)sender {
    NSString *text = sender.text;
    gekkyu = text.integerValue;
}

//労働時間を入力した時の動作
- (IBAction)workTime:(UITextField *)sender {
    NSString *text = sender.text;
    workTime = text.integerValue;
}

//週休を入力した時の動作
- (IBAction)weekHoliday:(UITextField *)sender {
    NSString *text = sender.text;
    weekHoliday = text.integerValue;
}

//ソフトウェアキーボードを消すためのメソッド
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}

- (IBAction)okBtn:(UIButton *)sender {
    [mySound soundCoin]; //コインの音
}

@end
