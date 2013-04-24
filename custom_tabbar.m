//
//  custom_tabbar.m
//  customTab
//
//  Created by zhaoxiaopeng on 11-6-24.
//  QQ:251792377
//  Copyright  All rights reserved.

#import "custom_tabbar.h"


@implementation custom_tabbar


- (void)init_tab
{
	backgroud_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBar_01.png"]];
	select_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBar_01_s.png"]];
	tab_bar_bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tools_bar_bg.png"]];
	tab_text = [[NSMutableArray alloc] initWithObjects:@"电话约",@"在线约",@"算算看",nil];
    
    seltArry = [NSArray arrayWithObjects:@"tabbar2.png",@"tabbar1.png",@"tabbar3.png",nil];
    tableArry  = [NSArray arrayWithObjects:@"tabbar21.png",@"tabbar11.png",@"tabbar31.png", nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self init_tab];
	[self when_tabbar_is_unselected];
	[self add_custom_tabbar_elements];
}

- (void)when_tabbar_is_unselected
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

-(void)add_custom_tabbar_elements
{
	
	int tab_num = 3;
	
	UIImageView *tabbar_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 430, 320, 50)];
	[tabbar_bg setImage:tab_bar_bg.image];
	[self.view addSubview:tabbar_bg];
    [tabbar_bg release];
	
	tab_btn = [[NSMutableArray alloc] initWithCapacity:0];
	for (int i = 0; i < tab_num; i++)
	{
        UIImage *tableImage =  [UIImage imageNamed:[tableArry objectAtIndex:i]];
        UIImage * selectImage =[UIImage imageNamed:[seltArry objectAtIndex:i]];
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn setFrame:CGRectMake(i*107, 430, 107, 50)];
        
//		[btn setBackgroundImage:backgroud_image.image forState:UIControlStateNormal];
//		[btn setBackgroundImage:select_image.image forState:UIControlStateSelected];
//		[btn setTitle:[tab_text objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundImage:tableImage forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImage forState:UIControlStateSelected];
        
       
		[btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
		if (i == 1)
		{
            tabLable1 = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 20.0f, 70.0f, 30.0f)];
            tabLable1.text = [tab_text objectAtIndex:i];
            tabLable1.textAlignment = NSTextAlignmentCenter;
            tabLable1.backgroundColor = [UIColor clearColor];
            tabLable1.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
            [btn addSubview:tabLable1];
            tabLable1.textColor = [UIColor whiteColor];
			[btn setSelected:YES];
		}else if(i==0)
        {
            
            tabLable = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 20.0f, 70.0f, 30.0f)];
            tabLable.text = [tab_text objectAtIndex:i];
            tabLable.textAlignment = NSTextAlignmentCenter;
            tabLable.backgroundColor = [UIColor clearColor];
            tabLable.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
            [btn addSubview:tabLable];
            [tabLable release];
            tabLable.textColor = [UIColor orangeColor];
        
        }else if (i==2){
        
            tabLable2 = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 20.0f, 70.0f, 30.0f)];
            tabLable2.text = [tab_text objectAtIndex:i];
            tabLable2.textAlignment = NSTextAlignmentCenter;
            tabLable2.backgroundColor = [UIColor clearColor];
            tabLable2.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
            [btn addSubview:tabLable2];
            tabLable2.textColor = [UIColor orangeColor];
            
        }
        
		[btn setTag:i];
		[tab_btn addObject:btn];
    
        [self.view addSubview:btn];
		[btn addTarget:self action:@selector(button_clicked_tag:) forControlEvents:UIControlEventTouchUpInside];
		[btn release];
        
        
	}
}

- (void)button_clicked_tag:(UIButton*)sender
{
	int tagNum = [sender tag];
    if (tagNum==0) {
       
        tabLable1.textColor = [UIColor orangeColor];
        tabLable.textColor = [UIColor whiteColor];
        tabLable2.textColor = [UIColor orangeColor];
    }else if (tagNum==1)
    {
        tabLable1.textColor = [UIColor whiteColor];
        tabLable.textColor = [UIColor orangeColor];
        tabLable2.textColor = [UIColor orangeColor];
        

    }else if (tagNum==2)
    {
        tabLable1.textColor = [UIColor orangeColor];
        tabLable.textColor = [UIColor orangeColor];
        tabLable2.textColor = [UIColor whiteColor];
    }
    
   	[self when_tabbar_is_selected:tagNum];
}

- (void)when_tabbar_is_selected:(int)tabID
{
	switch(tabID)
	{
        case 0:
			[[tab_btn objectAtIndex:0] setSelected:true];
			[[tab_btn objectAtIndex:1] setSelected:false];
			[[tab_btn objectAtIndex:2] setSelected:false];
			break;
		case 1:
			[[tab_btn objectAtIndex:0] setSelected:false];
			[[tab_btn objectAtIndex:1] setSelected:true];
			[[tab_btn objectAtIndex:2] setSelected:false];
			break;
		case 2:
			[[tab_btn objectAtIndex:0] setSelected:false];
			[[tab_btn objectAtIndex:1] setSelected:false];
			[[tab_btn objectAtIndex:2] setSelected:true];
			break;
//		case 3:
//			[[tab_btn objectAtIndex:0] setSelected:false];
//			[[tab_btn objectAtIndex:1] setSelected:false];
//			[[tab_btn objectAtIndex:2] setSelected:false];
//			break;
	}	
	
	self.selectedIndex = tabID;
}

- (void)dealloc {
    [tabLable1 release];
    [tabLable release];
    [tabLable2 release];
	[backgroud_image release];
	[select_image release];
	[tab_bar_bg release];
	[tab_text release];
	[tab_btn release];
    [super dealloc];
}

@end
