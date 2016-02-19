//
//  ViewController.m
//  1234
//
//  Created by qianfeng on 16/2/19.
//  Copyright © 2016年 wangguibin. All rights reserved.
//

#import "ViewController.h"
#import "WGBCycleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *images =@[@"1",@"2",@"3",@"4",@"11111"];

    WGBCycleView *cyc =[[WGBCycleView alloc]init];

    [cyc addCycleViewWithImages:images type:1];
    [self.view addSubview:cyc];

}

@end
