//
//  MainCell.m
//  ColorTool
//
//  Created by 曹老师 on 2018/11/26.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "MainCell.h"


@interface MainCell ()  {
    
    
}
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;




@end

@implementation MainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
    self.layer.cornerRadius = 5;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
}


- (void)setDic:(NSDictionary *)dic {
    
    _dic = dic;
    
    NSString *red = [NSString stringWithFormat:@"Red:%@", dic[@"R"]];
    NSString *green = [NSString stringWithFormat:@"Green:%@", dic[@"G"]];
    NSString *blue = [NSString stringWithFormat:@"Blue:%@", dic[@"B"]];
    NSString *alpha = [NSString stringWithFormat:@"Alpha:%@", dic[@"A"]];
    
    _label1.text = red;
    _label2.text = green;
    _label3.text = blue;
    _label4.text = alpha;
    
    NSString *r = [NSString stringWithFormat:@"%@", dic[@"R"]];
    NSString *g = [NSString stringWithFormat:@"%@", dic[@"G"]];
    NSString *b = [NSString stringWithFormat:@"%@", dic[@"B"]];
    NSString *a = [NSString stringWithFormat:@"%@", dic[@"A"]];
    
    _colorView.backgroundColor = CRGB(r.floatValue, g.floatValue, b.floatValue, a.floatValue / 255.0);
    
}



@end
