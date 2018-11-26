//
//  MainController.m
//  ColorTool
//
//  Created by 曹老师 on 2018/11/24.
//  Copyright © 2018 曹奕程. All rights reserved.
//

#import "MainController.h"
#import "MainCell.h"

@interface MainController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    UICollectionView *_listCollectionView;
    NSMutableArray *dataArray;   // 数据列表
    
}

@end

@implementation MainController


#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"取色宝";
    dataArray = [NSMutableArray array];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xinxi"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    
    // 集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth - 30) / 2.0, (kScreenWidth - 30) / 2.0 + 60);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Nav_Height, kScreenWidth, kScreenHeight - Nav_Height)
                                             collectionViewLayout:layout];
    _listCollectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _listCollectionView.backgroundColor = [UIColor clearColor];
    [_listCollectionView registerNib:[UINib nibWithNibName:@"MainCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"MainCell"];
    _listCollectionView.delegate = self;
    _listCollectionView.dataSource = self;
    [self.view addSubview:_listCollectionView];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [_listCollectionView addGestureRecognizer:longPressGesture];
    
    
}


#pragma mark ========================================动作响应=============================================

#pragma mark - 左边按钮
- (void)leftButtonAction:(UIBarButtonItem *)button {
    
    
    if (dataArray.count > 0) {
        [dataArray removeLastObject];
        [_listCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    }
    
    
}

#pragma mark - 右边按钮
- (void)rightButtonAction:(UIBarButtonItem *)button {
    
    [dataArray addObject:@""];
    [_listCollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:dataArray.count-1 inSection:0]]];
    
}

#pragma mark - 长按可拖动
- (void)longPressAction:(UILongPressGestureRecognizer *)press {
    
    CGPoint point = [press locationInView:_listCollectionView];
    NSIndexPath *indexPath = [_listCollectionView indexPathForItemAtPoint:point];
    UICollectionViewCell *cell = [_listCollectionView cellForItemAtIndexPath:indexPath];
    
    //根据长按手势的状态进行处理。
    switch (press.state) {
            case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
            //开始移动
            cell.transform = CGAffineTransformMakeScale(1.1, 1.1);
            [_listCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
            
            
            case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            cell.transform = CGAffineTransformMakeScale(1.1, 1.1);
            [_listCollectionView updateInteractiveMovementTargetPosition:point];
            break;
            
            
            case UIGestureRecognizerStateEnded:
            //停止移动调用此方法
            cell.transform = CGAffineTransformMakeScale(1, 1);
            [_listCollectionView endInteractiveMovement];
            break;
            
            
        default:
            //取消移动
            cell.transform = CGAffineTransformMakeScale(1, 1);
            [_listCollectionView cancelInteractiveMovement];
            break;
    }
    
}

#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================
#pragma mark - 集合视图代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return dataArray.count;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCell" forIndexPath:indexPath];
    
    
    return cell;
    
}

- (BOOL)beginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)updateInteractiveMovementTargetPosition:(CGPoint)targetPosition {
    
    
    
}

- (void)endInteractiveMovement {
    
}

- (void)cancelInteractiveMovement {
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath
           toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [dataArray removeObjectAtIndex:sourceIndexPath.row];
    [dataArray insertObject:@"" atIndex:destinationIndexPath.row];
    
    
}



























@end
