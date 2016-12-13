//
//  MainVC.m
//  DishDemo
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "MainVC.h"
#import "TowViewController.h"
#import "GroupModel.h"
#import "zhuchuVC.h"
#import "LeftViewController.h"
@interface MainVC ()<UITableViewDataSource,UITableViewDelegate>

{
    __weak IBOutlet UITableView *rightTableV;
    NSMutableArray * bgImageArray;
    NSInteger selectRow;
    __weak IBOutlet UIButton *acBtn;
}

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    selectRow = 0;
//^^^^^^^^^^^^返回按钮
    [acBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
//^^^^^^^^^^^^^实现一下 对数据库的表进行查询
    bgImageArray = [[NSMutableArray alloc]initWithArray:[databaseTool selectGroupTable]];
//^^^^^^^^^^^^^^^^创建表
    rightTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    rightTableV.backgroundColor = [UIColor clearColor];
    rightTableV.rowHeight = rightTableV.frame.size.height/7;
    [rightTableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
// ^^^^^^^^^^^创建右边视图^^^^^^^^
    LeftViewController * lvc = nil;
    
    for (int i = 0; i<7; i++) {
        
        if (i==0) {
            lvc = [[zhuchuVC alloc]init];
            
        }
        
        else
        {
            
            lvc = [[LeftViewController alloc]init];
        }
        [self addChildViewController:lvc];
    }
    
    LeftViewController * vc = [self.childViewControllers objectAtIndex:0];
    [self.view addSubview:vc.view];
    [self.view bringSubviewToFront:rightTableV];
    [self.view bringSubviewToFront:acBtn];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return bgImageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GroupModel * model = bgImageArray[indexPath.row];
    
    if (selectRow == indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:model.img];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:model.hImg];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    selectRow = indexPath.row;
    [rightTableV reloadData];
    
    LeftViewController * vc = [self.childViewControllers objectAtIndex:indexPath.row];
    vc.index = selectRow;
    [vc reseCounTable];
    
    [self.view addSubview:vc.view];
    
    [self.view bringSubviewToFront:rightTableV];
    [self.view bringSubviewToFront:acBtn];
    
}
-(void)click{
    TowViewController * vc = [[TowViewController alloc]init];
    [ComenTool transfromWithController:vc];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
