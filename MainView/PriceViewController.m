//
//  PriceViewController.m
//  DiidyChauffer
//
//  Created by diidy on 12-10-16.
//
//

#import "PriceViewController.h"

@interface PriceViewController ()

@end

@implementation PriceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self.navigationController setNavigationBarHidden:NO];
    topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1.png"]];
    topImageView.frame = CGRectMake(0.0f, -2.0f, 320.0f, 49.0f);
    [self.navigationController.navigationBar addSubview:topImageView];
    
    returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.0f];
    returnButton.frame=CGRectMake(7.0f, 7.0f, 50.0f, 30.0f);
    [returnButton setTitle:@" 返回" forState:UIControlStateNormal];
    [returnButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnMainView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:returnButton];
    
    UILabel *centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    centerLable.font = [UIFont fontWithName:@"Arial" size:17];
    centerLable.textColor = [UIColor whiteColor];
    centerLable.backgroundColor = [UIColor clearColor];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.text = @"价 格 说 明";
    self.navigationItem.titleView = centerLable;
    [centerLable release];
    
    UIImage *priceImage =[UIImage imageNamed:@"pricenew.png"];
    priceImageView = [[UIImageView alloc] initWithImage:priceImage];
    priceImageView.userInteractionEnabled = YES;
    priceImageView.frame = CGRectMake(0.0f,0.0f, 320.0f, 416.0f);
    
    UIButton* telButton = [UIButton buttonWithType:UIButtonTypeCustom];
    telButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    telButton.frame=CGRectMake(80.0f, 370.0f, 160.0f, 30.0f);
    [telButton setBackgroundImage:[UIImage imageNamed:@"call_up.png"] forState:UIControlStateNormal];
    [telButton addTarget:self action:@selector(telephoneInquiries:) forControlEvents:UIControlEventTouchUpInside];
    [priceImageView addSubview:telButton];
    [self.view addSubview:priceImageView];

}

-(void)telephoneInquiries:(id)sender
{
    
//    
//    UIActionSheet *menu = [[[UIActionSheet alloc]
//                            initWithTitle:nil
//                            delegate:self
//                            cancelButtonTitle:@"取消"
//                            destructiveButtonTitle:@"400 696 0666"
//                            otherButtonTitles:nil] autorelease];
//    [menu showInView:self.view];
    
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:4006960666"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
    [callWebview release];
    
    
}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    
//    if(buttonIndex==0){
//        
//       
//    }else {
//       
//    }
//    
//}


-(void)returnMainView:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
