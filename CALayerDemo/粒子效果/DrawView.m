//  DrawView.m
//  CALayerDemo
//  Created by bailing on 2018/3/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "DrawView.h"

static int _instansCount = 0;

@interface DrawView()

@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic,weak)CALayer *dotLayer;

@property (nonatomic,weak)CAReplicatorLayer *repLayer;

@end

@implementation DrawView

//懒加载点层
-(CALayer *)dotLayer{
    if (!_dotLayer) {
        //创建图层
        CALayer *layer = [CALayer layer];
        
        CGFloat wh = 10;
        
        layer.frame = CGRectMake(0, -1000, wh, wh);
        
        layer.cornerRadius = wh / 2;
        
        layer.backgroundColor = [UIColor blueColor].CGColor;
        
        [_repLayer addSublayer:layer];
        
        _dotLayer = layer;
    }
    return _dotLayer;
}

-(UIBezierPath *)path{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}
#pragma mark  -- 开始点击调用
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //获取当前的touch对象
    UITouch *touch = [touches anyObject];
    //获取当前的触摸点
    CGPoint curP = [touch locationInView:self];
    //设置起点
    [self.path moveToPoint:curP];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    //获取触摸的对象
    UITouch *touch = [touches anyObject];
    //获取当前的触摸点
    CGPoint curP = [touch locationInView:self];
    //添加线到某个点
    [_path addLineToPoint:curP];
    //重绘
    [self setNeedsDisplay];
    //动态的++
    _instansCount++;
}

-(void)drawRect:(CGRect)rect{

    [_path stroke];
}
#pragma mark -- 开始动画了
-(void)startAnim{
    //创建帧动画了
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    //设置路径
    anim.path = _path.CGPath;
    //持续的时间
    anim.duration = 3;
    //重复的次数
    anim.repeatCount = MAXFLOAT;
    
    [self.dotLayer addAnimation:anim forKey:nil];
    
    // 注意:如果复制的子层有动画，先添加动画，在复制
    // 复制子层
    _repLayer.instanceCount = _instansCount;
    //延迟图层动画
    _repLayer.instanceDelay = 0.3;
}
//加载完xib调用，创建复制层
-(void)awakeFromNib{
    //创建复制层
    CAReplicatorLayer *repL = [CAReplicatorLayer layer];
    //设置frame
    repL.frame  = self.bounds;
    
    [self.layer addSublayer:repL];
    
    _repLayer = repL;
}
//重绘
-(void)reDraw{
    //清空绘图信息
    _path = nil;
    [self setNeedsDisplay];
    //把图层移除父控件，复制层也会别移除
    [_dotLayer removeFromSuperlayer];
    _dotLayer = nil;
    //清空子层总数
    _instansCount = 0;
}
@end
