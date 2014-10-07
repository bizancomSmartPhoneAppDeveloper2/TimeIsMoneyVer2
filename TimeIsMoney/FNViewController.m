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
    // Do any additional setup after loading the view.
    mySound = [[Sound alloc]init]; //音源クラスのインスタンス初期化

    //pjNameResultLabelにプロジェクト名を記入
    self.pjNameLabel.text = [NSString stringWithFormat:@"%@",_projectName];
    
    //resultTimeLabelにプロジェクト終了までにかかった時間の合計を記入
    if (_isOver) {
        //マイナス収支だった場合のかかった分数の計算
        resultTime = (_hours*60)+_minutes+_mokuhyouJikanKirisute;
        _hours=resultTime/60;
        _minutes=resultTime%60;
    }else{
        //プラス収支だった場合のかかった分数の計算
        if (_seconds == 0) {
            resultTime = _mokuhyouJikanKirisute-((_hours*60)+_minutes);
            _hours=resultTime/60;
            _minutes=resultTime%60;
        }else{
            resultTime = _mokuhyouJikanKirisute-((_hours*60)+_minutes)-1;
            _hours=resultTime/60;
            _minutes=resultTime%60;
            _seconds=60-_seconds;
        }
    }
    self.resultTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)_hours,(long)_minutes,(long)_seconds];

    //resultCostLabelに報酬額から総コストを引いた金額を記入
    resultCost = (_hours*_jikyu)+((_minutes*_jikyu)/60)+((_seconds*_jikyu)/3600);
    resultCost = _housyu - resultCost;
    self.resultCostLabel.text = [NSString stringWithFormat:@"%ld",(long)resultCost];
    
    //resultJikyuLabelに報酬額をかかった時間で割った「時給」を記入
    resultJikyu = (_housyu/((_hours*3600)+(_minutes*60)+_seconds))*3600;
    if (_housyu < resultJikyu) {
        self.resultJikyuLabel.text = [NSString stringWithFormat:@"%ld",(long)_housyu];
    }else{
        self.resultJikyuLabel.text = [NSString stringWithFormat:@"%ld",(long)resultJikyu];
    }
    
    //時間過ぎていた場合背景を赤くする
    if (_isOver) {
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
