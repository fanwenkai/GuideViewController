//
//  GuideViewController.m
//  GuideViewTest
//
//  Created by 你懂得的神 on 16/1/27.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "GuideViewController.h"
#import <objc/runtime.h>
#import "GuideViewPage.h"
#import "GlobalDefaultSet.h"

#import <Masonry.h>
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface GuideViewController ()<
UIScrollViewDelegate
>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *contentView;

//分页
@property(nonatomic, strong) UIPageControl *pageControl;
//保存每个Page页面的数据
@property(nonatomic, strong) NSArray *imageNamesArr;
@property(nonatomic, strong) NSArray *titlesArr;
@property(nonatomic, strong) NSArray *desTitlesArr;
@property(nonatomic, strong) NSArray *bgImageNamesArr;
//按钮的回调
@property(nonatomic, strong) configBtnBlock configBlock;
//进入首页的回调
@property(nonatomic, strong) compeleteBlock comBlock;

@end

NSString *const NewFeatureVersionKey = @"NewGuideViewVersionKey";

static NSString *kStaticTextButtonKey;

@implementation GuideViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customView];
}

- (void)customView
{
    _scrollView = [UIScrollView new];
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    _contentView = [UIView new];
    [_scrollView addSubview:_contentView];
    
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.height.equalTo(_scrollView);
    }];
    UIView *lastView = nil;
    NSInteger totalCount = _imageNamesArr.count;
    for (int i = 0; i < totalCount; i++) {
        GuideViewPage *tempView = [GuideViewPage newGuideViewPageTitle:_titlesArr[i]
                                                           andDesTitle:_desTitlesArr[i]
                                                          andImageView:_imageNamesArr[i]
                                                        andBgImageView:_bgImageNamesArr[i]];
        [_contentView addSubview:tempView];
        if (lastView) {
            [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView.mas_right);
                make.top.equalTo(lastView.mas_top);
                make.bottom.equalTo(lastView.mas_bottom);
                make.width.equalTo(lastView.mas_width);
            }];
        }
        else{
            [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_contentView.mas_left);
                make.top.equalTo(_contentView.mas_top);
                make.bottom.equalTo(_contentView.mas_bottom);
                make.width.mas_equalTo(kScreenWidth);
            }];
        }
        lastView = tempView;
    }
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right);
    }];
    
    //添加分页控制View
    _pageControl = [UIPageControl new];
    [self.view addSubview:_pageControl];
    _pageControl.currentPageIndicatorTintColor = kHiglightColor;
    _pageControl.pageIndicatorTintColor = kNormalColor;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _imageNamesArr.count;
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.75, 22));
    }];
    
    if (_configBlock) {
        UIButton  *centerButton = objc_getAssociatedObject(self, &kStaticTextButtonKey);
        
        if (!centerButton) {
            centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
            objc_setAssociatedObject(self, &kStaticTextButtonKey, centerButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [self.view addSubview:centerButton];
        centerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        centerButton.layer.cornerRadius = 10;
        centerButton.layer.masksToBounds = YES;
        [centerButton addTarget:self action:@selector(centerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        _configBlock(centerButton);
        [centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_pageControl.mas_top).offset(-25);
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.75, 44));
        }];
    }
}

+ (instancetype)newGuideViewWithImageNames:(NSArray *)imageNamesArr
                                  andTitle:(NSArray *)titlesArr
                               andDesTitle:(NSArray *)desTitlesArr
                               andBgImages:(NSArray *)bgImageNamesArr
                         andConfigBtnBlock:(configBtnBlock)block
                         andCompeleteBlock:(compeleteBlock)compeleteBlock
{
    GuideViewController *guideVC = [[GuideViewController alloc] init];
    
    @try {
        guideVC.imageNamesArr = [NSArray arrayWithArray:imageNamesArr];
        guideVC.titlesArr = [NSArray arrayWithArray:titlesArr];
        guideVC.desTitlesArr = [NSArray arrayWithArray:desTitlesArr];
        guideVC.bgImageNamesArr = [NSArray arrayWithArray:bgImageNamesArr];
        guideVC.configBlock = block;
        guideVC.comBlock = compeleteBlock;
    }
    @catch (NSException *exception) {
        guideVC.imageNamesArr = nil;
        guideVC.titlesArr = nil;
        guideVC.desTitlesArr = nil;
        guideVC.bgImageNamesArr = nil;
        guideVC.configBlock = nil;
        return nil;
    }
    
    return guideVC;
}

+ (BOOL)canShowNewFeature{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[[NSBundle mainBundle].infoDictionary valueForKey:(NSString *)kCFBundleVersionKey];
    
    // 获取preference
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //读取本地版本号
    NSString *versionLocal = [defaults objectForKey:NewFeatureVersionKey];
    if(versionLocal!=nil && [versionValueStringForSystemNow isEqualToString:versionLocal]){//说明有本地版本记录，且和当前系统版本一致
        return NO;
        
    }else{ // 无本地版本记录或本地版本记录与当前系统版本不一致
        
        //保存
        [defaults setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
        // 立即同步
        [defaults synchronize];
        return YES;
    }
}

#pragma mark - Action
- (void)centerBtnClicked
{
    if (_comBlock) {
        _comBlock();
        [self dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    int current = scrollView.contentOffset.x/kScreenWidth;
    _pageControl.currentPage = current;
}

@end
