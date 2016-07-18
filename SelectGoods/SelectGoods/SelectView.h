//
//  SelectView.h
//  SelectGoods
//
//  Created by df on 16/7/17.
//  Copyright © 2016年 Dyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeView.h"

@protocol SelectViewDelegete <NSObject>

- (void)dismiss;

- (void)selectSize:(NSString *)sizeStr andColor:(NSString *)colorStr andBuyNumber:(NSInteger)buyNumber;

@end
@interface SelectView : UIView
/**
 *  设置颜色选择数组
 */
@property (nonatomic, strong) NSArray *colorArray;
/**
 *  设置尺寸选择数组
 */
@property (nonatomic, strong) NSArray *sizeArray;
/**
 *  自定义初始化
 *
 *  @param frame      frame
 *  @param sizeArray  尺寸数组
 *  @param colorArray 颜色数组
 */
- (instancetype)initWithFrame:(CGRect)frame andSizeArray:(NSArray *)sizeArray andColorArray:(NSArray *)colorArray;

/**
 *  顶部物品信息
 */
@property (nonatomic, strong) UIImageView *icoView;
/**
 *  价格
 */
@property (nonatomic, strong) UILabel *priceLabel;
/**
 *  库存
 */
@property (nonatomic, strong) UILabel *stockLabel;

@property (nonatomic, strong) TypeView *typeView;

@property (nonatomic, weak) id <SelectViewDelegete> delegate;

@end
