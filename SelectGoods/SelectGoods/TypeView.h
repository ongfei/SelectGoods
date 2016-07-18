//
//  TypeView.h
//  SelectGoods
//
//  Created by df on 16/7/17.
//  Copyright © 2016年 Dyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeViewDelegate <NSObject>

- (void)selectBtnWithbaseType:(NSString *)baseType andBtn:(UIButton *)btn andStute:(BOOL)stute;

@end
@interface TypeView : UIView

@property (nonatomic, assign) NSString *baseType;
@property (nonatomic, weak) id<TypeViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andSorceArray:(NSArray *)arr andBaseType:(NSString *)baseType;
@end
