//
//  Button.m
//  iOS开发范例-按钮类-实例 ② 弹出式按钮
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Button.h"

@implementation Button
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

static CGFloat const kDCPathButtonLeftOffSetX = -20.0f;
static CGFloat const kDCPathButtonRightOffSetX = 20.0f;
static CGFloat const kDCPathButtonVerticalOffSetX = 20.0f;

static CGFloat const kDCPathButtonAngel36C = 36.0f;
static CGFloat const kDCPathButtonAngel45C = 45.0f;
static CGFloat const kDCPathButtonAngel60C = 60.0f;
static CGFloat const kDCPathButtonAngel72C = 72.0f;
static CGFloat const kDCPathButtonDefaultCenterRadius = 15.0f;
static CGFloat const kDCPathButtonDefaultSubRadius = 20.0f;
static CGFloat const kDCPathButtonDefaultTotalRadius = 60.0f;
static CGFloat const kDCPathButtonDefaultRotation = M_PI*2;
static CGFloat const kDCPathButtonDefaultReverseRotation = -M_PI*2;

- (id)initDCPathButtonWithSubButtons:(NSInteger)buttonCount totalRadius:(CGFloat)totalRadius centerRadius:(NSInteger)centerRadius subRadius:(CGFloat)subRadius centerImage:(NSString *)centerImageName centerBackground:(NSString *)centerBackgroundName subImages:(void (^)(Button *))imageBlock subImageBackground:(NSString *)subImageBackgroundName inLocationX:(CGFloat)xAxis locationY:(CGFloat)yAxis toParentView:(UIView *)parentView{
    
    parentView == nil?(self.parentView = parentView):(self.parentView = parentView);
    xAxis == 0? (self.centerLocationAxisX = kDCPathButtonCurrentFrameWidth/2) : (self.centerLocationAxisX = xAxis);   //  判断xAxis是否为0
    yAxis == 0? (self.centerLocationAxisY = kDCPathButtonCurrentFrameHeight/2) : (self.centerLocationAxisY = yAxis);   //  判断yAxis是否为0
    self.buttonCount = buttonCount;   //按钮个数
    self.totalRaiuds = totalRadius;
    self.subRadius = subRadius;
    _expanded = NO;                          //  展开设置为NO
    kDCPathButtonSubButtonBirthLocation = CGPointMake(-kDCPathButtonCurrentFrameWidth/2, -kDCPathButtonCurrentFrameHeight/2);
    kDCPathButtonSubButtonFinalLocation = CGPointMake(self.centerLocationAxisX, self.centerLocationAxisY);

    if (self = [super initWithFrame:self.parentView.bounds]) {
        [self configureCenterButton:centerRadius image:centerImageName backgroundImage:centerBackgroundName];         //  配置中心按钮
        [self configureTheButtons:buttonCount];
        imageBlock(self);
        [self.parentView addSubview:self];   //  添加视图
    }
    return self;
}

#pragma mark - configure the center button and the sub button
/*
 * 配置中心按钮 ->大小、图片
 */
