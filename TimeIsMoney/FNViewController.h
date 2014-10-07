//
//  FNViewController.h
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"

@interface FNViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *pjNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultJikyuLabel;

//CDから受け渡される変数のプロパティを宣言
@property float jikyu;
@property float housyu;
@property NSString *projectName;
@property NSInteger hours;
@property NSInteger minutes;
@property NSInteger seconds;
@property BOOL isOver;
@property float mokuhyouJikan;
@property NSInteger mokuhyouJikanKirisute;

//ボタンの色を変えるためにプロパティを宣言
@property (weak, nonatomic) IBOutlet UIButton *otuBtn;
@end
