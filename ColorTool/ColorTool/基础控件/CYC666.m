//
//  CYC666.m
//  LOLADFNeverGiveUp
//
//  Created by 曹老师 on 2018/8/13.
//  Copyright © 2018年 众利创投. All rights reserved.
//

#import "CYC666.h"


@implementation CYC666




#pragma mark - 如果有小数，返回两位，没有就只保留整数
+ (NSString *)autoString:(NSString *)text {
    
    if (text.floatValue > text.integerValue) {
        return [NSString stringWithFormat:@"%.2f", text.floatValue];
    } else {
        return [NSString stringWithFormat:@"%.0f", text.floatValue];
    }
    
}

#pragma mark ========================================按钮=============================================


#pragma mark ========================================图片=============================================




#pragma mark ========================================其他=============================================

#pragma mark ========================================历史记录=============================================

#pragma mark - 获取历史记录
+ (NSArray *)loadHistory {
    
    NSArray *historyList = [[NSUserDefaults standardUserDefaults] objectForKey:@"HISTORY_CITY"];
    
    if (!historyList || historyList.count == 0) {
        return @[];
    } else {
        return historyList;
    }
    
}

#pragma mark - 添加历史记录
+ (void)setHistory:(NSDictionary *)dic {
    
    NSMutableArray *list = [self loadHistory].mutableCopy;
    
//    if (list.count >= 8) {
//        [list removeLastObject];
//    }
    
    // 去重复
    for (NSDictionary *model in list) {
        
        if ([model[@"ID"] isEqualToString:dic[@"ID"]]) {
            
            // 找到同样的，不执行添加
            return;
        }
        
    }
    
    [list insertObject:dic atIndex:0];
    
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"HISTORY_CITY"];
    
}

#pragma mark - 删除历史记录
+ (void)deleteHistory {
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"HISTORY_CITY"];
    
}

#pragma mark - 删除历史记录
+ (void)deleteHistoryWithID:(NSString *)ID {
    
    NSMutableArray *list = [self loadHistory].mutableCopy;
    
    
    // 去重复
    for (NSDictionary *model in list) {
        
        if ([model[@"ID"] isEqualToString:ID]) {
            
            // 删除
            [list removeObject:model];
        }
        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"HISTORY_CITY"];
    
    
}

#pragma mark - 改变位置
+ (void)changeIndex:(NSInteger )index toIndex:(NSInteger )toIndex {
    
    NSMutableArray *list = [self loadHistory].mutableCopy;
    
    [list exchangeObjectAtIndex:index withObjectAtIndex:toIndex];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:@"HISTORY_CITY"];
    
    
    
    
}















@end
