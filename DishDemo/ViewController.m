//
//  ViewController.m
//  DishDemo
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "ViewController.h"
#import "TowViewController.h"
#import "ComenTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)webBtn:(id)sender {
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
    [[UIApplication sharedApplication] openURL:url];
    
}
- (IBAction)actionBtn:(id)sender {
    
    TowViewController * vc = [[TowViewController alloc]init];
    [ComenTool transfromWithController:vc];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
