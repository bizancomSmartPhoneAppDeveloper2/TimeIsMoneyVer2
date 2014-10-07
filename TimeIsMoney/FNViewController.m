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
    
    //新しく追加する変数
    NSInteger resultTime;
    float resultCost;
    NSInteger resultJikyu;
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
    
    // Do any additional setup after loading the view.
    //pjNameResultLabelにプロジェクト名を記入
    self.pjNameLabel.text = [NSString stringWithFormat:@"%@",app.projectName];
    
    //resultTimeLabelにプロジェクト終了までにかかった時間の合計を記入
    NSInteger num = app.mokuhyouJikan; //目標時間から小数点を切り捨てるためにint型の変数に代入
    if (app.isOver) {
        //マイナス収支だった場合のかかった分数の計算
        resultTime = (app.hours*60)+app.minutes+num;
        app.hours=resultTime/60;
        app.minutes=resultTime%60;
    }else{
        //プラス収支だった場合のかかった分数の計算
        if (app.seconds == 0) {
            resultTime = num-((app.hours*60)+app.minutes);
            app.hours=resultTime/60;
            app.minutes=resultTime%60;
        }else{
            resultTime = num-((app.hours*60)+app.minutes)-1;
            app.hours=resultTime/60;
            app.minutes=resultTime%60;
            app.seconds=60-app.seconds;
        }
    }
    self.resultTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",app.hours,app.minutes,app.seconds];
    
    //resultCostLabelに報酬額から総コストを引いた金額を記入
    resultCost = (app.hours*app.jikyu)+((app.minutes*app.jikyu)/60)+((app.seconds*app.jikyu)/3600);
    resultCost = app.housyu - resultCost;
    self.resultCostLabel.text = [NSString stringWithFormat:@"%ld",(long)resultCost];
    
    //resultJikyuLabelに報酬額をかかった時間で割った「時給」を記入
    resultJikyu = (app.housyu/((app.hours*3600)+(app.minutes*60)+app.seconds))*3600;
    if (app.housyu < resultJikyu) {
        NSNumber *num = [NSNumber numberWithFloat:app.housyu]; //float型を編集
        self.resultJikyuLabel.text = [NSString stringWithFormat:@"%@",num];
    }else{
        self.resultJikyuLabel.text = [NSString stringWithFormat:@"%ld",(long)resultJikyu];
    }
    
    //時間過ぎていた場合背景を赤くする
    if (app.isOver) {
        self.backImage.image = [UIImage imageNamed:@"fnback02"]; //背景画像を変更する
        [self.otuBtn setImage:[UIImage imageNamed:@"btnOtsuRed"] forState:UIControlStateNormal];//ボタンも変更する
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
