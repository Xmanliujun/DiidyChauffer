//
//  CONST.h
//  DiidyProject
//
//  Created by diidy on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef DiidyProject_CONST_h
#define DiidyProject_CONST_h

#define RECTMAKE(x,y,width,height) CGRectMake(x,y,width,height);


#define LAND @"http://www.diidy.com/client/logon/%@/%@/%@/%@/1/%f/%@"
#define REGISTER  @"http://www.diidy.com/client/check/%@/register"
#define PASSWORD @"http://www.diidy.com/client/check/%@/password"
#define SETUP @"http://www.diidy.com/client/confirm/%@/%@/%@/%@/%@/%@/%@/1/%f/%@"
#define REGAIN @"http://www.diidy.com/client/getAuthcode/%@"
#define COUPON @"http://www.diidy.com/client/getCoupon/%@"
#define GIFTCOUPONS @"http://www.diidy.com/client/giveCoupon/%@/%@/%@"
#define ORDERNUMBER @"http://www.diidy.com/client/orderlist/%@"
#define BILLINGDETAIL @"http://www.diidy.com/client/orderdetail/%@"
#define EXECORDERS @"http://www.diidy.com/client/ordering/%@"
#define POSITIONDRIVER @"http://www.diidy.com/client/positionDriver/%@"
#define CHANGEPASSWORD @"http://www.diidy.com/client/changepwd/%@/%@/%@"
#define FEEDBACK @"http://www.diidy.com/client/feedback/%@/%@"


#define REQUEST_COMPLETE  @"RequestComplete"
#define MORE_QUEST  @"MoreRequestComplete"

#define NOMESSAGE @"您当前没有滴滴优惠劵，请随时关注滴滴优惠信息。不要错过哦~"
#define MESSAGE @"滴滴优惠劵每次服务限用一张,不找零,不可兑换现金。"
#define ORDERPROMPT @"您还没有使用过滴滴代驾，所以没有订单可查看哦。                        预约滴滴代驾，可以返回首页选择“找代驾”功能";
#define YINSET 5.0 
#endif
