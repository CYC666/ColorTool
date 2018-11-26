//
//  BaseController.m
//  ColorTool
//
//  Created by 曹老师 on 2018/11/24.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏和文字的颜色
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.tintColor = [UIColor blackColor];
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                               NSForegroundColorAttributeName:[UIColor blackColor]};
    
}


//封装导航栏返回方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count>0) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [button sizeToFit];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        //push方式隐藏底部的tabbar
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

-(void)back {
    
    //pop返回
    [self popViewControllerAnimated:YES];
    
}

@end
