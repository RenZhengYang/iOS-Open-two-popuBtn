//
//  ViewController.m
//  iOS开发范例-按钮类-实例 ② 弹出式按钮
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Button.h"
@interface ViewController ()<ButtonDelegate>

@end
@implementation ViewController

- (void)viewDidLoad {
   
        [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0,300, 300);  //  中心按钮的中心位置
    self.view.backgroundColor = [UIColor cyanColor];
    Button *dcPathButton = [[Button alloc]
                            initDCPathButtonWithSubButtons:4
                            totalRadius:60       //   子类按钮和中心按钮之间的距离
                            centerRadius:20    //   中心按钮大小
                            subRadius:15        //    子类按钮大小
                            centerImage:@"button2.png"
                            centerBackground:nil
                            subImages:^(Button *dc){
                                [dc subButtonImage:@"button1.png" withTag:0];
                                [dc subButtonImage:@"button3.png" withTag:1];
                                [dc subButtonImage:@"button4.png" withTag:2];
                                
                            }
                            subImageBackground:nil
                            inLocationX:0 locationY:0 toParentView:self.view];
    dcPathButton.delegate = self;
    


}
- (void)button_0_action{
    UIAlertView *A=[[UIAlertView alloc]initWithTitle:@"你选择的是“电话”按钮" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [A show];
}
- (void)button_1_action{
    UIAlertView *A=[[UIAlertView alloc]initWithTitle:@"你选择的是“快进”按钮" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [A show];
}
- (void)button_2_action{
    UIAlertView *A=[[UIAlertView alloc]initWithTitle:@"你选择的是“删除”按钮" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [A show];
}


@end
