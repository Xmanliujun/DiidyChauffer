//
//  EditDestinationViewController.m
//  DiidyChauffer
//
//  Created by diidy on 12-11-2.
//
//

#import "EditDestinationViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface EditDestinationViewController ()

@end

@implementation EditDestinationViewController
@synthesize DestionDelegate;
@synthesize destinationNSSString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setTheNavigationBar
{
    
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0, -2.0, 320.0, 49.0);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0, 7.0, 50.0, 30.0);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnFillOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    centerLable = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0.0f, 160.0f, 44.0f)];
    centerLable.font = [UIFont systemFontOfSize:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = UITextAlignmentCenter;
    centerLable.text =@"编 辑 目 的 地";
    [self.navigationController.navigationBar addSubview:centerLable];
    
    rigthbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
    [rigthbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigthbutton setTitle:@"确定" forState:UIControlStateNormal];
    rigthbutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    rigthbutton.frame=CGRectMake(260.0f, 7.0f, 50.0f, 30.0f);
    [rigthbutton addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rigthbutton];
    
}
#pragma mark-Button
-(void)returnFillOrderView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)nextStep:(id)sender
{
  
    NSLog(@"%@",destinationView.text);
    [DestionDelegate selectThePlaceOfDestion:destinationView.text];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"]){
        
        [destinationView resignFirstResponder];
        
    }
    return YES;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
     self.navigationItem.hidesBackButton = YES;
    [self setTheNavigationBar];
    UILabel *departureLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 30)];
    departureLable.font = [UIFont fontWithName:@"Arial" size:14.0];
    departureLable.textColor = [UIColor orangeColor];
    departureLable.backgroundColor = [UIColor clearColor];
    departureLable.textAlignment = NSTextAlignmentLeft;
    departureLable.text = @"目的地:";
    [self.view addSubview:departureLable];
    [departureLable release];
    
    destinationView = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, 300, 80)];
    destinationView.text = self.destinationNSSString;
    destinationView.delegate = self;
    destinationView.returnKeyType = UIReturnKeyDone;
    destinationView.font = [UIFont fontWithName:@"Arial" size:14.0];
    destinationView.keyboardType = UIKeyboardTypeDefault;
    [destinationView becomeFirstResponder];
    [self.view addSubview:destinationView];
    
    [[destinationView layer] setBorderColor:[UIColor grayColor].CGColor];
    [[destinationView layer] setBorderWidth:1];
    [[destinationView layer] setCornerRadius:5];
    [destinationView setClipsToBounds: YES];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    topImageView.hidden = YES;
    returnButton.hidden = YES;
    rigthbutton.hidden = YES;
    centerLable.hidden = YES;
    
}
-(void)dealloc
{
    [destinationView release];
    [centerLable release];
    [destinationView release];
    [topImageView release];
    [super dealloc];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
