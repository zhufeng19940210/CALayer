//  CoreAnimationController.m
//  CALayerDemo
//
//  Created by bailing on 2018/3/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "CoreAnimationController.h"
static int i = 2;
@interface CoreAnimationController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIImageView *heatImageView;
@property (weak, nonatomic) IBOutlet UIImageView *transionImageView;
@end
@implementation CoreAnimationController
- (void)viewDidLoad {
    [super viewDidLoad];
    //动画的实现的步骤
    //1.获取layer的对象
    //2.初始化一个annimation对象，设置一些动画属性
    //3.使用layer添加一个动画
    //4.使用remove的方法
}
//点击屏幕创建的方法
//CABaicAnimation
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //使用帧动画
    //[self CAKeyframeAnimationMethod];
    //使用转场的动画
    //[self CATransitionMethod];
    //动画组
    //[self CATGroupMethod];
    //uiview
    [self DiffrentWithUIViewMethod];
}
//CABasicAnimation的方法
-(void)CABaicAnimationMethod{
    //基本的动画使用
    //创建动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    //修改下面的属性产生的动画
    //anim.keyPath = @"position";
    anim.keyPath = @"transform.scale";
    //设置值
    anim.toValue = @0.5;
    //设置动画执行的次数
    anim.repeatCount = MAXFLOAT;
    //取消动画反弹
    //设置动画完成的时候不要移除动画
    anim.removedOnCompletion =  NO;
    //设置动画执行完成要保持最新的效果
    anim.fillMode = kCAFillModeForwards;
    [self.heatImageView.layer addAnimation:anim forKey:nil];
}
//CAKeyframeAnimation的方法
-(void)CAKeyframeAnimationMethod{
    //帧动画的实现
    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animation];
    //设置路径
    keyAnim.keyPath = @"transform.scale";
    //设置持续的时间
    keyAnim.duration = 1;
    //设置持续的次数
    keyAnim.repeatCount = MAXFLOAT;
    [self.heatImageView.layer addAnimation:keyAnim forKey:nil];
}
//转成动画了
-(void)CATransitionMethod{
    //转成动画
    // 转场代码
    if (i == 4) {
        i = 1;
    }
    // 加载图片名称
    NSString *imageN = [NSString stringWithFormat:@"%d",i];
    self.transionImageView.image = [UIImage imageNamed:imageN];
    i++;
    // 转场动画
    CATransition *anim = [CATransition animation];
    anim.type = @"pageCurl";
    anim.duration = 2;
    [self.transionImageView.layer addAnimation:anim forKey:nil];
}
//动画组的使用
-(void)CATGroupMethod{
    //创建一个动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //缩放
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @0.5;
    //旋转
    CABasicAnimation *rotation = [CABasicAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.toValue = @(arc4random_uniform(M_PI));
    //平移
    CABasicAnimation *position = [CABasicAnimation animation];
    position.keyPath = @"position";
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(200), arc4random_uniform(200))];
    
    group.animations = @[scale,rotation,position];
    
    [self.myView.layer addAnimation:group forKey:nil];
}
//UIView和核心动画的区别
-(void)DiffrentWithUIViewMethod{
    NSLog(@"uiview和核心动画的区别");
    //创建一个动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    //设置路径
    anim.keyPath = @"position";
    //设置返回的位置了
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 400)];
    // 注意：取消反弹代码必须放在图层添加动画之前。
    anim.removedOnCompletion = NO;
    //填充的方式了fillmode
    anim.fillMode =  kCAFillModeForwards;
    //设置代理方法
    anim.delegate = self;
    //添加到图层上面
    [self.myView.layer addAnimation:anim forKey:nil];
}
// 动画完成的时候调用
#pragma mark -- CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画开始了");
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"%@", NSStringFromCGPoint(self.myView.layer.position));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end



