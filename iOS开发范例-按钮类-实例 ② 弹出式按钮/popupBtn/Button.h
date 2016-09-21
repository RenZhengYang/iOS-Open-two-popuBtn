//
//  Button.h
//  iOS开发范例-按钮类-实例 ② 弹出式按钮
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "but.h"
//==========>  宏定义  <==========
/*
 * 1.父视图
 * 2.父视图-宽
 * 3.父视图-高
 * 4.旋转-角度
 */
#define kDCPathButtonParentView self.parentView
#define kDCPathButtonCurrentFrameWidth kDCPathButtonParentView.frame.size.width
#define kDCPathButtonCurrentFrameHeight kDCPathButtonParentView.frame.size.height

#define kDCCovertAngelToRadian(x) ((x)*M_PI)/180
//==========>  宏定义  <==========


//==========> 设置枚举 <==========
//  旋转方向
typedef enum{
    kDCPathButtonRotationNormal = 0,    //  正常
    kDCPathButtonRotationReverse,        //  翻转(反转)
}DCPathButtonRotationOrientation;
//==========> 设置枚举 <==========


//==========> 设置协议 <==========
@protocol ButtonDelegate <NSObject>
@optional
//  单击按钮的动作
- (void)button_0_action;
- (void)button_1_action;
- (void)button_2_action;
- (void)button_3_action;
- (void)button_4_action;
- (void)button_5_action;
@end
//==========> 设置协议 <==========
@interface Button : UIView<butDelegate>{
    CGPoint kDCPathButtonSubButtonBirthLocation;                  // 子类按钮开始位置
    CGPoint kDCPathButtonSubButtonTag_0_AppearLocation;  // 子类按钮 0 出现位置
    CGPoint kDCPathButtonSubButtonTag_1_AppearLocation;  // 子类按钮 1 出现位置
    CGPoint kDCPathButtonSubButtonTag_2_AppearLocation;  // 子类按钮 2 出现位置
    CGPoint kDCPathButtonSubButtonTag_3_AppearLocation;  // 子类按钮 3 出现位置
    CGPoint kDCPathButtonSubButtonTag_4_AppearLocation;  // 子类按钮 4 出现位置
    CGPoint kDCPathButtonSubButtonTag_5_AppearLocation;  // 子类按钮 5 出现位置
    CGPoint kDCPathButtonSubButtonFinalLocation;                  // 子类按钮结束位置
    }

/*
 *     @pragma 设置方法
 *     SubButtons    子类按钮数量
 *     totalRadius     总半径
 *     centerRadius  中心半径
 *     subRadius      子类半径
 *     centerImage   中心按钮 - 图片         centerBackground        中心按钮 - 背景图片
 *     subImages      子类按钮 - 图片        subImageBackground   子类按钮 - 背景图片
 *     inLocationX      X 轴
 *     locationY          Y 轴
 *     toParentView    父类视图
 */
- (id)initDCPathButtonWithSubButtons:(NSInteger)buttonCount
                         totalRadius:(CGFloat)totalRadius
                        centerRadius:(NSInteger)centerRadius
                           subRadius:(CGFloat)subRadius
                         centerImage:(NSString *)centerImageName
                    centerBackground:(NSString *)centerBackgroundName
                           subImages:(void(^)(Button *))imageBlock
                  subImageBackground:(NSString *)subImageBackgroundName
                         inLocationX:(CGFloat)xAxis
                           locationY:(CGFloat)yAxis
                        toParentView:(UIView *)parentView;

//  代理属性-声明
@property(weak,nonatomic) id <ButtonDelegate> delegate;
//   是否展开
@property (nonatomic, getter = isExpanded) BOOL expanded;

@property (nonatomic) CGFloat totalRaiuds;
@property (nonatomic) CGFloat centerRadius;
@property (nonatomic) CGFloat subRadius;
@property (nonatomic) NSInteger buttonCount;
@property (nonatomic) CGFloat centerLocationAxisX;
@property (nonatomic) CGFloat centerLocationAxisY;
@property (nonatomic, strong) UIView *parentView;

@property (strong, nonatomic) UIButton *centerButton;
@property (strong, nonatomic) but *subButton;
@property (strong, nonatomic) NSMutableArray *buttons;

/*
 *设置子类图片  和  tag
 */
- (void)subButtonImage:(NSString *)imageName withTag:(NSInteger)tag;
@end
