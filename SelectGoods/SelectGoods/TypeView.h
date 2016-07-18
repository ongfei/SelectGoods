//
//  TypeView.h
//  SelectGoods
//
//  Created by SINOKJ on 16/7/17.
//  Copyright © 2016年 Dyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeViewDelegate <NSObject>

- (void)selectBtnWithTag:(NSInteger)tag andBtn:(UIButton *)btn andStute:(BOOL)stute;

@end
@interface TypeView : UIView

@property (nonatomic, weak) id<TypeViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andSorceArray:(NSArray *)arr andBaseTag:(NSInteger) baseTag;
@end
