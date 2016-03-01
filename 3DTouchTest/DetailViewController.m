//
//  DetailViewController.m
//  3DTouchTest
//
//  Created by 夏桂峰 on 16/2/25.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
@implementation DetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    [self.view addSubview:lb];
    lb.center=self.view.center;
    lb.textAlignment=NSTextAlignmentCenter;
    lb.text=[NSString stringWithFormat:@"%@是一个iOS开发程序员",self.title];
}
/**peek时上拉出来的菜单*/
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    return self.actions;
}

@end
