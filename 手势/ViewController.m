//
//  ViewController.m
//  手势
//
//  Created by 张伟伟 on 2018/1/18.
//  Copyright © 2018年 张伟伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIPinchGestureRecognizer *pinch;
@property (nonatomic,strong) UIRotationGestureRecognizer *rotation;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

-(UIPinchGestureRecognizer *)pinch {
    if (!_pinch) {
        _pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
        _pinch.delegate = self;
    }
    return _pinch;
}

-(UIRotationGestureRecognizer *)rotation {
    if (!_rotation) {
        _rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
        _rotation.delegate = self;
    }
    return _rotation;
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 400, 300)];
        _imageView.image = [UIImage imageNamed:@"1.jpeg"];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:self.pinch];
        [_imageView addGestureRecognizer:self.rotation];
    }
    return _imageView;
}

-(void)pinchAction:(UIPinchGestureRecognizer *)pinch {
    //获取手势的当前视图
    UIImageView *imageView = (UIImageView *)pinch.view;
    //缩放视图
    imageView.transform = CGAffineTransformScale(imageView.transform, pinch.scale, pinch.scale);
    //将缩放值归为单位值
    pinch.scale = 1;
}

-(void)rotationAction:(UIRotationGestureRecognizer *)rotation {
    //获取手势的当前视图
    UIImageView *imageView = (UIImageView *)rotation.view;
    //旋转视图
    imageView.transform = CGAffineTransformRotate(imageView.transform, rotation.rotation);
    //将旋转量归为单位值
    rotation.rotation = 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];
//    [self.view addSubview:self.imageView];
//    [self loadImage];
}

-(void)addImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    imageView.image = [UIImage imageNamed:@"1.jpeg"];
    //用户交互的属性一定要设置为YES
    imageView.userInteractionEnabled = YES;
    
    //创建一个平移的手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:imageView:)];
    [imageView addGestureRecognizer:pan];
    
    //创建一个滑动手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addSubview:imageView];
}

-(void)swipeAction {
    
}

-(void)panGes:(UIPanGestureRecognizer *)pan imageView:(UIImageView *)img {
    CGPoint pt = [pan translationInView:img];
    NSLog(@"x = %.2f  y = %.2f ",pt.x,pt.y);
}

-(void)loadImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    imageView.image = [UIImage imageNamed:@"1.jpeg"];
    //用户交互的属性一定要设置为YES
    imageView.userInteractionEnabled = YES;
    
    //捏合手势
    UIPinchGestureRecognizer *pinchGes= [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    //旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    
    //如果需要视图满足两种或多种手势可以一起响应，需要添加协议
    pinchGes.delegate = self;
    rotation.delegate = self;
    
    [imageView addGestureRecognizer:pinchGes];
    [imageView addGestureRecognizer:rotation];
    
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
