//
//  ViewController.m
//  CXSlideView
//
//  Created by 陈晨昕 on 2017/6/16.
//  Copyright © 2017年 bugWacko. All rights reserved.
//

#import "ViewController.h"
#import "CXSlideCollectionViewCell.h"
#import "CXSlideCollectionViewFlowLayout.h"

@interface ViewController () {

    NSInteger _currentIndex;//cell索引
    CGFloat   _dragStartX;//拖到开始点
    CGFloat   _dragEndX;//拖动结束点
}

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;


@end

static NSString * ReuseIdentifier = @"CXSlideCollectionViewCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CXSlideCollectionViewFlowLayout * layout = [[CXSlideCollectionViewFlowLayout alloc] init];
    [self.myCollectionView setCollectionViewLayout:layout];
    [self.myCollectionView reloadData];
}

#pragma mark - UICollectionView Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CXSlideCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.row % 3 == 0) {
        cell.imageView.image = [UIImage imageNamed:@"bg-9"];
        
    } else if (indexPath.row % 3 == 1) {
        cell.imageView.image = [UIImage imageNamed:@"bg-15"];
        
    } else {
        cell.imageView.image = [UIImage imageNamed:@"bg-22"];
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, [UIScreen mainScreen].bounds.size.height - 64 - 60 - 60);
}

#pragma mark - UIScrollView Delegate
//手指拖动开始
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

//配置cell居中
-(void)fixCellToCenter
{
    //最小滚动距离
    float dragMiniDistance = 50;//self.view.bounds.size.width / 10.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;//向右
    } else if(_dragEndX -  _dragStartX >= dragMiniDistance) {
        _currentIndex += 1;//向左
    }
    NSInteger maxIndex = [self.myCollectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    
    [self.myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
