//
//  WGBCycleView.m
//  Created by 王贵彬 on 16/02/19.
//  Copyright (c) 2016 Wangguibin. All rights reserved.
//

#import "WGBCycleView.h"
#import "UIImageView+WebCache.h"

#define Kwidth [UIScreen mainScreen].bounds.size.width

#define KCycHeight  150


@interface WGBCycleView ()


@property (nonatomic,weak) UIScrollView *scrollview;

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,assign) NSInteger imagesCount;

@end



@implementation WGBCycleView
{

    UIPageControl *_page;

}

//用代码创建
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self timer];

    }
    return self;
}

//用xib或者Sb创建
- (void)awakeFromNib
{
    [self timer];

}

//类方法快速创建
+(instancetype)cycleViewWithImages:(NSArray *)images type:(WGBCycleViewImageType)imageType;
{

    WGBCycleView *cycleView =[[WGBCycleView alloc]init];

    [cycleView addCycleViewWithImages:images type:imageType];

    return cycleView;
}


- (void)layoutSubviews
{

    [super layoutSubviews];


}

/**
 *  初始化 scrollView
 */
- (void)scrollViewInit
{

    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Kwidth, KCycHeight)];


    self.frame =scrollview.frame;
    [self addSubview:scrollview];

    self.scrollview =scrollview;

}


//设置图片
- (void)addCycleViewWithImages:(NSArray *)images type:
        (WGBCycleViewImageType)imageType;
{


    [self scrollViewInit];

    self.imagesCount =images.count;
    self.scrollview.delegate=self;
    self.scrollview.pagingEnabled=YES;
    self.scrollview.bounces=NO;
    self.scrollview.showsHorizontalScrollIndicator=NO;
    self.scrollview.contentOffset =CGPointMake(Kwidth, 0);

    //滚动区域
    self.scrollview.contentSize=CGSizeMake(Kwidth*(_imagesCount+2), KCycHeight);


//   NSLog(@"%@",images);
    //添加图片
    for (int i=0; i<_imagesCount+2; i++) {


        UIImageView *imageView ;

        if (i==0) {//第一张显示最后一张
            imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Kwidth, KCycHeight)];

            [imageView sd_setImageWithURL:[NSURL URLWithString:images[_imagesCount-1]]];
            if (imageType==WGBCycleViewTypeDefault) {

                imageView.image =[UIImage imageNamed:images[_imagesCount-1]];
            }
            [self.scrollview addSubview:imageView];

        }else if (i==images.count+1){//最后一张显示第一张

            imageView=[[UIImageView alloc]initWithFrame:CGRectMake(Kwidth*i, 0, Kwidth,KCycHeight)];

            [imageView sd_setImageWithURL:[NSURL URLWithString:images[0]]];
            if (imageType==WGBCycleViewTypeDefault) {

                imageView.image =[UIImage imageNamed:images[0]];
            }

            [self.scrollview addSubview:imageView];

        }else{

            //其它照常显示  3 1 2 3 1
            //         ---->3
            //          1<-----

            imageView=[[UIImageView alloc]initWithFrame:CGRectMake(Kwidth*i, 0, Kwidth, KCycHeight)];

            imageView.tag= i-1 ;

            imageView.userInteractionEnabled=YES;

            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)]];

            [imageView sd_setImageWithURL:[NSURL URLWithString:images[i-1]]];

            if (imageType==WGBCycleViewTypeDefault) {

                imageView.image =[UIImage imageNamed:images[i-1]];
            }

            [self.scrollview addSubview:imageView];
        }
    }

    [self setUpPageControl];
}


//手势回调
- (void)clickTap:(UITapGestureRecognizer* )tap
{
    
    self.clickTap(tap.view.tag);

}



//page
-(void)setUpPageControl
{
    _page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, KCycHeight-15, Kwidth, 10)];

    _page.numberOfPages=_imagesCount;

    _page.currentPage=0;


   UIColor *pageIndicatorTintColor = self.pageTinColor ? self.pageTinColor:[UIColor lightGrayColor];

   UIColor *currentPageIndicatorTintColor = self.curentPageTinColor ? self.curentPageTinColor : [UIColor redColor];

    _page.pageIndicatorTintColor = pageIndicatorTintColor;

    _page.currentPageIndicatorTintColor=currentPageIndicatorTintColor;

    [self addSubview:_page];

}


//定时器
-(void)timer
{    _count=0;

    CGFloat time = self.scrollTime ? self.scrollTime : 3.0;

    [[NSRunLoop mainRunLoop] addTimer:[NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(timeUpdate) userInfo:nil repeats:YES] forMode:NSRunLoopCommonModes];
}

//定时器回调
-(void)timeUpdate
{
    _count++;
    if (_count==_imagesCount
        ) {
        _count=0;
        _scrollview.contentOffset=CGPointMake(0, 0);
    }
    [_scrollview setContentOffset:CGPointMake(Kwidth*_count, 0) animated:YES];
    _page.currentPage=_count-1;
}

#pragma mark -  <ScrollViewDelegate>

//scrollview的图片偏移量

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollview)
    {
        if (scrollView.contentOffset.x/375==0) {
            scrollView.contentOffset=CGPointMake(Kwidth*_imagesCount, 0);
        }else if (scrollView.contentOffset.x/375==_imagesCount+1){

            scrollView.contentOffset=CGPointMake(Kwidth, 0);
        }

        CGFloat offsetCount = scrollView.contentOffset.x/375;

        _page.currentPage=offsetCount-1;

        _count=offsetCount;
    }

}


@end
