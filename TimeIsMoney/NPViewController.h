//
//  NPViewController.h
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
//データを受け渡す先のクラスをインポートする
#import "CDViewController.h"
//#import "MSViewController.h" 上手くいかない

@interface NPViewController : UIViewController

//MSから受け渡される変数のプロパティ
@property NSInteger jikyu;
@property (weak, nonatomic) IBOutlet UITextField *jikyuhyouji;

@end
