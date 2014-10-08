//
//  ViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
{
    Sound *mySound; //音源クラスのインスタンス
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mySound = [[Sound alloc]init]; //音源クラスのインスタンス初期化
    
    //NSUserdefaultの中身を全消去するメソッド
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startBtn:(UIButton *)sender {
    [mySound soundCoin]; //コインの音
}

@end
