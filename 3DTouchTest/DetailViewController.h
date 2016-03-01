//
//  DetailViewController.h
//  3DTouchTest
//
//  Created by 夏桂峰 on 16/2/25.
//  Copyright © 2016年 夏桂峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

/**peek时上拉出来的菜单*/
@property(nonatomic,strong)NSArray<id<UIPreviewActionItem>> *actions;


@end
