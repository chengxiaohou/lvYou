//
//  CollectionViewCell.h
//  ChengFengSuDa
//
//  Created by 小马网络 on 2016/12/21.
//  Copyright © 2016年 小马网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
- (id)initWithFrame:(CGRect)frame;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) UIView *controllerView;
@property (strong, nonatomic) UIImage *image;

@end
