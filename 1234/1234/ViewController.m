//
//  ViewController.m
//  1234
//
//  Created by 王贵彬 on 16/2/19.
//  Copyright © 2016年 wangguibin. All rights reserved.
//

#import "ViewController.h"
#import "WGBCycleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //本地图片
    NSArray *images =@[@"1",@"2",@"3",@"4",@"11111"];

    //实例化这个对象
    WGBCycleView *cyc =[[WGBCycleView alloc]init];

    //调一下添加图片的方法
    [cyc addCycleViewWithImages:images type:WGBCycleViewTypeDefault];

    [self.view addSubview:cyc];

    //循环切换一张图的时间
    cyc.scrollTime=4.0f;

    //当前滚动的颜色
    cyc.curentPageTinColor=[UIColor redColor];

    //全部小圆点的颜色额
    cyc.pageTinColor=[UIColor whiteColor];


}

@end
