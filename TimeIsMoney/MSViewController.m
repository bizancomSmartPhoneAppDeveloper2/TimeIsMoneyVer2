//
//  MSViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "MSViewController.h"
//音源用のフレームワーク2つインポート
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MSViewController ()
//音源用のプロパティを宣言
@property AVAudioPlayer *btnSound;
@end

@implementation MSViewController{
    NSInteger gekkyu;
    NSInteger workTime;
    NSInteger weekHoliday;
    
    //計算に使う変数
    NSInteger workDays;
    NSInteger totalWorkTime;
    
    //月額から計算した目標時給
    NSInteger jikyuG;
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
     //背景クリックでソフトウェアキーボードを消す
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //それぞれの変数に0を代入。計算ボタンを押すと落ちてしまうため
    gekkyu = 0;
    workTime = 0;
    weekHoliday = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    jikyuG = gekkyu/totalWorkTime;
    //目標時給をラベルに表示する（jikyuLabel）
    self.jikyuLabel.text = [NSString stringWithFormat:@"%ld",(long)jikyuG]; //???(long)がないと黄色エラーが出る???
    
    
    [self closeSoftKeyboard];//ソフトウェアキーボードを閉じる
    //音源用の何か、ここでファイル名を変更
    NSString *path = [[NSBundle mainBundle]pathForResource:@"coin"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.btnSound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    [self.btnSound play];//音がなるメソッド
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

//NPに変数を引き渡す
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"MStoNP"] ) {
        NPViewController *npvctl = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数vcntlに値を渡している
        npvctl.jikyu = jikyuG;
    }
}

- (IBAction)okBtn:(UIButton *)sender {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"coin"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.btnSound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    [self.btnSound play];//音がなるメソッド
}

@end
