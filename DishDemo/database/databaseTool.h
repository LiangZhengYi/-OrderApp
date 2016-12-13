//
//  databaseTool.h
//  DishDemo
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "menuTableModel.h"
@interface databaseTool : NSObject

//打开数据库
+(void)openDatabase;

//查询表右边按钮的数据
+(NSArray *)selectGroupTable;

//查询菜名
+(NSArray *)selectGroupTablewithGroupID:(NSInteger)GroupID;

+(NSArray *)selectMenuTablewithIkind:(NSString *)ikind;


//插入一道菜
+(void)insertDishWithDishID:(menuTableModel *)dish;

//获取点的菜的数量
+(NSInteger)selectCounOrderTable;





//查询所有数据并添加到表
+(NSMutableArray*)getOrderTableData;

//删除数据
+(void)deleteDishfromOrderTableWithName:(NSString*)name;

//更新备注
+(void)updataDishTableWithRemark:(NSString *)remark andName:(NSString*)name;

//更新数量
+(void)updataDishTableWithNumber:(int)num andName:(NSString*)name;

//清空所有数据
+(void)deleteFromOrderTable;

//插入就餐记录
+(void)insertANewWithDate:(NSString *)date time:(NSString *)time room:(NSString *)room;

//插入历史菜单
+(void)insertAllMenu;

+(void)deleteroomTable;
+(NSMutableArray *)insertRoom;
@end
