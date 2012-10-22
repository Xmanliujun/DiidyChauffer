//
//  PriceViewController.h
//  DiidyChauffer
//
//  Created by diidy on 12-10-16.
//
//

#import <UIKit/UIKit.h>

@interface PriceViewController : UIViewController
<UIActionSheetDelegate>
{
    UIImageView *priceImageView;

    UIButton* returnButton;
    NSMutableArray * dataArry;
    UIImageView * topImageView;
}
@end
