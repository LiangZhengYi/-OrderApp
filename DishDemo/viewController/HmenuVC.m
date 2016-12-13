//
//  HmenuVC.m
//  DishDemo
//
//  Created by mac on 16/11/30.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "HmenuVC.h"
#import "HMTableCell.h"
@interface HmenuVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray * dishArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableV;


@end

@implementation HmenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    dishArray = [NSMutableArray arrayWithArray:[databaseTool insertRoom]];
    
    [_tableV registerNib:[UINib nibWithNibName:@"hMTableView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dishArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HMTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    
    dishModel * dish = dishArray[indexPath.row];
    
    cell.dayLbl.text = [NSString stringWithFormat:@"%@",dish.date];
    cell.timeLbl.text = [NSString stringWithFormat:@"%@",dish.time];
    cell.nameLbl.text = [NSString stringWithFormat:@"%@",dish.room];
    
    [cell.lookBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



-(void)click:(UIButton *)btn{
    
}





- (IBAction)exitBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)emptyBtn:(id)sender {
    
//    [databaseTool deleteroomTable];
    [_tableV reloadData];
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
