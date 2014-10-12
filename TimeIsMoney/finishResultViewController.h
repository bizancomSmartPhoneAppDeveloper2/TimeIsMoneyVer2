//
//  finishResultViewController.h
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/10/12.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h" //音源クラス
#import "AppDelegate.h" //変数管理

@interface finishResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *pjNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultJikyuLabel;

//ボタンの色を変えるためにプロパティを宣言
@property (weak, nonatomic) IBOutlet UIButton *otuBtn;

@end