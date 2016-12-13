//
//  XQVC.m
//  DishDemo
//
//  Created by mac on 16/11/28.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "XQVC.h"

@interface XQVC ()

@property (weak, nonatomic) IBOutlet UILabel *lbl;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation XQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lbl.text = _dish.name;
    _lbl.textColor = [UIColor whiteColor];
    _lbl.font = [UIFont systemFontOfSize:20];
    _img.image = [UIImage imageNamed:_dish.picName];
    
}
- (IBAction)exit:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
