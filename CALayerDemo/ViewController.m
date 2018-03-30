//  ViewController.m
//  CALayerDemo
//  Created by bailing on 2018/3/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "ViewController.h"
#define angle2radion(angle) ((angle) / 180.0 * M_PI)
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIImageView *myimageView;
@property (nonatomic, weak) CALayer *layer;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 使用CALayer这个类去创建内容
    //[self calayerWithImageView];
    //隐式动画
    [self yinshidonghuaMethod2];
}
//隐式动画的功能
-(void)yinshidonghuaMethod2{
    //我们默认的uiview是有一个layer图层的，即为是rootlayer这个东西
    //我们自己创建的calayer是都有隐式动画的功能的
    CALayer *layer = [[CALayer alloc]init];
    layer.position = CGPointMake(200, 150);
    layer.bounds = CGRectMake(0, 0, 80, 80);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    _layer = layer;
}
//使用imageView的功能
-(void)calayerWithImageView{
    //使用CALayer这个类去创建
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    //设置图层内容
    layer.contents = (id)[UIImage imageNamed:@"1"].CGImage;
    //添加到view上面去呀
    [self.view.layer addSublayer:layer];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //图层形变
    //缩放
//    [UIView animateWithDuration:0.5 animations:^{
//        //缩放
//        //self.myView.layer.transform =  CATransform3DMakeRotation(M_PI, 1, 1, 0);
//        //self.myView.layer.transform =  CATransform3DMakeScale(0.5, 0.5, 1);
//        //快速进行图层缩放
//        [self.myView.layer setValue:@(M_PI) forKey:@"transform.rotation"];
//
//    }];
    //[self imageLayer];
// [self viewLayer];
// 调用隐式方法
    [self yinshiAnimationMethod];
}
//隐式动画
-(void)yinshiAnimationMethod{
    // 旋转
    // 1 ~ 360
    self.blueView.layer.transform = CATransform3DMakeRotation(angle2radion(arc4random_uniform(360) + 1), 0, 0, 1);
    self.blueView.layer.position = CGPointMake(arc4random_uniform(200) + 20, arc4random_uniform(400) + 50);
    
    self.blueView.layer.cornerRadius = arc4random_uniform(50);
    
    self.blueView.layer.backgroundColor = [self randomColor].CGColor;
    
    self.blueView.layer.borderWidth = arc4random_uniform(10);
    self.blueView.layer.borderColor = [self randomColor].CGColor;
}

-(void)imageLayer{
    //设置控件的主层控件
    self.myimageView.layer.cornerRadius = 50;
    //超出的边框的全部裁剪掉
    self.myimageView.layer.masksToBounds = YES;
    //设置边框
    self.myimageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.myimageView.layer.borderWidth = 1;
}

-(void)viewLayer{
    //设置阴影
    //Opactiy:不透明度
    self.myView.layer.shadowOpacity = 0.5;
    //注意:图层的颜色都是核心绘图框架，通常。CGColor
    self.myView.layer.shadowColor = [UIColor yellowColor].CGColor;
    self.myView.layer.shadowRadius = 10;
    
    //圆角半径
    self.myView.layer.cornerRadius = 50;
    //边框
    self.myView.layer.borderWidth = 1;
    self.myView.layer.borderColor = [UIColor redColor].CGColor;
}
//随机颜色
-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256)/255.0f;
    CGFloat g = arc4random_uniform(256)/255.0f;
    CGFloat b = arc4random_uniform(256)/255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
