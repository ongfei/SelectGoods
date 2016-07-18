//
//  TypeView.m
//  SelectGoods
//
//  Created by df on 16/7/17.
//  Copyright © 2016年 Dyf. All rights reserved.
//

#import "TypeView.h"
#import "UIView+DyfAdd.h"

// 屏幕宽高
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@interface TypeView ()

@property (nonatomic, strong) UIButton *stateBtn;

@end

@implementation TypeView

- (instancetype)initWithFrame:(CGRect)frame andSorceArray:(NSArray *)arr andBaseTag:(NSInteger) baseTag {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *lastBtn = nil;
        CGFloat Height = 30;
        for (int i = 0; i < arr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            
            CGFloat left = lastBtn == nil ? 0 : (lastBtn.right > (ScreenWidth - 20) ? 0 :lastBtn.right);
            
            CGFloat top = lastBtn == nil ? 5 :(lastBtn.right > (ScreenWidth - 30) ? lastBtn.bottom + 5 :lastBtn.top);
            
            btn.frame = CGRectMake(left + 10, top, [self getWidthWithfont:13 andStr:arr[i]] < 50 ? 50 : [self getWidthWithfont:13 andStr:arr[i]], 30);
            
            [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
            
            [btn setTitleColor:[UIColor blackColor] forState:0];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            
            [btn setTitle:[arr objectAtIndex:i] forState:0];
            
            btn.layer.cornerRadius = 8;
            
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            
            btn.layer.borderWidth = 0;
            
            [btn.layer setMasksToBounds:YES];
            
            [self addSubview:btn];
            
            btn.tag = baseTag + i;
            
            [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            lastBtn.right > (ScreenWidth - 30) ?  Height += 30 : Height;
            
            lastBtn = btn;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, lastBtn.bottom + 5, ScreenWidth, 1)];
        view.backgroundColor = [UIColor colorWithRed:0.7019 green:0.7019 blue:0.7019 alpha:1.0];
        [self addSubview:view];
        
        self.height = Height + 21;
        
    }
    return self;
}

- (void)touchBtn:(UIButton *)btn {
    
    if (btn.selected == NO) {
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *botton = (UIButton *)subview;
                botton.selected = NO;
                botton.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            }
        }

        btn.selected = YES;
        btn.backgroundColor = [UIColor redColor];
        
    }else {
        btn.selected = NO;
        btn.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }

    if (self.stateBtn != btn) {
            }
    if ([self.delegate respondsToSelector:@selector(selectBtnWithTag:andBtn:andStute:)]) {
        [self.delegate selectBtnWithTag:btn.tag andBtn:btn andStute:btn.selected];
    }
    self.stateBtn = btn;
//    btn.selected = !btn.selected;
}

- (CGFloat)getWidthWithfont:(CGFloat)f andStr:(NSString *)str{
    UIFont * font = [UIFont systemFontOfSize:f];
    CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    CGFloat w = size.width;
    return w;
}

@end
