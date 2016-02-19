//
//  WGBCycleView.h
//
//  广告轮播图 支持网络图片和本地图片
//  依赖库SDWebImage
//  Created by 王贵彬 on 16/02/19.
//  Copyright (c) 2016 Wangguibin. All rights reserved.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WGBCycleViewImageType){

    WGBCycleViewTypeDefault = 1,//本地图片
    WGBCycleViewTypeIsNet,//网络图片
};

@interface WGBCycleView : UIView<UIScrollViewDelegate>



@property (nonatomic,strong) UIColor *curentPageTinColor;//当前的点的颜色
@property (nonatomic,strong) UIColor *pageTinColor;//全部点的背景色
@property (nonatomic,assign) CGFloat scrollTime;//滚动的间隔时间


+(instancetype)cycleViewWithImages:(NSArray*)images  type:(WGBCycleViewImageType)imageType;

- (void)addCycleViewWithImages:(NSArray*)images type:(WGBCycleViewImageType)imageType;


@end
