# GuideViewController
引导页功能，测试环境 ，xcode7.2 ios9

用法：
 BOOL canShow = [GuideViewController canShowNewFeature];
    //测试用
    canShow = YES;
    if (canShow) {
        
        GuideViewController *guideVC = [GuideViewController newGuideViewWithImageNames:@[@"cloud_img0",@"cloud_img1",@"cloud_img2"]
                                                                              andTitle:@[@"欢迎页1",@"欢迎页2",@"欢迎页3"]
                                                                           andDesTitle:@[@"你好，欢迎页1",@"你好，欢迎页2",@"你好，欢迎页3"]
                                                                           andBgImages:@[@"bg_image",@"bg_image",@"bg_image"]
                                                                     andConfigBtnBlock:^(UIButton *button)
        {
            [button setTitle:@"进入App" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:117 green:189 blue:188 alpha:1];
        } andCompeleteBlock:^
        {
            NSLog(@"进入首页");
        }];
        
        
        [self presentViewController:guideVC
                           animated:YES
                         completion:^
         {
             NSLog(@"完成");
         }];
        
    }
    else{
        NSLog(@"非首次进入");
    }
