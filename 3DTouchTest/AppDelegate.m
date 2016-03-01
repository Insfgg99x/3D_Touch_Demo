//
//  AppDelegate.m
//  3DTouchTest
//
//  Created by 夏桂峰 on 16/1/13.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //3D Touch按压程序图标的快捷项
    //快捷菜单的图标
    UIApplicationShortcutIcon *icon1=[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCaptureVideo];
    UIApplicationShortcutIcon *icon2=[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutIcon *icon3=[UIApplicationShortcutIcon iconWithTemplateImageName:@"search"];
    //快捷菜单
    UIApplicationShortcutItem *item1=[[UIApplicationShortcutItem alloc]initWithType:@"1"
                                                                     localizedTitle:@"嘿嘿"
                                                                  localizedSubtitle:nil
                                                                               icon:icon1
                                                                           userInfo:nil];
    
    
    UIApplicationShortcutItem *item2=[[UIApplicationShortcutItem alloc]initWithType:@"1"
                                                                     localizedTitle:@"呵呵"
                                                                  localizedSubtitle:@"干嘛去洗澡"
                                                                               icon:icon2
                                                                           userInfo:nil];
    
    UIApplicationShortcutItem *item3=[[UIApplicationShortcutItem alloc]initWithType:@"1"
                                                                     localizedTitle:@"搜索"
                                                                  localizedSubtitle:nil
                                                                               icon:icon3
                                                                           userInfo:nil];
    //设置app的快捷菜单
    [[UIApplication sharedApplication] setShortcutItems:@[item1,item2,item3]];
    
    //导航
    self.window.rootViewController=[[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    
    return YES;
}
//3D Touch按压程序图标的快捷项时触发的方法
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSString *title;
    if([shortcutItem.localizedTitle isEqualToString:@"嘿嘿"])
    {
        title=@"嘿嘿";
    }
    else if([shortcutItem.localizedTitle isEqualToString:@"呵呵"])
    {
        title=@"呵呵";
    }
    else if([shortcutItem.localizedTitle isEqualToString:@"搜索"])
    {
        title=@"搜索";
    }
    
    //这里就弹个框子意思一下
    //由于UIAlertView在iOS 9被废弃，因此选用UIAlertController
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:[NSString stringWithFormat:@"你点击了“%@”",title]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"知道了"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action) {
                                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                                 }];
    [alertController addAction:action];
    [self.window.rootViewController presentViewController:alertController
                                                 animated:YES
                                               completion:nil];
}

@end
