//
//  CXSlideCollectionViewFlowLayout.m
//  CXSlideView
//
//  Created by 陈晨昕 on 2017/6/19.
//  Copyright © 2017年 bugWacko. All rights reserved.
//

#import "CXSlideCollectionViewFlowLayout.h"

//方法一中使用
//static CGFloat const activeDistance = 350;
//static CGFloat const scaleFactor = 0.05;

@implementation CXSlideCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 20.0;
        
        //设置内容缩进
        self.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
    }
    return self;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    /*
    //方法一
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = distance / activeDistance;
        CGFloat zoom = 1 + scaleFactor * (1 - ABS(normalizedDistance));
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.zIndex = 1;
    }
    return array;
     */
    
    //方法二
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance / self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/6到 +π/6这一个范围内 可根据具体情况自行调整
        CGFloat scale = fabs(cos(apartScale * M_PI / 6));
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
