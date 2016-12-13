//
//  TableVC.h
//  DishDemo
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol seatDelegate <NSObject>

-(void)SureSelectSeat:(NSString *)seat;

@end
@interface TableVC : UIViewController
@property (nonatomic,assign)id<seatDelegate>delegate;

@end
