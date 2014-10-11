//
//  jikyuSetViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/10/09.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "jikyuSetViewController.h"
#import "AppDelegate.h"

@interface jikyuSetViewController ()

@end

@implementation jikyuSetViewController
{
    AppDelegate *app; //変数管理
}


- (void)viewDidLoad {
    [super viewDidLoad];
    app = [[UIApplication sharedApplication] delegate]; //変数管理のデリゲート
    
    //時給を変数に入れる
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    app.jikyu = [defaults floatForKey:@"時給"];
    
    //背景クリックでソフトウェアキーボードを消す
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    //もしjikyuの中身が空でなければテキストフィールドにjikyuの中身を表示
    if (app.jikyu != 0) {
        NSNumber *num = [NSNumber numberWithFloat:app.jikyu]; //NSNumber型に変換
        [self.jikyuhyouji setText: [NSString stringWithFormat:@"%@",num]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}

//時給を入力した時の動作
- (IBAction)jikyuLabel:(UITextField *)sender {
    NSString *text = sender.text;
    app.jikyu = text.integerValue;
    
    //時給をNSUserDefaultで保存
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [NSNumber numberWithFloat:app.jikyu];
    [defaults setObject:num forKey:@"時給"];
}


@end
