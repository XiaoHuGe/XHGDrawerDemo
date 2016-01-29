//
//  ViewController.m
//  XHGDrawerDemo
//
//  Created by xiaohuge on 16/1/29.
//  Copyright © 2016年 xiaohuge. All rights reserved.
//

#import "ViewController.h"
#import "XHGDrawerViewController.h"
#import "XHGTableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加抽屉控制器到当前控制器
    XHGDrawerViewController *drawer = [[XHGDrawerViewController alloc] init];
    
    [self addChildViewController:drawer];
    [self.view addSubview:drawer.view];
    
    //包装中间的控制器为导航控制器  幷添加
    UIViewController *control = [[UINavigationController alloc] initWithRootViewController:[[XHGTableViewController alloc] init]];
    
    [drawer.mainV addSubview:control.view];
    [drawer addChildViewController:control];
    
    drawer.maxY = 100;
}


@end
