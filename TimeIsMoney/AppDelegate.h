//
//  AppDelegate.h
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//共通の変数
@property float jikyu;

//進行中プロジェクトを管理する配列
@property NSMutableArray *nowProject;

//プロジェクト作成時の変数
@property float housyu; //報酬
@property NSString *projectName; //プロジェクト名
@property NSString *genreName; //ジャンル名
@property NSString *clientName; //クライアント名

//プロジェクトの経過時間を数える変数
@property NSInteger prjTime;

////プロジェクトの状態を判定する変数…新規=0、進行中=1、終了=2
//@property NSInteger state;


//個別プロジェクトの中身の変数

-(void)sinkouSet;

@end
