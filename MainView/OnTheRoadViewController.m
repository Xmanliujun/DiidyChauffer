//
//  OnTheRoadViewController.m
//  DiidyProject
//
//  Created by diidy on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OnTheRoadViewController.h"

@interface OnTheRoadViewController ()

@end

@implementation OnTheRoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)creatPageContent
{
        
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"u927_normal.png"] forState:UIControlStateNormal];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    rightButton.frame=CGRectMake(240.0, 4.0, 70.0, 35.0);
    [rightButton addTarget:self action:@selector(saveSMSNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rightButton];

    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"u13_normal.png"] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    leftButton.frame=CGRectMake(10.0, 4.0, 70.0, 35.0);
    [leftButton addTarget:self action:@selector(returnPrevView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftButton];
    
    
    UILabel * descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 60.0)];
    descriptionLable.text = @"文案说明.................";
    descriptionLable.backgroundColor = [UIColor clearColor];
    descriptionLable.font = [UIFont fontWithName:@"Arial" size:14.0];
    [self.view addSubview:descriptionLable];
    
    UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 15.0, 60.0, 20.0)];
    numberLable.text = @"亲情号码:";
    numberLable.font = [UIFont fontWithName:@"Arial" size:12.0];
    numberLable.backgroundColor = [UIColor clearColor];
    
    numberText = [[UITextView alloc] initWithFrame:CGRectMake(65.0, 10.0, 230.0, 30.0)];
    numberText.textColor = [UIColor blackColor];
    numberText.text = @"";
    numberText.returnKeyType = UIReturnKeyDefault;
    numberText.font = [UIFont fontWithName:@"Arial" size:14.0];
    numberText.keyboardType = UIKeyboardTypePhonePad;
    
    
    UIImage * numberImage = [UIImage imageNamed:@"u83_normal.png"];
    UIImageView * numberImageView = [[UIImageView alloc] initWithImage:numberImage];
    numberImageView.userInteractionEnabled = YES;
    numberImageView.frame = CGRectMake(0.0, 70.0, numberImage.size.width,numberImage.size.height);
    [numberImageView addSubview:numberLable];
    [numberImageView addSubview:numberText];
    [self.view addSubview:numberImageView];
    
    [numberText release];
    [numberLable release];
    [numberImageView release];
    [descriptionLable release];
   

    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"在路上";
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"u0_normal.png"]];
    [self creatPageContent];
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [numberText resignFirstResponder];
}
-(void)returnPrevView:(id)sender
{
   
    [self.navigationController popViewControllerAnimated:YES];


}
-(void)viewDidDisappear:(BOOL)animated
{
    rightButton.hidden = YES;
    leftButton.hidden = YES;
   
}

-(void)dealloc
{
   
    [super dealloc];

}
-(void)saveSMSNumber:(id)sendrr
{
    NSLog(@"%@",numberText.text);

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
