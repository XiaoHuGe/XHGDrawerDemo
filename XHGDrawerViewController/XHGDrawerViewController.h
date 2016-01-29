//
//  XHGDrawerViewController.h
//  XHGDrawerDemo
//
//  Created by xiaohuge on 16/1/29.
//  Copyright © 2016年 xiaohuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHGDrawerViewController : UIViewController

/** 中间的View */
@property (nonatomic ,weak, readonly) UIView *mainV;
/** left的View */
@property (nonatomic ,weak,readonly) UIView *leftV;
/** right的View */
@property (nonatomic ,weak, readonly) UIView *rightV;


/** 中间视图距离上下的距离 */
@property (nonatomic ,assign) CGFloat maxY;

/** 中间视图向右的偏移距离 */
@property (nonatomic ,assign) CGFloat offsetRight;

/** 中间视图向左的偏移距离 这里为负数 */
@property (nonatomic ,assign) CGFloat offsetLeft;
@end
