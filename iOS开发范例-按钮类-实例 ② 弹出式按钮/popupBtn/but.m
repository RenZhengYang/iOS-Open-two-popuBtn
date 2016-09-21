//
//  but.m
//  iOS开发范例-按钮类-实例 ② 弹出式按钮
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "but.h"

@implementation but

/*
 * 初始化
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
           // Initialization code
    }
    return self;
}

/*
 * 当触摸按钮时，开启高亮状态，
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
}
/*
 * 当触摸按钮结束时，响应代理方法，关闭高亮状态
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if ([_delegate respondsToSelector:@selector(subButtonPress:)]) {
        [_delegate subButtonPress:self];
      }
     self.highlighted = NO;
}
@end
