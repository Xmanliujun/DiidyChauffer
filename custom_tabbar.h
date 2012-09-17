//
//  custom_tabbar.h
//  customTab
//
//  Created by zhaoxiaopeng on 11-6-24.
//  QQ:251792377
//  Copyright  All rights reserved.

#import <UIKit/UIKit.h>


@interface custom_tabbar : UITabBarController{
//button背景图片
	UIImageView *backgroud_image;
//选中时的图片
	UIImageView *select_image;
//背景图片
	UIImageView *tab_bar_bg;
//button上的text	
	NSMutableArray *tab_text;
	
	NSMutableArray *tab_btn;
	UIButton *btn;
}

- (void) init_tab;
- (void) when_tabbar_is_unselected;
- (void) add_custom_tabbar_elements;
- (void) when_tabbar_is_selected:(int)tabID;

@end
