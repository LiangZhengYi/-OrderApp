//
//  myOrderVC.m
//  DishDemo
//
//  Created by mac on 16/11/28.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "myOrderVC.h"
#import "sdVC.h"
#import "TableViewCell.h"

@interface myOrderVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray * OrderAarry;
}
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@end

@implementation myOrderVC


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取数据
    OrderAarry = [NSMutableArray arrayWithArray:[databaseTool getOrderTableData]];
    //添加TableView
     [_tableV registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return OrderAarry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell * cell = [_tableV dequeueReusableCellWithIdentifier:@"cell"];
    
//^^^^通过自定义cell 实现点餐之后 把菜单插入tableView中。
    OrderDish * dish = OrderAarry[indexPath.row];
    cell.xhBtn.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.cmBtn.text = dish.menuName;
    cell.djBtn.text = [NSString stringWithFormat:@"%d",dish.Price];
    cell.zlBtn.text = dish.kind;
    
//^^^^^cell上的两个输入框
    cell.tf1.text = [NSString stringWithFormat:@"%d",dish.number];
    cell.tf1.tag = indexPath.row +1;//目的:通过tag值来找到对应的索引值
    cell.tf1.delegate = self;//便于执行代理方法
    
    cell.tf2.text = dish.remark;
    cell.tf2.tag = 1000+indexPath.row;
    cell.tf2.delegate = self;
    
//^^^^^^^输入框的方法
    [cell.tf1 addTarget:self action:@selector(tf1:) forControlEvents:UIControlEventEditingDidEnd];
    [cell.tf2 addTarget:self action:@selector(tf2:) forControlEvents:UIControlEventEditingDidEnd];
    
//^^^^^删除表上的按钮
    cell.exitBtn.tag = indexPath.row + 1;
    [cell.exitBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


//改变数量
-(void)tf1:(UITextField *)tf1{
    //找到那道菜
//    OrderDish * dish = [OrderAarry objectAtIndex:tf1.tag-1];
//    //判断是否已经存在 或者《=0则不存在
//    if (tf1.text.intValue <= 0 || tf1.text.intValue == dish.number) {
//        return;
//    }
//    
//    //更新数组
//    dish.number = tf1.text.intValue;
    
    //更新数据库
//    [databaseTool ];
    
    
}
//改变备注
-(void)tf2:(UITextField *)tf2{
    
}

//^^^^^修改输入框数据 并更新到数据库中
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag >=1000) {
        //^^^^^修改备注
        OrderDish * dish = OrderAarry[textField.tag-1000];
        dish.remark = textField.text;
        [databaseTool updataDishTableWithRemark:dish.remark andName:dish.menuName];
        
        [_tableV reloadData];
    }
    else
    {
        //^^^^^^修改数量
        OrderDish * dish = OrderAarry[textField.tag-1];
        dish.number = [textField.text intValue];
        
        [databaseTool updataDishTableWithNumber:dish.number andName:dish.menuName];
        
        [_tableV reloadData];
    }
}

//^^^^^^^删除菜单
-(void)click:(UIButton *)btn{
    
    OrderDish * dish = OrderAarry[btn.tag-1];
    [databaseTool deleteDishfromOrderTableWithName:dish.menuName];
    
    [OrderAarry removeObjectAtIndex:btn.tag-1];
    
    [_tableV reloadData];
}
- (IBAction)exitBtn:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

//^^^^^^送单按钮
- (IBAction)sdBtn:(id)sender {
    
    sdVC * vc = [[sdVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

//^^^^^价格汇总按钮
- (IBAction)hzBtn:(id)sender {
    int allPrice = 0;
    
    for (OrderDish * dish in OrderAarry) {
        allPrice = allPrice + dish.Price * dish.number;
        
    }
    _lbl.text =[NSString stringWithFormat:@"%d",allPrice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
