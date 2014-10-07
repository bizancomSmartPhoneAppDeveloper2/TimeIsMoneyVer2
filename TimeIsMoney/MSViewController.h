//
//  MSViewController.h
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/09/19.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"

//データを受け渡す先のクラスをインポートする
#import "NPViewController.h"

@interface MSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *jikyuLabel;

////NPからもらう変数 なんかsegueでエラーが出る
//@property float housyu;
//@property NSString *projectName;

@end
