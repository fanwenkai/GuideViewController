//
//  GuideViewPage.m
//  GuideViewTest
//
//  Created by 你懂得的神 on 16/1/27.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "GuideViewPage.h"
#import "GlobalDefaultSet.h"
#import <Masonry.h>

@implementation GuideViewPage
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _bgImageView = [UIImageView new];
        [self addSubview:_bgImageView];
        
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        _titleLabel.numberOfLines = 2;//最大不能超过两行
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:kGeneralFontSize];
        _titleLabel.textColor = kTextColor;
        
        _desTitleLabel = [UILabel new];
        [self addSubview:_desTitleLabel];
        _desTitleLabel.numberOfLines = 3;//最大不能超过三行
        _desTitleLabel.textAlignment = NSTextAlignmentCenter;
        _desTitleLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
        _desTitleLabel.textColor = kTextColor;
        
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-100);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(_imageView.mas_bottom).offset(20);
        }];
        
        [_desTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_left);
            make.right.equalTo(_titleLabel.mas_right);
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        }];
    }
    return self;
}

+ (instancetype)newGuideViewPageTitle:(NSString *)titleStr
                          andDesTitle:(NSString *)desTitleStr
                         andImageView:(NSString *)imageStr
                       andBgImageView:(NSString *)bgImageStr
{
    GuideViewPage *tempView = [GuideViewPage new];
    tempView.titleLabel.text = titleStr;
    tempView.desTitleLabel.text = desTitleStr;
    [tempView.imageView setImage:[UIImage imageNamed:imageStr]];
    [tempView.bgImageView setImage:[UIImage imageNamed:bgImageStr]];
    return tempView;
}

@end
