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

//プロジェクト作成時の変数
@property float housyu; //報酬
@property NSString *projectName; //プロジェクト名
@property NSString *genreName; //ジャンル名
@property NSString *clientName; //クライアント名


//個別プロジェクトの中身の変数
@property NSInteger hours;
@property NSInteger minutes;
@property NSInteger seconds;
@property BOOL isOver; //設定時間を過ぎたかどうかの判定、YESならマイナスカウントを始める
@property float mokuhyouJikan;

-(void)jikyuset;

@end
