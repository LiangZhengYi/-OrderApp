//
//  TowViewController.m
//  DishDemo
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "TowViewController.h"
#import "ViewController.h"
#import "MainVC.h"
#import "HmenuVC.h"
@interface TowViewController ()

@end

@implementation TowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)actionBtn:(id)sender {
    MainVC * vc = [[MainVC alloc]init];
    [ComenTool transfromWithController:vc];
    
}
- (IBAction)reteunBtn:(id)sender {
    
    ViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];
    [ComenTool transfromWithController:vc];
}

- (IBAction)HmenuBtn:(id)sender {
    HmenuVC * vc = [[HmenuVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
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

@end
