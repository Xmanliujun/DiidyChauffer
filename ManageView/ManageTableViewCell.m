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
        // Initialization code
         NSArray* orderArray = [NSArray arrayWithObjects:@"订单编号 :",@"出发时间 :",@"出发地 :", nil];
         [self setSelectionStyle:UITableViewCellEditingStyleNone];
        
        for(int i = 0; i<3;i++){
            UILabel * firstOrderLable = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 5.0+30.0*i, 60.0, 30)];
            firstOrderLable.backgroundColor = [UIColor clearColor];
            firstOrderLable.text = [orderArray objectAtIndex:i];
            firstOrderLable.font = [UIFont fontWithName:@"Arial" size:13.0];
            [self.contentView addSubview:firstOrderLable];
            [firstOrderLable release];
            
        }
        orderNumberLable = [[UILabel alloc] init];
        orderNumberLable.frame = CGRectMake(75, 5, 140, 30);
        orderNumberLable.backgroundColor = [UIColor clearColor];
        orderNumberLable.font = [UIFont fontWithName:@"Arial" size:13.0];
        [self.contentView addSubview:orderNumberLable];
        
        startTimeLable = [[UILabel alloc] init];
        startTimeLable.frame = CGRectMake(75, 35, 140, 30);
        startTimeLable.backgroundColor = [UIColor clearColor];
        startTimeLable.font = [UIFont fontWithName:@"Arial" size:13.0];
        [self.contentView addSubview: startTimeLable];
        
        departureLable = [[UILabel alloc] init];
        departureLable.frame = CGRectMake(75, 65, 140, 30);
        departureLable.backgroundColor = [UIColor clearColor];
        departureLable.font = [UIFont fontWithName:@"Arial" size:13.0];
        [self.contentView addSubview: departureLable];
        
        statusLable = [[UILabel alloc] initWithFrame:CGRectMake(230, 35, 60, 30)];
        statusLable.backgroundColor = [UIColor clearColor];
        statusLable.textColor = [UIColor redColor];
        statusLable.font = [UIFont fontWithName:@"Arial" size:14.0];
        statusLable.tag = 200;
        [self.contentView addSubview:statusLable];
        [statusLable release];

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
