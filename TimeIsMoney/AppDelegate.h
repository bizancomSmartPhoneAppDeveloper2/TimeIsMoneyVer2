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

@property float jikyu;
@property float housyu;
@property NSString *projectName;

@property NSInteger hours;
@property NSInteger minutes;
@property NSInteger seconds;
@property BOOL isOver; //設定時間を過ぎたかどうかの判定、YESならマイナスカウントを始める
@property float mokuhyouJikan;

-(void)save; //変数の値を保存するためのメソッド

//眠い
@end