- (void)configureCenterButton:(CGFloat)centerRadius image:(NSString *)imageName backgroundImage:(NSString *)backgroundImageName{

    self.centerButton = [[UIButton alloc]init];
    self.centerButton.frame = (CGRect){0, 0, centerRadius * 2, centerRadius * 2};   //  中心按钮框架
    self.centerButton.center = CGPointMake(self.centerLocationAxisX, self.centerLocationAxisY);  //  中心按钮中心点
    //  判断imageName是否为空
    if (imageName == nil) {  //  如果空
        imageName = @"dc-center";
    }
    //  判断imageName是否为空
    if (backgroundImageName == nil) {//  如果空
        backgroundImageName = @"dc-background";
    }
    //  设置按钮图像
    [self.centerButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //  设置按钮背景图像
    [self.centerButton setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    //  设置按钮动作
    [self.centerButton addTarget:self action:@selector(centerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.centerButton.layer.zPosition = 1;
    [self addSubview:self.centerButton];
}

- (void)centerButtonPress{
    //   判断按钮是否展开
    if (![self isExpanded]) {
                                             //  如果没有展开，将按钮展开
        [self button:[self.buttons objectAtIndex:0] appearAt:kDCPathButtonSubButtonTag_0_AppearLocation withDalay:0.5 duration:0.35];     //  展开索引为0的按钮
        [self button:[self.buttons objectAtIndex:1] appearAt:kDCPathButtonSubButtonTag_1_AppearLocation withDalay:0.55 duration:0.4];    //  展开索引为1的按钮
        [self button:[self.buttons objectAtIndex:2] appearAt:kDCPathButtonSubButtonTag_2_AppearLocation withDalay:0.6 duration:0.45];    //  展开索引为2的按钮
        
        self.expanded = YES;                   //   将expanded设置为yes
        }else{
        //  如果展开了按钮，将按钮关闭
        [self button:[self.buttons objectAtIndex:0]
            shrinkAt:kDCPathButtonSubButtonTag_0_AppearLocation
         offsetAxisX:kDCPathButtonLeftOffSetX
         offSEtAxisY:[self offsetAxisY:kDCPathButtonLeftOffSetX withAngel:kDCPathButtonAngel60C]
           withDelay:0.4
     rotateDirection:kDCPathButtonRotationNormal animationDuration:1];
        //  关闭索引为0的按钮
        [self button:[self.buttons objectAtIndex:1]
            shrinkAt:kDCPathButtonSubButtonTag_1_AppearLocation
         offsetAxisX:kDCPathButtonRightOffSetX
         offSEtAxisY:-[self offsetAxisY:kDCPathButtonRightOffSetX withAngel:kDCPathButtonAngel60C] withDelay:0.5
     rotateDirection:kDCPathButtonRotationReverse animationDuration:1.2];
        //  关闭索引为1的按钮
        [self button:[self.buttons objectAtIndex:2]
            shrinkAt:kDCPathButtonSubButtonTag_2_AppearLocation
         offsetAxisX:0 offSEtAxisY:kDCPathButtonVerticalOffSetX
           withDelay:0.6
     rotateDirection:kDCPathButtonRotationNormal animationDuration:1.4];
        //  关闭索引为2的按钮
        self.expanded = NO;          //   将expanded设置为NO
    }
}
- (void)configureTheButtons:(NSInteger)buttonCount{
    //    设置显示后按钮的位置
    kDCPathButtonSubButtonTag_0_AppearLocation = CGPointMake(
                                                             self.centerLocationAxisX - self.totalRaiuds * sinf(kDCCovertAngelToRadian(kDCPathButtonAngel60C)),
                                                             self.centerLocationAxisY - self.totalRaiuds * cosf(kDCCovertAngelToRadian(kDCPathButtonAngel60C))); //    设置显示后索引为0的 按钮位置
    kDCPathButtonSubButtonTag_1_AppearLocation = CGPointMake(
                                                             self.centerLocationAxisX + self.totalRaiuds * sinf(kDCCovertAngelToRadian(kDCPathButtonAngel60C)),
                                                             self.centerLocationAxisY - self.totalRaiuds * cosf(kDCCovertAngelToRadian(kDCPathButtonAngel60C))); //    设置显示后索引为1的 按钮位置
    kDCPathButtonSubButtonTag_2_AppearLocation = CGPointMake(
                                                             self.centerLocationAxisX ,
                                                             self.centerLocationAxisY +self.totalRaiuds); //    设置显示后索引为2的 按钮位置
    self.buttons = [NSMutableArray array];
    //  对显示后的按钮进行设置
    for (NSInteger i = 0; i<3; i++) {
        _subButton = [[but alloc]init];
        _subButton.delegate = self;     //  设置委托
        _subButton.frame = CGRectMake(0, 0, self.subRadius * 2, self.subRadius * 2);
                                                          //   设置框架
        _subButton.center = kDCPathButtonSubButtonBirthLocation;   //  设置中心点
        NSString *imageFormat = [NSString stringWithFormat:@"dc-button_%ld",(long)i];
        [_subButton setImage:[UIImage imageNamed:imageFormat] forState:UIControlStateNormal];
        
        [self addSubview:_subButton];
        [self.buttons addObject:_subButton];
    }
}

#pragma mark - Add image to sub button, only use in the block

- (void)subButtonImage:(NSString *)imageName withTag:(NSInteger)tag{
    if (tag > self.buttonCount) {
        tag = self.buttonCount;
    }
    but *currentButton = [self.buttons objectAtIndex:tag];
    [currentButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}


#pragma mark - Set a sign to judge the animation state

- (BOOL)isExpanded{
    return _expanded;
}

#pragma mark - The center button and the sub button's animations
/*
 *   @pragma  设置弹出动画
 *    button       要进行动画的按钮
 *    appearAt   出现的位置
 *    Dalay         延迟时间
 *     duration    弹出时长
 */
- (void)button:(but *)button appearAt:(CGPoint)location withDalay:(CGFloat)delay duration:(CGFloat)duration
{
    button.center = location;   //    设置按钮的中心位置
    //   创建并设置缩放动画
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.duration = duration;     //   设置所需时间
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    scaleAnimation.calculationMode = kCAAnimationLinear;
    scaleAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:delay],[NSNumber numberWithFloat:1.0f]];
    button.layer.anchorPoint = CGPointMake(0.5f, 0.5f);   //  设置锚点   添加动画
    [button.layer addAnimation:scaleAnimation forKey:@"buttonAppear"];
    
}

/*
 * 收缩位置
 */
- (void)button:(but *)button shrinkAt:(CGPoint)location offsetAxisX:(CGFloat)axisX offSEtAxisY:(CGFloat)axisY withDelay:(CGFloat)delay rotateDirection:(DCPathButtonRotationOrientation)orientation animationDuration:(CGFloat)duration{
    //   旋转动画
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.duration = duration * delay;     //  时间设置
    rotation.values = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:[self matchRotationOrientation:orientation]],[NSNumber numberWithFloat:0.0f]];
    rotation.keyTimes = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:delay],[NSNumber numberWithFloat:1.0f]];
    //   缩小动画
    CAKeyframeAnimation *shrink = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    shrink.duration = duration * (1 - delay);   //   设置时间
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, location.x, location.y);   //  设置路径初始点
    CGPathAddLineToPoint(path, NULL, location.x + axisX, location.y + axisY);
    CGPathAddLineToPoint(path, NULL, kDCPathButtonSubButtonFinalLocation.x, kDCPathButtonSubButtonFinalLocation.y);
    shrink.path = path;                                    //   设置缩放动画路径
    CGPathRelease(path);
    //   组合动画
    CAAnimationGroup *totalAnimation = [CAAnimationGroup animation];
    totalAnimation.duration = 1.0f;                             //   设置时间
    totalAnimation.animations = @[rotation,shrink];  //  动画效果
    totalAnimation.fillMode = kCAFillModeForwards;
    totalAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    totalAnimation.delegate = self;                                   //  设置委托
    
    button.layer.anchorPoint = CGPointMake(0.5f, 0.5f);  //   设置中心位置
    button.center = kDCPathButtonSubButtonBirthLocation;
    [button.layer addAnimation:totalAnimation forKey:@"buttonDismiss"];
}

/*
 *  旋转方向
 */
- (CGFloat)matchRotationOrientation:(DCPathButtonRotationOrientation)orientation{
    if (orientation == kDCPathButtonRotationNormal) {
        return kDCPathButtonDefaultRotation;
    }
    return kDCPathButtonDefaultReverseRotation;
}
/*
 * 偏移的x轴和Y轴
 */
- (CGFloat)offsetAxisY:(CGFloat)axisX withAngel:(CGFloat)angel{
    return (axisX / tanf(kDCCovertAngelToRadian(angel)));
}

#pragma DCSubButton Delegate

- (void)subButtonPress:(but *)button{
    if ([_delegate respondsToSelector:@selector(button_0_action)] &&
        button == [self.buttons objectAtIndex:0]) {
        [_delegate button_0_action];           //   调用button_0_action的方法
    }
    else if ([_delegate respondsToSelector:@selector(button_1_action)] &&
             button == [self.buttons objectAtIndex:1]){
        [_delegate button_1_action];         //   调用button_1_action的方法
    }
    else if ([_delegate respondsToSelector:@selector(button_2_action)] &&
             button == [self.buttons objectAtIndex:2]){
        [_delegate button_2_action];         //   调用button_2_action的方法
    }
    
}
@end
