//
//  CYC666.h
//  LOLADFNeverGiveUp
//
//  Created by 曹老师 on 2018/8/13.
//  Copyright © 2018年 众利创投. All rights reserved.
//

#import <Foundation/Foundation.h>

// 如果字符串为空返回@“”，不为空则直接返回
#define String(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? @"" : str )

//设置状态栏样式
#define SetStatus(B) [UIApplication sharedApplication].statusBarStyle = B;

// 图片
#define CImage(name) [UIImage imageNamed:name]

// 按钮
#define CButtonTitle(Button,Title) [Button setTitle:Title forState:UIControlStateNormal];
#define CButtonColor(Button,Color) [Button setTitleColor:Color forState:UIControlStateNormal];
#define CButtonImage(Button,Name) [Button setImage:CImage(Name) forState:UIControlStateNormal];


@interface CYC666 : NSObject



//============================================历史记录===========================================
// 获取历史记录
+ (NSArray *)loadHistory;

// 添加历史记录
+ (void)setHistory:(NSDictionary *)dic;

// 删除历史记录
+ (void)deleteHistory;

// 删除某条历史记录
+ (void)deleteHistoryWithID:(NSString *)ID;

// 改变位置
+ (void)changeIndex:(NSInteger )index toIndex:(NSInteger )toIndex;



@end
