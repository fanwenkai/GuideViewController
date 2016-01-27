//
//  GuideViewController.h
//  GuideViewTest
//
//  Created by 你懂得的神 on 16/1/27.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuideViewPage;

typedef void(^configBtnBlock)(UIButton *button);
typedef void(^compeleteBlock)();

@interface GuideViewController : UIViewController
//创建控制器实例
+ (instancetype)newGuideViewWithImageNames:(NSArray *)imageNamesArr
                                  andTitle:(NSArray *)titlesArr
                               andDesTitle:(NSArray *)desTitlesArr
                            andBgImages:(NSArray *)bgImageNamesArr
                         andConfigBtnBlock:(configBtnBlock)block
                         andCompeleteBlock:(compeleteBlock)compeleteBlock;
// 是否应该显示版本新特性页面
+ (BOOL)canShowNewFeature;
@end
