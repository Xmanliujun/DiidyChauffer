
#import <UIKit/UIKit.h>

@protocol HTTPRequestDelegate<NSObject>
@optional
-(void)requFinish:(NSString *)requestString order:(int)nOrder;
-(void)requesttimeout;
@end

@interface HTTPRequest : NSObject
<NSURLConnectionDelegate>
{
}

@property (nonatomic, assign) BOOL hasTimeOut;

@property (nonatomic, retain) NSURLConnection *HttpConnection;
@property (nonatomic, retain) NSMutableData *receiveData;
@property (nonatomic, assign) id<HTTPRequestDelegate> m_delegate;
@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, assign) int forwordFlag;

-(void)requestByUrl:(NSString*)stringUrl dic:(NSMutableDictionary*)dic;
-(void)requestByUrlByGet:(NSString*)stringUrl;
-(void)closeConnection;
-(void)timeout:(id)sender;

@end
