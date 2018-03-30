//  ZFDaoyinViewController.m
//  CALayerDemo
//  Created by bailing on 2018/3/29.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "ZFDaoyinViewController.h"
@interface ZFDaoyinViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;
@end
@implementation ZFDaoyinViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //复制图层的layer类
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.myView.layer;
    layer.instanceCount = 2;
    //开始使用动画来执行
    CATransform3D  transform = CATransform3DMakeTranslation(0, self.myView.bounds.size.height, 0);
    //绕着x轴旋转
    transform  =  CATransform3DRotate(transform, M_PI, 1, 0, 0);
    // 往下面平移控件的高度
    layer.instanceTransform = transform;
    layer.instanceAlphaOffset = -0.1;
    layer.instanceBlueOffset = -0.1;
    layer.instanceGreenOffset = -0.1;
    layer.instanceRedOffset = -0.1;
}
@end
