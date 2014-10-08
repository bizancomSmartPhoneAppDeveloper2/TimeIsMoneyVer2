//
//  topViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/10/08.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "topViewController.h"

@interface topViewController ()
@end


@implementation topViewController{
    AppDelegate *app; //変数管理
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //NSUserdefaultの中身を全消去するメソッド
//        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];

    app = [[UIApplication sharedApplication] delegate]; //変数管理のデリゲート

    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self prjArray]; //NSUserDefaultsからプロジェクトだけ取り出して配列に入れる

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; //セルの数を指定
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger dataCount;
    dataCount = self.allProject.count;
    return dataCount; //配列の中身の数を数えてローの数を指定する？
}


//ここのメソッドビタイチわからん
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    // 再利用できるセルがあれば再利用する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    //    cell.textLabel.text = self.dataSourceiPhone[indexPath.row];
    cell.textLabel.text = self.allProject[indexPath.row];
    return cell;
}


//NSUserDefaultsからプロジェクトだけ取り出して配列に入れる
-(void)prjArray{
    self.allProject = [[NSMutableArray alloc] init];// [NSMutableArray arrayWithObjects: nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int cnt =  0;
    NSNumber *num = [defaults objectForKey:@"プロジェクトカウント"];
    if (num ) {
        cnt = num.intValue;
    }
    
    for (int i = 0; i < cnt; i++) {
        NSString *str = [NSString stringWithFormat: @"プロジェクト_%03d", i + 1];
        NSDictionary *dic = [defaults dictionaryForKey:str];
        NSString *data = [dic objectForKey:@"プロジェクト名"];
        NSLog(@"プロジェクト名：%@",data);
        
        [self.allProject addObject:data] ;//] insertObject:data atIndex:i];//ここがおかしいと思われる
    }
 }


//新規プロジェクト作成ボタン
- (IBAction)btnNewPrj:(UIButton *)sender {
    
    
    
    
    //新規プロジェクト作成なので変数を初期化
    app.jikyu = 0;
    app.housyu = 0;
    app.projectName = nil;
    
//    //仮
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dic = [defaults persistentDomainForName:appDomain];
//    NSLog(@"defualts:%@", dic);
}

@end
