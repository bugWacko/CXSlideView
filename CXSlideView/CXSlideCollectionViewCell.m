//
//  CXSlideCollectionViewCell.m
//  CXSlideView
//
//  Created by 陈晨昕 on 2017/6/19.
//  Copyright © 2017年 bugWacko. All rights reserved.
//

#import "CXSlideCollectionViewCell.h"

@implementation CXSlideCollectionViewCell

-(void)awakeFromNib {

    [super awakeFromNib];
    
    [self.imageView.layer setCornerRadius:10.0f];
}

@end
