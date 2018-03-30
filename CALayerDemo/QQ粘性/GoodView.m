//  GoodView.m
//  CALayerDemo
//
//  Created by bailing on 2018/3/30.
//  Copyright © 2018年 zhufeng. All rights reserved.
//

#import "GoodView.h"
@interface GoodView()

@property (nonatomic,weak)UIView *smallCircleView;

@property (nonatomic,assign)CGFloat oriSmallRadius;

@property (nonatomic,weak) CAShapeLayer *shapreLayer;

@end

@implementation GoodView

//懒加载
-(CAShapeLayer *)shapreLayer{
    if (!_shapreLayer) {
        //暂时不规则从矩形，通过不规则矩形生成一个圆
        CAShapeLayer *layer = [CAShapeLayer layer];
        _shapreLayer = layer;
        layer.fillColor = self.backgroundColor.CGColor;
        [self.superview.layer insertSublayer:layer above:self.layer];
    }
    return _shapreLayer;
}

-(UIView *)smallCircleView{
    if (!_smallCircleView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = self.backgroundColor;
        _smallCircleView = view;
        //让小圆添加到父控件上
        [self.superview insertSubview:view atIndex:self];
    }
    return _smallCircleView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
#pragma mark --初始化
-(void)setup{
    CGFloat w = self.bounds.size.width;
    
    _oriSmallRadius = w / 2;
    
    self.layer.cornerRadius = w / 2;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    //设置小圆的位置
    self.smallCircleView.center = self.center;
    self.smallCircleView.bounds = self.bounds;
    self.smallCircleView.layer.cornerRadius = self.oriSmallRadius;
}
//pan手势的执行方法
-(void)pan:(UIPanGestureRecognizer *)pan{
    //获取手指的偏移量
    CGPoint transP = [pan translationInView:self];
    //修改center
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    
    self.center = center;
    //复位
    [pan setTranslation:CGPointZero inView:self];
    
    CGFloat d = [self ]
}
//描述两圆之前一条矩形路径
-(UIBezierPath *)pathWithBigCircleView:(UIView *)bigCircleView  smallCircleView:(UIView *)smallCirc
@end
