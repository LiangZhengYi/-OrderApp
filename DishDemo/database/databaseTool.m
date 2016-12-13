//
//  databaseTool.m
//  DishDemo
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "databaseTool.h"
#import "FMDatabase.h"
#import "GroupModel.h"
#import "menuTableModel.h"
static FMDatabase * _db;
@implementation databaseTool

//打开数据库
+(void)openDatabase{
    
   //资源路径
    NSString * Spath = [[NSBundle mainBundle]pathForResource:@"database" ofType:@"sqlite"];
   //目的路径
    NSString * toPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"];
    
    NSFileManager * manager = [NSFileManager defaultManager];
    //如果目的路径不存在就拷贝
    if (![manager fileExistsAtPath:toPath]) {
        
        [manager copyItemAtPath:Spath toPath:toPath error:nil];
    }
    //创建对象
    _db = [[FMDatabase alloc]initWithPath:toPath];
    //打开数据库
    if ([_db open]) {
        
        NSLog(@"打开成功");
    }
    else
    {
        NSLog(@"打开失败");
    }
}
+(NSArray *)selectGroupTable{
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    if ([_db open]) {
        
        NSString * sql =@"select * from groupTable";
        
        FMResultSet * set = [_db executeQuery:sql];
        
        while ([set next]) {
            GroupModel * model = [[GroupModel alloc]init];
            model.groupID = [set intForColumnIndex:0];
            model.kind = [set stringForColumnIndex:1];
            model.name = [set stringForColumnIndex:2];
            model.img = [set stringForColumnIndex:3];
            model.hImg = [set stringForColumnIndex:4];
            
            [array addObject:model];
          
        }
        [set close];
    }
    return array;
}

//查询菜名
+(NSArray *)selectGroupTablewithGroupID:(NSInteger)GroupID{
    
    NSString * sql = [NSString stringWithFormat:@"select * from groupTable where id = %ld",GroupID];
    
    FMResultSet * set = [_db executeQuery:sql];
    [set next];
    
    NSString * name = [set stringForColumn:@"name"];
    
    [set close];
    
    return [name componentsSeparatedByString:@"|"];
}


+(NSArray *)selectMenuTablewithIkind:(NSString *)ikind{
    
    NSString * sql = [NSString stringWithFormat:@"select * from menuTable where iKind ='%@'",ikind];
    
    FMResultSet * set = [_db executeQuery:sql];
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    while ([set next]) {
        
        menuTableModel * model = [[menuTableModel alloc]init];
        model.dishID = [set intForColumnIndex:0];
        
        model.groupID = [set intForColumnIndex:1];
        
        model.iKind = [set stringForColumnIndex:2];
        
        model.name = [set stringForColumnIndex:3];
        
        model.price = [set stringForColumnIndex:4];
        
        model.unit = [set stringForColumnIndex:5];
        
        model.detail = [set stringForColumnIndex:6];
        
        model.picName = [set stringForColumnIndex:7];
        
        [array addObject:model];
    }
    return array;
}


//插入一道菜
+(void)insertDishWithDishID:(menuTableModel *)dish{
    //首先查询这道菜是否存在
    NSString *sql=[NSString stringWithFormat:@"select * from orderTable where id=%ld",(long)dish.dishID];
    FMResultSet *set=[_db executeQuery:sql];
    //如果返回YES,说明有这道菜已经存在，返回NO，说明无结果，不存在
    if ([set next]) {
        //存在
        //查询这道菜当前的数量
        int count=[set intForColumn:@"menuNum"];
        //        在此数量山加1，再更新
        sql=[NSString stringWithFormat:@"update orderTable set menuNum=%d where id=%ld",count+1,(long)dish.dishID];
        [_db executeUpdate:sql];
    }else
    {
        //不存在
        sql=[NSString stringWithFormat:@"insert into orderTable values(%ld,'%@','%@','%@',%d,'%@')",(long)dish.dishID,dish.name,dish.price,dish.iKind,1,@""];
        [_db executeUpdate:sql];
    }
    [set close];
}

//更新
+(NSInteger)selectCounOrderTable{
    //查询所有数据
    NSString *sql=@"select count(*) from orderTable";
    
    FMResultSet *set=[_db executeQuery:sql];
    [set next];
    int count=[set intForColumnIndex:0];
    [set close];
    return count;
}


