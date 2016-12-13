//
//  TableViewCell.h
//  DishDemo
//
//  Created by mac on 16/11/28.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

//序号
@property (weak, nonatomic) IBOutlet UILabel *xhBtn;

//菜名
@property (weak, nonatomic) IBOutlet UILabel *cmBtn;

//单价
@property (weak, nonatomic) IBOutlet UILabel *djBtn;

//种类
@property (weak, nonatomic) IBOutlet UILabel *zlBtn;

//输入框 数量·备注
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@end
