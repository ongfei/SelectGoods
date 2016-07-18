# SelectGoods
![Effect pic](selectGoods.png)
##使用
   NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@[@"L",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M",@"l",@"M"] forKey:@"尺寸"];
    [dic setValue:@[@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色"] forKey:@"颜色"];
    [dic setValue:@[@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色",@"红色",@"蓝色",@"黑色"] forKey:@"色"];
    
    有几个类别就有几个key对应
    
   _selectView = [[SelectView alloc] initWithFrame:self.view.frame andSourceDic:dic];
        有几个属性暴露在外可以设置
   _selectView.icoView.image = [UIImage imageNamed:@"close@3x"];
        
   _selectView.center = self.view.center;
   _selectView.delegate = self;
  [self.view addSubview:_selectView];
  
  遵守的两个代理
  - (void)selectWithDic:(NSDictionary *)dic andBuyNumber:(NSInteger)buyNumber {
    NSLog(@"选择 --> %@,, 购买的数量 --> %ld",dic, buyNumber);
    [self dismiss];
}

- (void)dismiss {

    [_selectView removeFromSuperview];
    _selectView = nil;
}

注意看注释和打印的提示!!!
