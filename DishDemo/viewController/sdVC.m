//
//  sdVC.m
//  DishDemo
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "sdVC.h"
#import "TableVC.h"
#import "TowViewController.h"
@interface sdVC ()<seatDelegate,UIAlertViewDelegate>

@end

@implementation sdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.lbl];
    
}
//通过代理传值方法 实现选择餐厅位置
- (IBAction)Next:(id)sender {
    
    TableVC * vc = [[TableVC alloc]init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)SureSelectSeat:(NSString *)seat{
    self.lbl.text = seat;
}

- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)songDanBtn:(id)sender {

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"已成功完成送单 请重新点餐！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        //获取日期
        NSDate * num = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString * date = [formatter stringFromDate:num];
        //获取时间
        [formatter setDateFormat:@"hh:mm:ss"];
        NSString * time = [formatter stringFromDate:num];
        //获取房间
        NSString * room =self.lbl.text;
        
        [databaseTool insertANewWithDate:date time:time room:room];
        
        
        //记录本次就餐的所有菜 存到历史菜单中
//        [databaseTool insertAllMenu];
        
        //删除菜单
    
        [databaseTool deleteFromOrderTable];//清空所有数据
        TowViewController * vc = [[TowViewController alloc]init];
        
        [ComenTool transfromWithController:vc];
    }
}

@end
