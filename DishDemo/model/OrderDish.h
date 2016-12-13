//
//  OrderDish.h
//  DishDemo
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDish : NSObject

//名称,价格,种类,数量,备注,点这道菜的总费用
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,copy) NSString * menuName;
@property (nonatomic,assign) int Price;
@property (nonatomic,copy) NSString * kind;
@property (nonatomic,assign) int number;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,assign) int totalCost;
@end
