//
//  GuideViewPage.h
//  GuideViewTest
//
//  Created by 你懂得的神 on 16/1/27.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewPage : UIView
//标题
@property(nonatomic, strong) UILabel *titleLabel;
//详细介绍
@property(nonatomic, strong) UILabel *desTitleLabel;
//图片展示
@property(nonatomic, strong) UIImageView *imageView;
//背景图片
@property(nonatomic, strong) UIImageView *bgImageView;

/**
 *  @Description 创建引导页每个Page
 *
 *  @param titleStr 引导页标题
 *  @param desTitleStr 引导页详细描述
 *  @param imageStr 引导页象征图片
 *  @param bgImageStr 引导页背景图片
 *
 *  @return 返回实例
 */
+ (instancetype)newGuideViewPageTitle:(NSString *)titleStr
                          andDesTitle:(NSString *)desTitleStr
                         andImageView:(NSString *)imageStr
                       andBgImageView:(NSString *)bgImageStr;

@end
