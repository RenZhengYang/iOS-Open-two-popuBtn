//
//  but.h
//  iOS开发范例-按钮类-实例 ② 弹出式按钮
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class but;
//  协议
@protocol butDelegate <NSObject>
/*
 * 子类按钮
 */
- (void)subButtonPress:(but *)button;
@end

@interface but : UIButton
/*
 *  代理-属性声明
 */
@property(weak,nonatomic) id <butDelegate> delegate;

@end
