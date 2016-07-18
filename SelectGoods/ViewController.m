//
//  ViewController.m
//  SelectGoods
//
//  Created by df on 16/7/17.
//  Copyright © 2016年 Dyf. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"

@interface ViewController ()<SelectViewDelegete>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) SelectView *selectView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
   
    _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(100, 100, 100, 30);
    [btn setTitle:@"点击" forState:(UIControlStateNormal)];
    [_bgView addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];

}

- (void)click {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@[@"L",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M"] forKey:@"尺寸"];
    [dic setValue:@[@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色"] forKey:@"颜色"];
    [dic setValue:@[@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色"] forKey:@"色"];
    
    [UIView animateWithDuration: 0.35 animations: ^{
        
        
        _bgView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        _bgView.center = CGPointMake(self.view.center.x, self.view.center.y-50);
        _selectView = [[SelectView alloc] initWithFrame:self.view.frame andSourceDic:dic];
        
        _selectView.icoView.image = [UIImage imageNamed:@"close@3x"];
        
        _selectView.center = self.view.center;
        _selectView.delegate = self;
        [self.view addSubview:_selectView];
    } completion: nil];
    
}


- (void)selectWithDic:(NSDictionary *)dic andBuyNumber:(NSInteger)buyNumber {
    NSLog(@"选择 --> %@,, 购买的数量 --> %ld",dic, buyNumber);
    [self dismiss];
}

- (void)dismiss {
//    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        _selectView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        _bgView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        _bgView.center = self.view.center;
    } completion:^(BOOL finished) {
        [_selectView removeFromSuperview];
        _selectView = nil;
    }];
}
@end
