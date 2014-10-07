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

    //タイマーで必要なインスタンスと変数
    NSTimer *myTimer;
    NSInteger hours;
    NSInteger minutes;
    NSInteger seconds;
    BOOL isOver;//設定時間を過ぎたかどうかの判定、YESならマイナスカウントを始める
    //コスト表示用のタイマー
    NSTimer *costTimer;
    NSInteger cost;
    //目標時給と報酬から割り出される数字の変数
    float mokuhyouJikan;
    NSInteger mokuhyouJikanKirisute;
    float ichienByousu;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mySound = [[Sound alloc]init]; //音源クラスのインスタンス初期化
    //プロジェク名と状態をラベルに表示
    self.pjNameLabel.text = [NSString stringWithFormat:@"%@",_projectName];
    self.pjStatusLabel.text = [NSString stringWithFormat:@"目標終了時間まであと…"];
    
    //目標時給と報酬から目標時間を割り出す
    mokuhyouJikan = _housyu/_jikyu*60;
    mokuhyouJikanKirisute = mokuhyouJikan; //mokuhyoujikan = floor(mokuhyouJikan)でも切り捨て可能だが分数計算でエラーが出る
    //時、分、秒に数字を代入。ラベルにそれを表示
    hours = mokuhyouJikanKirisute/60;
    minutes = mokuhyouJikanKirisute%60;
    seconds = 0;
    [self writePjTimeLabel];
    
    //時給から１円あたりの秒数を計算
    ichienByousu = 3600/_jikyu;
//    NSLog(@"１円稼ぐのにかかる秒数は%f秒",ichienByousu);
    
    //時間コストを0として表示
    cost = 0;
    self.TimeCostLabel.text = [NSString stringWithFormat:@"%ld",(long)cost]; ///???(long)???
}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//開始／停止ボタンをおした時の動作
- (IBAction)startStopButton:(id)sender {
    //myTimerが動いている場合止める
    if ([myTimer isValid]) {
        [myTimer invalidate];
        [costTimer invalidate];
    }else{
        //myTimerが動いてない場合動かす（timerメソッド）
        [self countTimer];
        [self costTimer];
    }
    [mySound soundCoin]; //コインの音
}

//~~~~~~~~~~~~~~~~~~~~~ここからタイマーカウント~~~~~~~~~~~~~~~~~~~~~
//タイマーでcountDownメソッドを１秒ごとに繰り返し呼ぶ
-(void)countTimer{
    float num = 1;
    myTimer = [NSTimer
               scheduledTimerWithTimeInterval:num
               target: self
               selector:@selector(countDown)
               userInfo:nil
               repeats:YES];
}

//タイマーで呼ばれるcountDownメソッド
-(void)countDown{
    //まだ00:00:00になってなかったら…
    if (!isOver) {
        if(seconds>0){
            seconds--;
            self.pjTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours,(long)minutes,(long)seconds];
        }else if(minutes != 0 && seconds == 0){
            //分が0ではない状態で秒が0になったら、分から1引いて秒を59にする（0秒と60秒は同じなので59秒からカウントダウン）
            minutes--;
            seconds=59;
            [self writePjTimeLabel];
        }
        //分と秒が0だが、時が0ではない場合、時から1引いて分と秒を59にする。
        else if(hours != 0 && minutes == 0 && seconds == 0){
            hours--;
            minutes = 59;
            seconds = 59;
            [self writePjTimeLabel];
        }
        //時、分、秒すべて0になったらisOverをYESにする
        else if(hours == 0 && minutes == 0 && seconds ==0){
            isOver = YES;
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
    self.pjTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours,(long)minutes,(long)seconds];
}

//赤字に陥った後のカウントアップメソッド
-(void)akajiCount{
    //背景を赤にするメソッド
//    self.view.backgroundColor = [UIColor redColor];
//    self.pjStatusLabel.text = [NSString stringWithFormat:@"目標時間をオーバーしています"];
    self.backImage.image = [UIImage imageNamed:@"cdback02"]; //背景画像を変更する
    //カウントアップをしていくメソッド
    //分と秒が59だったら時に1を足して分と秒を0に戻す.
    if (minutes == 59 && seconds == 59) {
        hours++;
        minutes = 0;
        seconds =0;
        [self writePjTimeLabel];
        //秒が59だったら分に1を足して秒を0に戻す.
    }else if (seconds == 59) {
        minutes++;
        seconds = 0;
        [self writePjTimeLabel];
        seconds++;
        //秒に1ずつ足していく
    }else{
        seconds++;
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

//FNに変数を引き渡すためのメソッド
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"CDtoFN"] ) {
        FNViewController *fnvctl = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数vcntlに値を渡している
        fnvctl.jikyu = _jikyu;
        fnvctl.housyu = _housyu;
        fnvctl.projectName = _projectName;
        fnvctl.hours = hours;
        fnvctl.minutes = minutes;
        fnvctl.seconds = seconds;
        fnvctl.isOver = isOver;
        fnvctl.mokuhyouJikan = mokuhyouJikan;
        fnvctl.mokuhyouJikanKirisute = mokuhyouJikanKirisute;
    }
}

- (IBAction)finishBtn:(UIButton *)sender {
    [mySound soundRegi]; //レジの音
}
@end
