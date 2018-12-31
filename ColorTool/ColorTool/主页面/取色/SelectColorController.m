//
//  SelectColorController.m
//  ColorTool
//
//  Created by 曹老师 on 2018/12/16.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "SelectColorController.h"

@interface SelectColorController ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *showIcon;


@property (weak, nonatomic) IBOutlet UIView *showColorView;

@property (weak, nonatomic) IBOutlet UITextField *fieldR;
@property (weak, nonatomic) IBOutlet UITextField *fieldG;
@property (weak, nonatomic) IBOutlet UITextField *fieldB;
@property (weak, nonatomic) IBOutlet UITextField *fieldA;


@property (weak, nonatomic) IBOutlet UISlider *sliderR;
@property (weak, nonatomic) IBOutlet UISlider *sliderG;
@property (weak, nonatomic) IBOutlet UISlider *sliderB;
@property (weak, nonatomic) IBOutlet UISlider *sliderA;



@end

@implementation SelectColorController


#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"取色";
    self.showIcon.superview.alpha = 0;    // 先不显示
    
    
    // 导航栏右边的添加按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    
    
    
    
    [self.fieldR addTarget:self action:@selector(fieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.fieldG addTarget:self action:@selector(fieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.fieldB addTarget:self action:@selector(fieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.fieldA addTarget:self action:@selector(fieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    
    [self.sliderR addTarget:self action:@selector(sliderChangeAction:) forControlEvents:UIControlEventValueChanged];
    [self.sliderG addTarget:self action:@selector(sliderChangeAction:) forControlEvents:UIControlEventValueChanged];
    [self.sliderB addTarget:self action:@selector(sliderChangeAction:) forControlEvents:UIControlEventValueChanged];
    [self.sliderA addTarget:self action:@selector(sliderChangeAction:) forControlEvents:UIControlEventValueChanged];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.icon addGestureRecognizer:longPress];
    self.icon.userInteractionEnabled = YES;

    
    
}


#pragma mark - 刷新UI
- (void)updateUIAction {

    self.showColorView.backgroundColor = CRGB(self.sliderR.value, self.sliderG.value, self.sliderB.value, self.sliderA.value / 255.0);

}

#pragma mark - 更新输入框
- (void)updateFieldAction {
    
    // 改变输入框
    self.fieldR.text = [NSString stringWithFormat:@"%.0f", self.sliderR.value];
    self.fieldG.text = [NSString stringWithFormat:@"%.0f", self.sliderG.value];
    self.fieldB.text = [NSString stringWithFormat:@"%.0f", self.sliderB.value];
    self.fieldA.text = [NSString stringWithFormat:@"%.0f", self.sliderA.value];
    
}

#pragma mark - 更新滑动条
- (void)updateSliderAction {
    
    // 改变滑动条
    self.sliderR.value = self.fieldR.text.floatValue;
    self.sliderG.value = self.fieldG.text.floatValue;
    self.sliderB.value = self.fieldB.text.floatValue;
    self.sliderA.value = self.fieldA.text.floatValue;
    
}



#pragma mark ========================================动作响应=============================================

#pragma mark - 添加
- (void)rightButtonAction:(UIBarButtonItem *)item {
    
    // 设置日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSDictionary *dic = @{@"R" : self.fieldR.text,
                          @"G" : self.fieldG.text,
                          @"B" : self.fieldB.text,
                          @"A" : self.fieldA.text,
                          @"ID" : str
                          };
    
    [CYC666 setHistory:dic];
    
    SVP_SUCCESS(@"已收藏")
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 长按图片
- (void)longPressAction:(UILongPressGestureRecognizer *)press {
    
    CGPoint point = [press locationInView:self.icon];

    // 拾取颜色
    [self colorAtPixel:point];
    
    // 右上角的预览
    [self setShowIconAction:press];
    
}

#pragma mark - 输入框
- (void)fieldChangeAction:(UITextField *)field {
    
    
    
    if (field.text.floatValue > 255) {
        
        field.text = @"255";
        
    } else if (field.text.floatValue < 0) {
        
        field.text = @"0";
        
    } else {
        
        
    }
    
    
    
    [self updateSliderAction];
    [self updateUIAction];
    
    
    
}


#pragma mark - 滑动条
- (void)sliderChangeAction:(UISlider *)slider {
    
    [self updateFieldAction];
    [self updateUIAction];
    
}



#pragma mark ========================================网络请求=============================================


#pragma mark -  获取图片某点的颜色
- (void)colorAtPixel:(CGPoint )point {
    
    
    UIImageView *imageView = self.icon;
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = imageView.image.CGImage;
    NSUInteger width = imageView.bounds.size.width;
    NSUInteger height = imageView.bounds.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // 把[0,255]的颜色值映射至[0,1]区间
    CGFloat red   = (CGFloat)pixelData[0];
    CGFloat green = (CGFloat)pixelData[1];
    CGFloat blue  = (CGFloat)pixelData[2];
    CGFloat alpha = (CGFloat)pixelData[3];
    
    // 改变输入框
    self.fieldR.text = [NSString stringWithFormat:@"%.0f", red];
    self.fieldG.text = [NSString stringWithFormat:@"%.0f", green];
    self.fieldB.text = [NSString stringWithFormat:@"%.0f", blue];
    self.fieldA.text = [NSString stringWithFormat:@"%.0f", alpha];
    
    // 改变滑动条
    self.sliderR.value = red;
    self.sliderG.value = green;
    self.sliderB.value = blue;
    self.sliderA.value = alpha;
    
    [self updateUIAction];
}


#pragma mark - 分解颜色
- (void)RGBValueFromUIColor:(UIColor *)color {
    
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    //获取红色值
    CGFloat r = [[RGBArr objectAtIndex:1] floatValue] * 255;
    //获取绿色值
    CGFloat g = [[RGBArr objectAtIndex:2] floatValue] * 255;
    //获取蓝色值
    CGFloat b = [[RGBArr objectAtIndex:3] floatValue] * 255;
    
    // 改变输入框
    self.fieldR.text = [NSString stringWithFormat:@"%.0f", r];
    self.fieldG.text = [NSString stringWithFormat:@"%.0f", g];
    self.fieldB.text = [NSString stringWithFormat:@"%.0f", b];
    self.fieldA.text = @"255";
    
    // 改变滑动条
    self.sliderR.value = r;
    self.sliderG.value = g;
    self.sliderB.value = b;
    self.sliderA.value = 255;
    
    if (r > 125 && g > 125 && b > 125) {
        self.fieldR.textColor = [UIColor darkGrayColor];
        self.fieldG.textColor = [UIColor darkGrayColor];
        self.fieldB.textColor = [UIColor darkGrayColor];
        self.fieldA.textColor = [UIColor darkGrayColor];
    } else {
        self.fieldR.textColor = [UIColor whiteColor];
        self.fieldG.textColor = [UIColor whiteColor];
        self.fieldB.textColor = [UIColor whiteColor];
        self.fieldA.textColor = [UIColor whiteColor];
    }
    
}

#pragma mark - 设置右上角的预览显示
- (void)setShowIconAction:(UILongPressGestureRecognizer *)press {
    
    
    
    // 控制显示区域 50*50
    // 触点位置放在中间显示
    CGPoint point = [press locationInView:self.icon];
    float width = self.icon.bounds.size.width;
    float height = self.icon.bounds.size.height;
    
    float distanceX = point.x - width * 0.5;
    float distanceY = point.y - height * 0.5;
    
    self.showIcon.transform = CGAffineTransformMakeTranslation(-distanceX, -distanceY);
    
    
    // 控制显示
    [UIView animateWithDuration:.35 animations:^{
        
        if (press.state == UIGestureRecognizerStateBegan || press.state == UIGestureRecognizerStateChanged) {
            
            // 显示
            self.showIcon.superview.alpha = 1;
            
        } else {
            
            // 隐藏
            self.showIcon.superview.alpha = 0;
        }
        
    }];
    
}

#pragma mark ========================================代理方法=============================================






































@end
