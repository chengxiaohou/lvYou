//
//  CollectionViewCell.m
//  ChengFengSuDa
//
//  Created by 小马网络 on 2016/12/21.
//  Copyright © 2016年 小马网络. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(void)setImage:(UIImage *)image {
    
    _image = image;
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV.clipsToBounds = YES;
    self.imageV.image = _image;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [[[NSBundle mainBundle]loadNibNamed:@"cell" owner:nil options:nil]lastObject];
    }
    
    return self;
    
}

@end
