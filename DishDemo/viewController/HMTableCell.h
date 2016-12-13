//
//  HMTableCell.h
//  DishDemo
//
//  Created by mac on 16/12/2.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;

@end
