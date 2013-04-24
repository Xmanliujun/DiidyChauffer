#import "CouponTableCell.h"

@implementation CouponTableCell
@synthesize nameLable,closeDataLable;
//@synthesize presentationLable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellEditingStyleNone];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
        
        UILabel*  presentationLable = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 100, 60)];
        presentationLable.backgroundColor = [UIColor clearColor];
        presentationLable.text = @"赠送给朋友 >>";
        presentationLable.font = [UIFont fontWithName:@"Arial" size:14];
        presentationLable.textColor = [UIColor orangeColor];
        [self.contentView addSubview:presentationLable];
        [presentationLable release];
        
        nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, 30)];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1];
        nameLable.font = [UIFont fontWithName:@"Arial" size:14];
        [self.contentView addSubview:nameLable];
            
        closeDataLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 140, 30)];
        closeDataLable.backgroundColor = [UIColor clearColor];
        closeDataLable.textColor = [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1];
        closeDataLable.font = [UIFont fontWithName:@"Arial" size:14];
        [self.contentView addSubview:closeDataLable];

    }
        return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
-(void)dealloc
{
    [nameLable release];
    [closeDataLable release];
    [super dealloc];

}
@end
