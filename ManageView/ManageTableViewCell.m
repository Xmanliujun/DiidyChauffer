//
//  ManageTableViewCell.m
//  DiidyProject
//
//  Created by diidy on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ManageTableViewCell.h"

@implementation ManageTableViewCell
@synthesize departureLable,startTimeLable,orderNumberLable,statusLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSelectionStyle:UITableViewCellEditingStyleNone];
        
         NSArray* orderArray = [NSArray arrayWithObjects:@"订单编号 :",@"出发时间 :",@"出发地 :", nil];
         
        for(int i = 0; i<3;i++){
            
            UILabel * firstOrderLable = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 5.0+30.0*i, 60.0, 30)];
            firstOrderLable.backgroundColor = [UIColor clearColor];
            firstOrderLable.text = [orderArray objectAtIndex:i];
            firstOrderLable.textColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1];
            firstOrderLable.font = [UIFont fontWithName:@"Arial" size:13.0];
            [self.contentView addSubview:firstOrderLable];
            [firstOrderLable release];
            
        }
        orderNumberLable = [[UILabel alloc] init];
        orderNumberLable.frame = CGRectMake(75, 5, 140, 30);
        orderNumberLable.backgroundColor = [UIColor clearColor];
        orderNumberLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
        orderNumberLable.font = [UIFont fontWithName:@"Arial" size:13.0];
        [self.contentView addSubview:orderNumberLable];
        
        startTimeLable = [[UILabel alloc] init];
        startTimeLable.frame = CGRectMake(75, 35, 140, 30);
        startTimeLable.backgroundColor = [UIColor clearColor];
        startTimeLable.font = [UIFont fontWithName:@"Arial" size:13.0];
        startTimeLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
        [self.contentView addSubview: startTimeLable];
        
        departureLable = [[UILabel alloc] init];
        departureLable.frame = CGRectMake(75, 65, 180, 30);
        departureLable.backgroundColor = [UIColor clearColor];
        departureLable.numberOfLines = 0;
        departureLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
        departureLable.font = [UIFont fontWithName:@"Arial" size:13.0];
        [self.contentView addSubview: departureLable];
        
        statusLable = [[UILabel alloc] initWithFrame:CGRectMake(250, 35, 60, 30)];
        statusLable.backgroundColor = [UIColor clearColor];
        statusLable.textColor = [UIColor redColor];
        statusLable.font = [UIFont fontWithName:@"Arial" size:14.0];
        statusLable.tag = 200;
        [self.contentView addSubview:statusLable];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc
{
    [statusLable release];
    [orderNumberLable release];
    [startTimeLable release];
    [departureLable release];
    [super dealloc];

}
@end
