//
//  ComenTool.m
//  DishDemo
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 LZY. All rights reserved.
//

#import "ComenTool.h"

#define KEY_WID [[[UIApplication sharedApplication]delegate]window]
@implementation ComenTool

+(void)transfromWithController:(UIViewController *)VC{
    
    KEY_WID.rootViewController = VC;
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [UIView setAnimationTransition:5 forView:KEY_WID cache:YES];
    
    [UIView commitAnimations];
}

+(void)cell:(UIView *)cell{
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
    
    [UIView commitAnimations];
}
@end
