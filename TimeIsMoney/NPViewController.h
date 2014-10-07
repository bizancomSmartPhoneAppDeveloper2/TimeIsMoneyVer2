//
//  NPViewController.h
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h" //音源クラス
#import "AppDelegate.h" //変数管理

@interface NPViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *prjhyouji;

@property (weak, nonatomic) IBOutlet UITextField *jikyuhyouji;

@property (weak, nonatomic) IBOutlet UITextField *housyuhyouji;
@end
