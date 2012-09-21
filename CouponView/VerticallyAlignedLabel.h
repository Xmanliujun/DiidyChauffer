
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

typedef enum VerticalAlignment {
    
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;


@interface VerticallyAlignedLabel : UILabel

{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;
@end
