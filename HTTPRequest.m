

#import "HTTPRequest.h"

#define TIMEOUT 20
#define LONGTIME 20

@implementation HTTPRequest
@synthesize HttpConnection,receiveData,m_delegate;
@synthesize forwordFlag;
@synthesize timer;
@synthesize hasTimeOut;

- (void)dealloc 
{
	[HttpConnection release];
	[receiveData release];
    [super dealloc];
}

-(void)requestByUrlByGet:(NSString*)stringUrl//get方式请求
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *myWebserverURL = [NSURL URLWithString:[stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; 
    NSMutableURLRequest *httprequest = [[NSMutableURLRequest alloc] initWithURL:myWebserverURL];
    [httprequest setHTTPMethod:@"GET"]; 
    
    if(timer)
        [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMEOUT target:self selector:@selector(timeout:) userInfo:nil repeats:NO];
    [httprequest setTimeoutInterval:TIMEOUT];
    
	[httprequest setCachePolicy: NSURLRequestUseProtocolCachePolicy];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:httprequest delegate:self]; 
    self.HttpConnection = conn;
    [self.HttpConnection start];
    
    [conn release];
    [httprequest release];
}

-(void)requestByUrl:(NSString*)stringUrl dic:(NSMutableDictionary*)dic//post方式请求
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
      
    NSURL *myWebserverURL = [NSURL URLWithString:[stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; 
	NSMutableURLRequest *httprequest = [[NSMutableURLRequest alloc] initWithURL:myWebserverURL];
    NSMutableString *mustr = [[NSMutableString alloc] init];
    NSArray *array = [dic allKeys];
    for(int i=0;i<[dic count];i++)
    {
        NSString *key = [array objectAtIndex:i];
        id k = [dic objectForKey:key];
        if([k isKindOfClass:[NSString class]])
        {
            NSString *value = (NSString*)k;
            [mustr appendString:[NSString stringWithFormat:@"%@=%@&",key,value]];
        }
        else
        {
            [mustr appendString:[NSString stringWithFormat:@"%@=%@&",key,k]];
        }
    }
    NSString *string = [NSString stringWithFormat:@"%@",mustr];
    string = [string stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSData *postData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [httprequest setHTTPMethod:@"POST"]; 
	[httprequest setCachePolicy: NSURLRequestUseProtocolCachePolicy];
    
    if(timer)
        [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMEOUT target:self selector:@selector(timeout:) userInfo:nil repeats:NO];
    [httprequest setTimeoutInterval:TIMEOUT];
    
    [httprequest setHTTPBody:postData];
    
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:httprequest delegate:self]; 
    self.HttpConnection = conn;
    [self.HttpConnection start];
    [mustr release];
    [conn release];
    [httprequest release];
}

//超时 
-(void)timeout:(id)sender
{
    
	[self closeConnection];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if(m_delegate ==nil)
        return ;
    if([m_delegate respondsToSelector:@selector(requesttimeout)])
        [m_delegate requesttimeout];
}

#pragma mark 网络连接
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.receiveData appendData:data];	
}

//数据已经通过http请求下载完成，开始解析
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if(timer)
        [self.timer invalidate];

    NSString *str = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];	
    
    @try
    {
        if(m_delegate == nil)
            return ;
        
        if([m_delegate respondsToSelector:@selector(requFinish:order:)])
            [m_delegate requFinish:str order:forwordFlag];
    }
    @catch (NSException *exception) 
    {
    }
    
    
    [str release];
    str = nil;
    
	self.receiveData = nil;
	[self closeConnection];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    @try
    {   
        if(m_delegate == nil)
            return ;
        
        if([m_delegate respondsToSelector:@selector(requesttimeout)])
            [m_delegate requesttimeout];
    }
    @catch (NSException *exception) 
    {
    }
    
	[self closeConnection];
}

//关闭http连接
-(void)closeConnection
{
	if(self.HttpConnection != nil)
	{
		[self.HttpConnection cancel];
		self.HttpConnection  = nil;
	}
    if(timer)
        [self.timer invalidate];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
