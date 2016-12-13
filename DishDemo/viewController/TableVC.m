//
//  TableVC.m
//  DishDemo
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "TableVC.h"
#import "TowViewController.h"
@interface TableVC ()
{
    NSMutableArray * muArray;
    
    NSString * str;
}
@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     muArray = [NSMutableArray arrayWithObjects:@"1.文华轩",@"2.希尔顿",@"3.威斯汀",@"4.万丽",@"5.朗庭",@"6.四季轩", nil];
}
- (IBAction)nameBtn:(UIButton *)sender {
     str = muArray[sender.tag-1];
     NSLog(@"当前选中:%@",str);
}

- (IBAction)nextBtn:(id)sender {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"您已选中%@",str] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * calcle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //点击确定.选定座位
        
        [self dismissViewControllerAnimated:YES completion:nil];
        //代理将位置传回去
        if ([self.delegate respondsToSelector:@selector(SureSelectSeat:)]) {
            
            [self.delegate SureSelectSeat:str];
        }
        
        
    }];
    
    [alert addAction:calcle];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}
   

- (IBAction)exit:(id)sender {
    
    TowViewController * vc = [[TowViewController alloc]init];
    [ComenTool transfromWithController:vc];
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
