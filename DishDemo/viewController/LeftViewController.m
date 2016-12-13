//
//  LeftViewController.m
//  DishDemo
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "LeftViewController.h"
#import "menuTableModel.h"
#import "XQVC.h"
#import "myOrderVC.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UIButton *myOrder;//我的菜单按钮
    
    __weak IBOutlet UITableView *leftTableV;
    
    __weak IBOutlet UIScrollView *sclloV;
    
     NSInteger _selected;//某一个区
    
    __weak IBOutlet UILabel *lbl;//显示点菜数量
    
    NSMutableArray * leftArray;//所有数据数组
   
    NSArray * titleArray;//右边按钮的数组
    
    
    UIImageView * imgV;//点击订单显示的动画
  
}
@property (weak, nonatomic) IBOutlet UIImageView *lblImage;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageV;// 标题图片

@end

@implementation LeftViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self resetScrollV];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//^^^^^^^^^^^我的菜单
    [myOrder addTarget:self action:@selector(myOrderBtn:) forControlEvents:UIControlEventTouchUpInside];

    
    
//^^^^^^^^^^^设置标题
    _titleImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ldicon.png",_index+1]];
    
//^^^^^^^^^^^获取数据  菜品名称
    titleArray =[[NSArray alloc]initWithArray:[databaseTool selectGroupTablewithGroupID:_index+1]];
    leftArray = [[NSMutableArray alloc]init];
    
    for (NSString * ikind in titleArray) {
        
        NSArray * array = [databaseTool selectMenuTablewithIkind:ikind];
        
        [leftArray addObject:array];
    }
    
  
//^^^^^^^^^^^^创建表
    leftTableV.backgroundColor = [UIColor clearColor];
    leftTableV.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
//^^^^^^^^^^^^^滚动视图
    sclloV.delegate = self;
    sclloV.pagingEnabled = YES;
//^^^^^^^^^^^^^滚动视图
    [self resetScrollV];
//^^^^^^^^^^^^^更新菜品数量
    [self reseCounTable];
}
//点击区头之后触发滚动视图 并显示对应图片
-(void)resetScrollV{
    
    NSArray * array =[leftArray objectAtIndex:_selected];
    sclloV.contentSize = CGSizeMake(sclloV.frame.size.width * array.count, sclloV.frame.size.height);
    
    //遍历sclloV 移除之前图片
    for (UIView * view in sclloV.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i=0; i<array.count; i++) {
        menuTableModel * dish = [array objectAtIndex:i];
        
        UIImageView * img = [[UIImageView alloc]init];
        img.frame = CGRectMake(sclloV.frame.size.width*i, 0, sclloV.frame.size.width, sclloV.frame.size.height);
        img.image = [UIImage imageNamed:dish.picName];
        [sclloV addSubview:img];
    }
    [sclloV setContentOffset:CGPointMake(0, 0)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _selectRow = sclloV.contentOffset.x/sclloV.frame.size.width;
    [leftTableV reloadData];
    
    UITableViewCell * cell = [leftTableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:_selected]];
    
    [ComenTool cell:cell];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titleArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_selected == section) {

        return [[leftArray objectAtIndex:section]count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.backgroundColor= [UIColor clearColor ];
        
        UIImageView * backImageView = [[UIImageView alloc]initWithFrame:cell.bounds];
        backImageView.image = [UIImage imageNamed:@"line32"];
        backImageView.tag = 55;
        [cell.contentView addSubview:backImageView];
        
    }
    
    UIImageView * img = [cell.contentView viewWithTag:55];
    if (_selectRow == indexPath.row) {
        img.hidden = NO;//当选择某一行时 让这行的图片出现
    }
    else
    {
        img.hidden = YES;
    }
    
    menuTableModel * dish = [[leftArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"     %@",dish.name];
    cell.textLabel.textColor = [UIColor whiteColor];

    cell.detailTextLabel.text =[NSString stringWithFormat:@"(%@元/%@)",dish.price,dish.unit];
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    
    return cell;
}


//设置区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = section+2;
    [button setTitle:titleArray[section] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"line33"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:30];
    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}


-(void)click:(UIButton *)btn{
     _selectRow = 0;
    
    NSMutableIndexSet * indeSet = [NSMutableIndexSet indexSet];
    [indeSet addIndex:_selected];
    
    _selected = btn.tag-2;

    
    [leftTableV reloadData];
    
    [self resetScrollV];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectRow = indexPath.row;
    
    [leftTableV reloadData];
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [ComenTool cell:cell];
    
    //点击单元格 滚动视图显示对应图片。
    [sclloV setContentOffset:CGPointMake(_selectRow*sclloV.frame.size.width, 0) animated:YES];
}

//点菜按钮
- (IBAction)acBtn:(id)sender {
    
    menuTableModel * dish = [[leftArray objectAtIndex:_selected] objectAtIndex:_selectRow];
    
    //点击的时候设置动画
    if (!imgV) {
        imgV = [[UIImageView alloc]init];
        [self.view addSubview:imgV];
    }
    
    imgV.frame = sclloV.frame;
    imgV.alpha = 1;
    imgV.image = [UIImage imageNamed:dish.picName];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    imgV.alpha = 0;
    imgV.frame = myOrder.frame;
    [UIView commitAnimations];
    
    //把菜插入到数据库响应表中
    [databaseTool insertDishWithDishID:dish];
    
    //更新菜的数量
    [self reseCounTable];
}

//更新菜
-(void)reseCounTable{
    
    lbl.text = [NSString stringWithFormat:@"%ld",(long)[databaseTool selectCounOrderTable]];
}

//详情按钮
- (IBAction)xqBtn:(id)sender {
    
    menuTableModel * dish = [[leftArray objectAtIndex:_selected]objectAtIndex:_selectRow];
    XQVC * vc = [[XQVC alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    vc.dish = dish;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)myOrderBtn:(UIButton *)btn{
    myOrderVC * vc = [[myOrderVC alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
