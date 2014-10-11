//
//  CDViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "CDViewController.h"

@interface CDViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@end

@implementation CDViewController
{
    Sound *mySound; //音源クラスのインスタンス
    AppDelegate *app; //変数管理
    NSTimer *myTimer; //タイマーのインスタンス
    NSTimer *costTimer; //コスト表示用のタイマー
    
    //このクラスでしか使われない変数
    NSInteger cost;
    float ichienByousu;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mySound = [[Sound alloc]init]; //音源クラスのインスタンス初期化
    app = [[UIApplication sharedApplication] delegate]; //変数管理のデリゲート
    
    //プロジェク名をラベルに表示
    self.pjNameLabel.text = [NSString stringWithFormat:@"%@",app.projectName];
    
    //目標時給と報酬から目標時間を割り出す
    app.mokuhyouJikan = app.housyu/app.jikyu*60;
    NSInteger num = app.mokuhyouJikan; //目標時間から小数点を切り捨てるためにint型の変数に代入
    
    //時、分、秒に数字を代入。ラベルにそれを表示
    app.hours = num/60;
    app.minutes = num%60;
    app.seconds = 0;
    [self writePjTimeLabel];
    
    //時給から１円あたりの秒数を計算
    ichienByousu = 3600/app.jikyu;
    //    NSLog(@"１円稼ぐのにかかる秒数は%f秒",ichienByousu);
    
    //時間コストを0として表示
    cost = 0;
    self.TimeCostLabel.text = [NSString stringWithFormat:@"%ld",(long)cost]; ///???(long)???
    
    //経過時間が0の場合終了ボタンを隠す
    if (app.prjTime == 0) {
        self.finishBtn.hidden = YES;
    }
}

//~~~~~~~~~~~~~~~~~~~~~ここからタイマーカウント~~~~~~~~~~~~~~~~~~~~~
//タイマーでcountDownメソッドを１秒ごとに繰り返し呼ぶ
-(void)countTimer{
    myTimer = [NSTimer
               scheduledTimerWithTimeInterval:1
               target: self
               selector:@selector(countDown)
               userInfo:nil
               repeats:YES];
}

//タイマーで呼ばれるcountDownメソッド
-(void)countDown{
    [self kakunin];//確認用
    app.prjTime++; //経過時間を足していく

    //まだ00:00:00になってなかったら…
    if (!app.isOver) {
        if(app.seconds>0){
            app.seconds--;
            self.pjTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",app.hours,app.minutes,app.seconds];
        }else if(app.minutes != 0 && app.seconds == 0){
            //分が0ではない状態で秒が0になったら、分から1引いて秒を59にする（0秒と60秒は同じなので59秒からカウントダウン）
            app.minutes--;
            app.seconds=59;
            [self writePjTimeLabel];
        }
        //分と秒が0だが、時が0ではない場合、時から1引いて分と秒を59にする。
        else if(app.hours != 0 && app.minutes == 0 && app.seconds == 0){
            app.hours--;
            app.minutes = 59;
            app.seconds = 59;
            [self writePjTimeLabel];
        }
        //時、分、秒すべて0になったらisOverをYESにする
        else if(app.hours == 0 && app.minutes == 0 && app.seconds == 0){
            app.isOver = YES;
            [self akajiCount];
            //ついでにアラート音を鳴らす
            [mySound soundAlert];  //アラート音
            //ついでにボタンを変える
            [self.startStopButton setImage:[UIImage imageNamed:@"btnStartRed"] forState:UIControlStateNormal];
            [self.finishBtn setImage:[UIImage imageNamed:@"btnFinishRed"] forState:UIControlStateNormal];
        }
    }
    else{
        //カウントダウンが終わった場合マイナスカウントメソッドを実行
        [self akajiCount];
    }
}

//countDownメソッドで使うprojectTimeLabelに残り時間を表示するためのメソッド
-(void)writePjTimeLabel{
    self.pjTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",app.hours,app.minutes,app.seconds];
}

//赤字に陥った後のカウントアップメソッド
-(void)akajiCount{
    //背景を赤にするメソッド
    //    self.view.backgroundColor = [UIColor redColor];
    //    self.pjStatusLabel.text = [NSString stringWithFormat:@"目標時間をオーバーしています"];
    self.backImage.image = [UIImage imageNamed:@"cdback02"]; //背景画像を変更する
    //カウントアップをしていくメソッド
    //分と秒が59だったら時に1を足して分と秒を0に戻す.
    if (app.minutes == 59 && app.seconds == 59) {
        app.hours++;
        app.minutes = 0;
        app.seconds =0;
        [self writePjTimeLabel];
        app.prjTime++; //経過時間を足していく
        //秒が59だったら分に1を足して秒を0に戻す.
    }else if (app.seconds == 59) {
        app.minutes++;
        app.seconds = 0;
        [self writePjTimeLabel];
        app.seconds++;
        //秒に1ずつ足していく
    }else{
        app.seconds++;
        [self writePjTimeLabel];
    }
}
//~~~~~~~~~~~~~~~~~~~~~タイマーカウントここまで~~~~~~~~~~~~~~~~~~~~~

//~~~~~~~~~~~~~~~~~~~~~ここからコストカウント~~~~~~~~~~~~~~~~~~~~~
//コストを表示するタイマー
-(void)costTimer{
    costTimer = [NSTimer
                 scheduledTimerWithTimeInterval:ichienByousu
                 target: self
                 selector:@selector(witeCostLabel)
                 userInfo:nil
                 repeats:YES];
}

//コストラベルの更新をするメソッド
-(void)witeCostLabel{
    cost++;
    self.TimeCostLabel.text = [NSString stringWithFormat:@"%ld",(long)cost];
}
//~~~~~~~~~~~~~~~~~~~~~コストカウントここまで~~~~~~~~~~~~~~~~~~~~~

//経過時間を保存するメソッド
-(void)saveTime{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults dictionaryForKey:app.projectName];
    NSNumber *num = [NSNumber numberWithFloat:app.prjTime];
    [dic setValue: num  forKey: @"経過時間"];
    [defaults setObject:dic forKey: app.projectName];
}



//動作確認のためのメソッド
-(void)kakunin{
    NSLog(@"%ld",app.prjTime);
}

- (IBAction)backBtn:(UIButton *)sender {
    //myTimerが動いている場合止める
    if ([myTimer isValid]) {
        [myTimer invalidate];
        [costTimer invalidate];
    }
    
    [self saveTime]; //経過時間を保存
}

//開始／停止ボタンをおした時の動作
- (IBAction)startStopButton:(id)sender {
    //myTimerが動いている場合止めて、終了ボタンを表示
    if ([myTimer isValid]) {
        [myTimer invalidate];
        [costTimer invalidate];
        self.finishBtn.hidden = NO;
    }else{
        //myTimerが動いてない場合動かす（timerメソッド）。終了ボタン隠す
        [self countTimer];
        [self costTimer];
        self.finishBtn.hidden = YES;
    }

    [self saveTime]; //経過時間を保存
    [mySound soundCoin]; //コインの音
}

//終了ボタン
- (IBAction)finishBtn:(UIButton *)sender {
    [self saveTime]; //経過時間を保存
    [mySound soundRegi]; //レジの音
}
@end
