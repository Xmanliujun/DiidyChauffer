

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HTTPRequest.h"
@interface ManageMentViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,HTTPRequestDelegate>
{
    UIButton* returnButton;
   
    NSMutableArray * listOrderArray;
    UIImageView*topImageView ;
    UILabel*centerLable;
    
    NSMutableData * receivedData;
    NSURLConnection * urlConnecction;
    BOOL sqlitBool;
    
    MBProgressHUD *HUD;
    NSString * baseUrl;
    UIButton * rigthbutton;
    
   

}
@property (nonatomic, retain) MBProgressHUD *HUD;
@property(nonatomic, retain)HTTPRequest *m_request;
@end
