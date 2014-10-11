//
//  FNViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "FNViewController.h"

@interface FNViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@end

@implementation FNViewController
{
    Sound *mySound; //音源クラスのインスタンス
    AppDelegate *app; //変数管理
    
//このクラスでしか使われない変数
    NSInteger resultJikyu;
    NSInteger hours;
    NSInteger minutes;
    NSInteger seconds;
    NSInteger cost;
    float ichienByousu;
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
    
    //pjNameResultLabelにプロジェクト名を記入
    self.pjNameLabel.text = [NSString stringWithFormat:@"%@",app.projectName];
    
    //目標時給と報酬から目標時間を割り出す
    float flt = app.housyu/app.jikyu*60*60;
    NSInteger num = flt; //目標時間から小数点を切り捨てるためにint型の変数に代入
    
    //経過時間と目標時間を比較し、目標時間を過ぎていた場合背景を赤くする
    if (app.prjTime > num) {
        self.backImage.image = [UIImage imageNamed:@"fnback02"]; //背景画像を変更する
        [self.otuBtn setImage:[UIImage imageNamed:@"btnOtsuRed"] forState:UIControlStateNormal];//ボタンも変更する
    }
    
    //resultTimeLabelにプロジェクト終了までにかかった時間の合計を記入
    hours = app.prjTime/3600;
    minutes = (app.prjTime%3600)/60;
    seconds = (app.prjTime%3600)%60;
    self.resultTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours,minutes,seconds];


    //resultCostLabelに報酬額から総コストを引いた金額を記入
    ichienByousu = 3600/app.jikyu;//時給から１円あたりの秒数を計算
    flt = app.prjTime/ichienByousu;
    cost = flt;
    cost = app.housyu - cost;
    self.resultCostLabel.text = [NSString stringWithFormat:@"%ld",cost];
    
    //resultJikyuLabelに報酬額をかかった時間で割った「時給」を記入
    resultJikyu = (app.housyu/app.prjTime)*3600;
    if (app.housyu < resultJikyu) {
        NSNumber *num = [NSNumber numberWithFloat:app.housyu]; //float型を編集
        self.resultJikyuLabel.text = [NSString stringWithFormat:@"%@",num];
    }else{
        self.resultJikyuLabel.text = [NSString stringWithFormat:@"%ld",resultJikyu];
    }
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

- (IBAction)otuBtn:(UIButton *)sender {
    [mySound soundCoin]; //コインの音
}

@end
