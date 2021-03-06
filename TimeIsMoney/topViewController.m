//
//  topViewController.m
//  TimeIsMoney
//
//  Created by ビザンコムマック　13 on 2014/10/08.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "topViewController.h"
#import "CDViewController.h"


@interface topViewController ()
@end


@implementation topViewController{
    AppDelegate *app; //変数管理
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tabBarController.delegate = self;
    
//    self.tabBarController.selectedViewController = self.tabBarController.viewControllers[3];
    
    app = [[UIApplication sharedApplication] delegate]; //変数管理のデリゲート

    [app sinkouSet]; //配列の準備
    [app finishSet]; //配列の準備
    
    //プロジェクトの変数を初期化する
    app.housyu = 0; //報酬
    app.projectName = nil; //プロジェクト名
    app.genreName = nil; //ジャンル名
    app.clientName = nil; //クライアント名
    app.prjTime = 0; //経過時間
    
    [app jikyuSet]; //時給をセット
    //時給が空の場合時給タブを開く
    if(app.jikyu == 0){
        UIViewController *vc = self.tabBarController.childViewControllers[3];
        [UIView transitionFromView:self.view
                            toView:vc.view
                          duration:1.0
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:
         ^(BOOL finished) {
             self.tabBarController.selectedViewController = vc;
         }];
        
    }
    
    //終了結果表示から帰ってきた場合終了タブを開く
    if(app.syuryo == 1){
        UIViewController *vc = self.tabBarController.childViewControllers[1];
        [UIView transitionFromView:self.view
                            toView:vc.view
                          duration:1.0
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:
         ^(BOOL finished) {
             self.tabBarController.selectedViewController = vc;
             app.syuryo = 0;
         }];
    }
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
    dataCount = app.nowProject.count;
    return dataCount; //配列の中身の数を数えてローの数を指定する
}


//ここのメソッド何やってるかぜんぜんわからない
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
    cell.textLabel.text = app.nowProject[indexPath.row];
    return cell;
}


//セルが選択された時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //時給が未記入の場合警告が出る
    if (app.jikyu == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"エラー"
                              message:@"\n時給タブから時給を登録してください。"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if (indexPath.section != 0) return; //これがよくわからない
        NSInteger row = indexPath.row; //何番目が押されたかを判別してるっぽい
        
        //app.nowProjectから配列の◯番目の文字列を取り出して代入
        app.projectName = [app.nowProject objectAtIndex:row];
        
        //取り出した文字列で辞書を呼び出す
        NSDictionary *dic = [defaults dictionaryForKey:app.projectName];
        
        //報酬を代入
        NSString *data = [dic objectForKey:@"報酬"];
        app.housyu = [data integerValue];
        
        //経過時間を代入
        data = [dic objectForKey:@"経過時間"];
        app.prjTime = [data integerValue];
        
        //クライアント名を代入
        data = [dic objectForKey:@"クライアント名"];
        app.clientName = [NSString stringWithFormat:@"%@", data];
        
        //ジャンルを代入
        data = [dic objectForKey:@"ジャンル名"];
        app.genreName = [NSString stringWithFormat:@"%@", data];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
        [self performSegueWithIdentifier:@"topToCD" sender:self]; //opToCD Segueを実行
    }
}

//今のところ機能してないのでデータ消去に利用
- (IBAction)hensyu:(UIButton *)sender {
    //NSUserdefaultの中身を全消去するメソッド
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}
@end