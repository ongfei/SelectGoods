//
//  SelectView.m
//  SelectGoods
//
//  Created by df on 16/7/17.
//  Copyright © 2016年 Dyf. All rights reserved.
//

#import "SelectView.h"
#import "UIView+DyfAdd.h"
#import "TypeView.h"


// 屏幕宽高
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)


@interface SelectView ()<TypeViewDelegate>

@property (nonatomic, strong) NSArray *sizeArr;

@property (nonatomic, strong) NSArray *colorArr;
/**
 *  选择的sizi color
 */
@property (nonatomic, strong) UILabel *selectLabel;
/**
 *  购买数量
 */
@property (nonatomic, strong) UILabel *buyNumber;
/**
 *  保存选择的尺寸
 */
@property (nonatomic, strong) NSString *sizeStr;
/**
 *  保存选择的颜色
 */
@property (nonatomic, strong) NSString *colorStr;

@end

@implementation SelectView

- (instancetype)initWithFrame:(CGRect)frame andSizeArray:(NSArray *)sizeArray andColorArray:(NSArray *)colorArray {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.sizeArr = [sizeArray copy];
        
        self.colorArr = [colorArray copy];
        
        [self prepareLayout];
    }
    
    return self;
}

- (void) prepareLayout {
    
    self.sizeStr = @"";
    self.colorStr = @"";
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    
    [self addSubview:alphaView];
    
    alphaView.backgroundColor = [UIColor blackColor];
    
    alphaView.alpha = 0.6;
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight/4, ScreenWidth, ScreenHeight/4*3)];
    
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:bgView];
    
    
    UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    
    headBgView.backgroundColor = [UIColor whiteColor];
    
    [bgView addSubview:headBgView];
    
    [self addLineWithUI:headBgView andFrame:CGRectMake(0, headBgView.bottom - 1, headBgView.width, 1) andColor:[UIColor colorWithRed:0.7019 green:0.7019 blue:0.7019 alpha:1.0]];

    
    self.icoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 100, 100)];
    
    [headBgView addSubview:self.icoView];
    
    self.icoView.layer.borderWidth = 3;
    
    self.icoView.layer.borderColor = [[UIColor colorWithRed:0.9621 green:0.9621 blue:0.9621 alpha:1.0] CGColor];
    
    self.icoView.backgroundColor = [UIColor orangeColor];
    

    self.priceLabel = [self customLabelWithFrame:CGRectMake(self.icoView.right + 10, 10, ScreenWidth - self.icoView.right - 60, 25) andText:@"价格:::::::" andFont:14 andTextClolor:[UIColor redColor]];
    
    [headBgView addSubview:self.priceLabel];

    self.stockLabel = [self customLabelWithFrame:CGRectMake(self.priceLabel.left, self.priceLabel.bottom, self.priceLabel.width, self.priceLabel.height) andText:@"库存量::::::" andFont:14 andTextClolor:[UIColor blackColor]];
    
    [headBgView addSubview:self.stockLabel];
    
    self.selectLabel = [self customLabelWithFrame:CGRectMake(self.priceLabel.left, self.stockLabel.bottom, self.priceLabel.width, self.priceLabel.height) andText:@"选择了::::" andFont:14 andTextClolor:[UIColor blackColor]];
    
    [headBgView addSubview:self.selectLabel];
    
    
    UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [headBgView addSubview:closeBtn];
    
    closeBtn.frame = CGRectMake(ScreenWidth - 50, 10, 40, 40);
    
    [closeBtn setImage:[UIImage imageNamed:@"close@3x"] forState:(UIControlStateNormal)];
    
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, headBgView.bottom, ScreenWidth, bgView.height - headBgView.height - 55)];
    
    scrollView.backgroundColor = [UIColor whiteColor];
    
    [bgView addSubview:scrollView];
    
    UILabel *sizeLabel = [self customLabelWithFrame:CGRectMake(10, 0, ScreenWidth, 20) andText:@"尺码" andFont:15 andTextClolor:[UIColor blackColor]];
    
    [scrollView addSubview:sizeLabel];
    
    TypeView *sizeType = [[TypeView alloc] initWithFrame:CGRectMake(10, sizeLabel.bottom, ScreenWidth - 20, 50) andSorceArray:self.sizeArr andBaseTag:1000];
    
    sizeType.delegate = self;
    
    [scrollView addSubview:sizeType];
    
    UILabel *colorLabel = [self customLabelWithFrame:CGRectMake(10, sizeType.bottom, ScreenWidth, 20) andText:@"颜色分类" andFont:15 andTextClolor:[UIColor blackColor]];
    
    [scrollView addSubview:colorLabel];
    
    TypeView *colorType = [[TypeView alloc] initWithFrame:CGRectMake(10, colorLabel.bottom, ScreenWidth - 20, 50) andSorceArray:self.colorArr andBaseTag:2000];
    
    colorType.delegate = self;
    
    [scrollView addSubview:colorType];
    
    UIView *buyNumberBg = [[UIView alloc] initWithFrame:CGRectMake(0, colorType.bottom + 5, ScreenWidth, 50)];
    
    [scrollView addSubview:buyNumberBg];
    
    UILabel *buyLabel = [self customLabelWithFrame:CGRectMake(10, 10, ScreenWidth, 30) andText:@"购买数量" andFont:15 andTextClolor:[UIColor blackColor]];
    
    [buyNumberBg addSubview:buyLabel];
    
    
