//
//  finishResultViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/10/12.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "finishResultViewController.h"

@interface finishResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@end

@implementation finishResultViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    mySound = [[Sound alloc]init]; //音源クラスのインスタンス初期化
    app = [[UIApplication sharedApplication] delegate]; //変数管理のデリゲート
    
    //pjNameResultLabelにプロジェクト名を記入
    self.pjNameLabel.text = [NSString stringWithFormat:@"%@",app.projectName];
    
    //クライアント名、ジャンル名、報酬額をラベルに表示
    self.clientLabel.text = [NSString stringWithFormat:@"クライアント：%@",app.clientName];
    self.genreLabel.text = [NSString stringWithFormat:@"ジャンル：%@",app.genreName];
    NSNumber *num = [NSNumber numberWithFloat:app.housyu];
    self.housyuLabel.text = [NSString stringWithFormat:@"報酬額：%@円",num];
    
    //目標時給と報酬から目標時間を割り出す
    float flt = app.housyu/app.jikyu*60*60;
    NSInteger intNum = flt; //目標時間から小数点を切り捨てるためにint型の変数に代入
    
    //経過時間と目標時間を比較し、目標時間を過ぎていた場合背景を赤くする
    if (app.prjTime > intNum) {
        self.backImage.image = [UIImage imageNamed:@"fnback02"]; //背景画像を変更する
        [self.otuBtn setImage:[UIImage imageNamed:@"btnResumeRed"] forState:UIControlStateNormal];//ボタンも変更する
        [self.backBtn setImage:[UIImage imageNamed:@"btnBackWhite"] forState:UIControlStateNormal];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//再開ボタンをおした時の挙動
- (IBAction)restartBtn:(UIButton *)sender {
    //finishProjectから削除してUserDefaltsで保存
    [app.finishProject removeObject:app.projectName];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:app.finishProject forKey:@"終了済"];
    
    //nowProjectに挿入してUserDefaltsで保存
    //進行中プロジェクトの配列の中身が空の場合初期化する
    NSInteger dataCount;
    dataCount = app.nowProject.count;
    if (dataCount == 0) {
        app.nowProject = [[NSMutableArray alloc] init];
    }
    //進行中プロジェクトの配列の最後に保存
    [app.nowProject addObject:app.projectName];
    //userdefaultsで配列を保存
    [defaults setObject:app.nowProject forKey:@"進行中"];
    
    [mySound soundCoin]; //コインの音
}

- (IBAction)backBtn:(UIButton *)sender {
    [self performSegueWithIdentifier:@"finishResultToTop" sender:self]; //Segueを実行
    app.syuryo = 1;
}

@end
