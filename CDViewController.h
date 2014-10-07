//
//  CDViewController.h
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"

//データを受け渡す先のクラスをインポートする
#import "FNViewController.h"


@interface CDViewController : UIViewController

//プロジェクト名を表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *pjNameLabel;
//プロジェクトが赤字かどうかを表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *pjStatusLabel;
//時間を表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *pjTimeLabel;
//時間コストを表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *TimeCostLabel;

//ボタンの画像を途中で変更するためにはプロパティの宣言が必要
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

//NPから受け渡される変数のプロパティを宣言
@property float jikyu;
@property float housyu;
@property NSString *projectName;

@end