//查询数据
+(NSMutableArray*)getOrderTableData
{
    NSMutableArray * muAry = [NSMutableArray array];
        
        FMResultSet * set = [_db executeQuery:@"select * from orderTable"];
        
        while ([set next]) {
            OrderDish * dishObj = [[OrderDish alloc]init];
            dishObj.ID = [set intForColumnIndex:0];
            dishObj.menuName = [set stringForColumnIndex:1];
            
            dishObj.Price = [set intForColumnIndex:2];
            dishObj.kind = [set stringForColumnIndex:3];
            dishObj.number = [set intForColumnIndex:4];
            dishObj.remark = [set stringForColumnIndex:5];
            //合计
//            dishObj.totalCost = dishObj.Price * dishObj.number;
            
            [muAry addObject:dishObj];
            
    }
    [set close];
    return muAry;
}


//删除数据
+(void)deleteDishfromOrderTableWithName:(NSString*)name
{
    
    NSString * sql = [NSString stringWithFormat:@"delete from orderTable where menuName = '%@'",name];
    
    BOOL reslut = [_db executeUpdate:sql];
    
        if (reslut) {
            
            NSLog(@"删除成功");
        }
        else
        {
            NSLog(@"失败");
        }
   
}
//更新 cell上输入框的数据
+(void)updataDishTableWithRemark:(NSString *)remark andName:(NSString*)name
{
    
    NSString * sql = [NSString stringWithFormat:@"update orderTable set remark = '%@' where menuName = '%@'",remark,name];
        
    BOOL result = [_db executeUpdate:sql];
    
        if (result)
        {
            NSLog(@"更新备注成功");
        }
        else
        {
            NSLog(@"更新失败");
        }
}
    
+(void)updataDishTableWithNumber:(int)num andName:(NSString*)name
{
    
    NSString * sql = [NSString stringWithFormat:@"update orderTable set menuNum = %d where menuName = '%@'",num,name];
        
    BOOL result = [_db executeUpdate:sql];
        if (result)
        {
            NSLog(@"更新成功");
        }
        else
        {
            NSLog(@"更新失败");
        }
}


//清空数据
+(void)deleteFromOrderTable
{
    NSString * sql = @"delete from orderTable";
    BOOL result = [_db executeUpdate:sql];
    if(result)
        {
            NSLog(@"送单成功");
        }
        else
        {
            NSLog(@"送单失败");
        }
        [_db close];
}

+(void)insertANewWithDate:(NSString *)date time:(NSString *)time room:(NSString *)room{
    NSString * sql = [NSString stringWithFormat:@"insert into group_recordTable (date,time,room) values ('%@','%@','%@')",date,time,room];
    [_db executeUpdate:sql];
}

+(void)insertAllMenu{
    
    NSString * sql = @"select max() from group_recordTable";
    FMResultSet * set = [_db executeQuery:sql];
    
    [set next];
    
    int maxID = [set intForColumnIndex:0];
    [set close];
    
    NSArray * array = [databaseTool getOrderTableData];
    
    for (OrderDish * dish in array) {
        sql = [NSString stringWithFormat:@"insert into recordTable (stateNum,menuName,menuPrice,menuKind,menuNum,menuRemark,groupID) values (0,'%@','%d','%@',%@,'%@',%d)",dish.menuName,dish.Price,dish.kind,dish.menuName,dish.remark,maxID];
        
        [_db executeUpdate:sql];
    }
}


+(NSMutableArray *)insertRoom{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    FMResultSet * set = [_db executeQuery:@"select * from room_recordTable"];
    while ([set next]) {
        dishModel * dish = [[dishModel alloc]init];
        dish.ID = [set intForColumnIndex:0];
        dish.date = [set stringForColumnIndex:1];
        dish.time = [set stringForColumnIndex:2];
        dish.room = [set stringForColumnIndex:3];
        
        [array addObject:dish];
    }
    [set close];
    return array;
}
//清空数据
+(void)deleteroomTable
{
    NSString * sql = @"delete from room_recordTable";
    BOOL result = [_db executeUpdate:sql];
    if(result)
    {
        NSLog(@"清空成功");
    }
    else
    {
        NSLog(@"清空失败");
    }
    [_db close];
}



@end
