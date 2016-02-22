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


/**
 *  手势回调block
 */
@property (nonatomic,copy) void (^clickTap)(NSInteger index);

/**
 *  当前的点的颜色
 */
@property (nonatomic,strong) UIColor *curentPageTinColor;

/**
 *  全部点的背景色
 */
@property (nonatomic,strong) UIColor *pageTinColor;

/**
 *  滚动的间隔时间
 */
@property (nonatomic,assign) CGFloat scrollTime;


/**
 *  类方法快速创建
 *
 *  @param images    图片
 *  @param imageType 图片类型
 *
 *  @return 返回这一个滚动轮播器对象
 */
+(instancetype)cycleViewWithImages:(NSArray*)images  type:(WGBCycleViewImageType)imageType;

/**
 *  添加图片的方法
 *
 *  @param images    图片
 *  @param imageType 图片类型
 */
- (void)addCycleViewWithImages:(NSArray*)images type:(WGBCycleViewImageType)imageType;


@end