//    加按钮
    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    addBtn.frame = CGRectMake(ScreenWidth - 50, buyLabel.top, 30, 30);
    
    addBtn.backgroundColor = [UIColor lightGrayColor];
    
    [addBtn setTitle:@"加" forState:(UIControlStateNormal)];
    
    addBtn.tag = 3000;
    
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [buyNumberBg addSubview:addBtn];
    
    
    self.buyNumber = [self customLabelWithFrame:CGRectMake(addBtn.left - 60, buyLabel.top, 50, 30) andText:@"1" andFont:14 andTextClolor:[UIColor blackColor]];
    
    self.buyNumber.backgroundColor = [UIColor darkGrayColor];
    
    self.buyNumber.textAlignment = NSTextAlignmentCenter;
    
    [buyNumberBg addSubview:self.buyNumber];
    
//减按钮
    
    UIButton *subtract = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    subtract.frame = CGRectMake(self.buyNumber.left - 40, buyLabel.top, 30, 30);
    
    subtract.backgroundColor = [UIColor lightGrayColor];
    
    [subtract setTitle:@"减" forState:(UIControlStateNormal)];
    
    subtract.tag = 3001;
    
    [subtract addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [buyNumberBg addSubview:subtract];
    
    
    
    scrollView.contentSize = CGSizeMake(ScreenWidth, 95 + sizeType.height + colorType.height);
    
    
    
    
    UIView *bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollView.bottom, ScreenWidth, 55)];
    
    [bgView addSubview:bottomBgView];
    
    [self addLineWithUI:bottomBgView andFrame:CGRectMake(0, 0, ScreenWidth, 1) andColor:[UIColor colorWithRed:0.7019 green:0.7019 blue:0.7019 alpha:1.0]];
    
    UIButton *addBuyCar = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    addBuyCar.frame = CGRectMake(0, 5, ScreenWidth/2 - 1, 50);
    
    addBuyCar.backgroundColor = [UIColor orangeColor];
    
    [addBuyCar setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    
    addBuyCar.tag = 3002;
    
    [addBuyCar addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [bottomBgView addSubview:addBuyCar];
    
    
    UIButton *buyNow = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    buyNow.frame = CGRectMake(addBuyCar.right + 2, 5, ScreenWidth/2 - 1, 50);
    
    buyNow.backgroundColor = [UIColor orangeColor];
    
    [buyNow setTitle:@"立即购买" forState:(UIControlStateNormal)];
    
    buyNow.tag = 3003;
    
    [buyNow addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];

    [bottomBgView addSubview:buyNow];


}

- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
            //加按钮
        case 3000: {
            
            NSInteger number = [self.buyNumber.text integerValue];
            
            self.buyNumber.text = [NSString stringWithFormat:@"%ld", ++number];
            
        }
            break;
            //减按钮
        case 3001: {
            
            NSInteger number = [self.buyNumber.text integerValue];
            if (number - 1 <= 0) {
                
                NSLog(@"增加提示 最少为 1");
                
                self.buyNumber.text = @"1";
                
            }else {
                
                self.buyNumber.text = [NSString stringWithFormat:@"%ld", --number];
            }
            
        }
            break;
            //加入购物车按钮
        case 3002: {
            if ([self.delegate respondsToSelector:@selector(selectSize:andColor:andBuyNumber:)]) {
                
                if ([self.sizeStr isEqualToString:@""] || [self.colorStr isEqualToString:@""]) {
                    
                    NSLog(@"增加提示 尺寸 颜色 未选");
                }else
            
                [self.delegate selectSize:self.sizeStr andColor:self.colorStr andBuyNumber:[self.buyNumber.text integerValue]];
            }
        }
            break;
            //立即购买按钮
        case 3003: {
            if ([self.delegate respondsToSelector:@selector(selectSize:andColor:andBuyNumber:)]) {
                
                if ([self.sizeStr isEqualToString:@""] || [self.colorStr isEqualToString:@""]) {
                    
                    NSLog(@"增加提示 尺寸 颜色 未选");
                }else
                    
                [self.delegate selectSize:self.sizeStr andColor:self.colorStr andBuyNumber:[self.buyNumber.text integerValue]];
            }

        }
            
            break;
        default:
            break;
    }
}

- (void)closeBtnClick {
    if ([self.delegate respondsToSelector:@selector(dismiss)]) {
        [self.delegate dismiss];
    }
    
}

- (void)selectBtnWithTag:(NSInteger)tag andBtn:(UIButton *)btn andStute:(BOOL)stute {
    if (stute == YES) {//选中状态
        
        NSLog(@"%ld %ld %@",btn.tag,tag,btn.titleLabel.text);
        if (tag < 2000) {
            self.sizeStr = [btn currentTitle];
        }else {
            self.colorStr = [btn currentTitle];
        }
        
    }else {
        if (tag < 2000) {
            self.sizeStr = @"";
        }else {
            self.colorStr = @"";
        }
    }
    self.selectLabel.text = [NSString stringWithFormat:@"您选择了: %@  %@",self.sizeStr,self.colorStr];
    
//  若有需要  在这里更改库存量 -> 根据size 和color 查询对应的数据
//    self.stockLabel.text =
//    若价格有浮动也应该在这里更改
//    self.priceLabel.text =
//    若图片更换
//    self.icoView.image = 
    
}

- (UILabel  *)customLabelWithFrame:(CGRect)frame andText:(NSString *)text andFont:(NSInteger)font andTextClolor:(UIColor *)color {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.font = [UIFont systemFontOfSize:font];
    
    label.text = text;
    
    label.textColor = color;
    
    return label;
    
}

- (void)addLineWithUI:(UIView *)UIv andFrame:(CGRect)frame andColor:(UIColor *)color {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    view.frame = frame;
    [UIv addSubview:view];
}

@end
