//
//  ViewController.m
//  20160328001-Queartz2D-ClipImage
//
//  Created by Rainer on 16/3/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Utils.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 这里使用自己封装的工具类裁剪圆形图片
    self.imageView.image = [UIImage imageWithName:@"阿狸头像" border:2.0 borderColor:[UIColor greenColor]];
}

/**
 *  画一个带圆环的图片
 */
- (void)clipCircleImage {
    // 1.加载一张原始图片
    UIImage *oldImage = [UIImage imageNamed:@"阿狸头像"];
    
    // 2.创建一个大于原始图片的外圆上下文
    // 圆环直径
    CGFloat circleBorder = 1;
    
    // 获取最合理的大圆的长度和宽度
    CGFloat oldImageWH = oldImage.size.height > oldImage.size.width ? oldImage.size.width : oldImage.size.height;
    
    CGFloat bigCircleWH = oldImageWH + circleBorder * 2;
    
    // 开启一个大圆的上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(bigCircleWH, bigCircleWH), NO, 0.0);
    
    // 3.绘制一个大圆作为背景
    UIBezierPath *bigCircleBezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, bigCircleWH, bigCircleWH)];
    
    [[UIColor redColor] set];
    
    [bigCircleBezierPath fill];
    
    // 4.设置上下文的裁剪区域，正切与原始图片大小，但需要把圆环作为原点
    UIBezierPath *clipBezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(circleBorder, circleBorder, oldImageWH, oldImageWH)];
    
    [clipBezierPath addClip];
    
    // 5.绘制图片
    [oldImage drawAtPoint:CGPointMake(circleBorder, circleBorder)];
    
    // 6.从上下文中生成一张新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7.关闭上下文
    UIGraphicsEndImageContext();
    
    // 显示裁剪后的图片
    self.imageView.image = newImage;
}

/**
 *  画一个圆形图片
 */
- (void)clipImage {
    // 1.加载一张原始图片
    UIImage *oldImage = [UIImage imageNamed:@"阿狸头像"];
    
    // 2.创建一个和原始图片同等大小的上下文
    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
    
    // 3.设置上下文原型裁剪区域，该圆形区域正切与上下文
    // 3.1.创建一个裁剪区域路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, oldImage.size.width, oldImage.size.height)];
    
    // 3.2.裁剪上下文路径设为裁剪区域
    [bezierPath addClip];
    
    // 4.绘制图片
    [oldImage drawAtPoint:CGPointZero];
    
    // 5.从上下文中生成一张新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    // 显示裁剪后的图片
    self.imageView.image = newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
