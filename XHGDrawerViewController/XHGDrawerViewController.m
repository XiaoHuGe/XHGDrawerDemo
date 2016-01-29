//
//  XHGDrawerViewController.m
//  XHGDrawerDemo
//
//  Created by xiaohuge on 16/1/29.
//  Copyright © 2016年 xiaohuge. All rights reserved.
//

#import "XHGDrawerViewController.h"
#define screenW  [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height
@interface XHGDrawerViewController ()

@end

@implementation XHGDrawerViewController

#pragma mark -- setter方法
//距离上下位置
- (void)setMaxY:(CGFloat)maxY{
    _maxY = maxY;
    
}
//向右偏移
- (void)setOffsetRight:(CGFloat)offsetRight{
    _offsetRight = offsetRight;
}
//向左偏移
- (void)setOffsetLeft:(CGFloat)offsetLeft{
    
    _offsetLeft = offsetLeft;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //赋值初始值
    self.maxY = 0;
    self.offsetLeft = -(screenW * 0.7);
    self.offsetRight = screenW * 0.7;
    //添加View
    [self setUpView];
    
    //添加手势
    [self setupGesture];
}

#pragma mark -- 手势操作
- (void)setupGesture{
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainV addGestureRecognizer:pan];
    
    //给控制器的View添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    [self.view addGestureRecognizer:tap];
    
}

//点按
-(void)tapGes{
    
    //做复位操作.
    [UIView animateWithDuration:0.25 animations:^{
        self.mainV.frame = self.view.bounds;
    }];
    
}

//当手指拖动的时候调用
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //让mainV跟着手指移动而移动.
    
    //获取手指的偏移量
    CGPoint transP =  [pan translationInView:self.mainV];
    
    //直接修改Frame
    self.mainV.frame = [self frameWithoffsetX:transP.x];
    
    //判断当前mainV的x
    //如果x大于0,显示左边的内容
    //如果小于0显示右边的内容
    
    if(self.mainV.frame.origin.x > 0){
        //让右边隐藏
        self.rightV.hidden = YES;
    } else if(self.mainV.frame.origin.x < 0){
        //显示右边的内容
        self.rightV.hidden = NO;
    }
    
    CGFloat target = 0;
    //判断手势的状态,当手指离开View时,让它做定位
    if(pan.state == UIGestureRecognizerStateEnded){
        
        //当mainV的x大于屏幕宽度的一半时,自动定位右边.
        if (self.mainV.frame.origin.x > screenW * 0.5) {
            target = self.offsetRight;
        }else if(CGRectGetMaxX(self.mainV.frame) < screenW * 0.5){
            //当MaiV它的最大的X小于屏幕宽度的一半时,自动定位左边
            target = self.offsetLeft;
        }
        
        CGFloat offsetX = target - self.mainV.frame.origin.x;
        
        
        [UIView animateWithDuration:0.25 animations:^{
            self.mainV.frame = [self frameWithoffsetX:offsetX];
            
        }];
    }
    //复位
    [pan setTranslation:CGPointZero inView:self.mainV];
    
}



//根据一个偏移量计算mainV的frame.
- (CGRect)frameWithoffsetX:(CGFloat)offsetX{
    
    CGRect frame = self.mainV.frame;
    frame.origin.x += offsetX;
    
    //求y值(结果有可能为负, 所以在这个地方取个绝对值)
    frame.origin.y = fabs(frame.origin.x * self.maxY / screenW );
    
    //求高度
    frame.size.height = screenH - 2 * frame.origin.y;
    
    return frame;
}


#pragma mark -- 添加View
- (void)setUpView{
    
    //1.添加左边的View
    UIView *leftV = [[UIView alloc] initWithFrame:self.view.bounds];
    leftV.backgroundColor = [UIColor blueColor];
    _leftV = leftV;
    [self.view addSubview:leftV];
    
    
    //2.添加右边的View
    UIView *rightV = [[UIView alloc] initWithFrame:self.view.bounds];
    rightV.backgroundColor = [UIColor greenColor];
    _rightV = rightV;
    [self.view addSubview:rightV];
    
    //3.添加中间的View.
    UIView *mainV = [[UIView alloc] initWithFrame:self.view.bounds];
    mainV.backgroundColor = [UIColor redColor];
    _mainV = mainV;
    [self.view addSubview:mainV];
    
    
}


@end
