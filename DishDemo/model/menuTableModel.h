//
//  menuTableModel.h
//  DishDemo
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface menuTableModel : NSObject

@property (nonatomic,assign)NSInteger  dishID;

@property (nonatomic,assign)NSInteger groupID;

@property (nonatomic,copy)NSString *iKind;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *price;

@property (nonatomic,copy)NSString *unit;

@property (nonatomic,copy)NSString *detail;

@property (nonatomic,copy)NSString *picName;

@end
