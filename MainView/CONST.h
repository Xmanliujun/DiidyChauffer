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

#define UMENG_APPKEY @"504efb8e527015190b0002a2"
#define LAND @"http://www.diidy.com/client/logon/%@/%@/%@/%@/1/%f/%@"
#define REGISTER  @"http://www.diidy.com/client/check/%@/register"
#define PASSWORD @"http://www.diidy.com/client/check/%@/password"
#define SETUP @"http://www.diidy.com/client/confirm/%@/%@/%@/%@/%@/%@/%@/1/%f/%@"
#define REGAIN @"http://www.diidy.com/client/getAuthcode/%@"
#define COUPON @"http://www.diidy.com/client/getCoupon/%@"
#define GIFTCOUPONS @"http://www.diidy.com/client/giveCoupon/%@/%@/%@"
#define ORDERNUMBER @"http://www.diidy.com/client/orderlist/%@"
#define ORDERNUMBERSTARTTIME @"http://www.diidy.com/client/orderlist/%@/%@"
#define BILLINGDETAIL @"http://www.diidy.com/client/orderdetail/%@"
#define EXECORDERS @"http://www.diidy.com/client/ordering/%@"
#define POSITIONDRIVER @"http://www.diidy.com/client/positionDriver/%@"
#define CHANGEPASSWORD @"http://www.diidy.com/client/changepwd/%@/%@/%@"
#define FEEDBACK @"http://www.diidy.com/client/feedback/%@/%@"
#define SUBMITORDERS @"http://www.diidy.com/client/commitorder/%@/%@/%@/%@/%@/%@/%@/%@"

#define REQUEST_COMPLETE  @"RequestComplete"
#define MORE_QUEST  @"MoreRequestComplete"

#define NOMESSAGE @"您当前没有嘀嘀优惠劵，请随时关注嘀嘀优惠信息。不要错过哦~"
#define MESSAGE @"嘀嘀优惠劵每次服务限用一张,不找零,不可兑换现金。"
#define ORDERPROMPT @"您还没有使用过嘀嘀代驾，所以没有订单可查看哦。 预约嘀嘀代驾，可以返回首页选择“找代驾”功能";
#define STUDENTCARD @"孩子上学需要天天接送？有车没时间！交给嘀嘀来办吧！嘀嘀为家长定制了学生接送卡，挑选可靠司机，接受家长面试。分为月卡和学期卡\n       类型                           |金额\n学生接送卡(月卡)              |2000\n学生接送卡(学期卡)           |8000\n学生接送卡限北京市范围内每日接送各一次，里程在30km以内，超出30km加收20%；\n可以在线购买(支付宝、网上银行)，可转账汇款，还能拨打4006960666预约上门办卡！\n驾驶员不能单独驾驶您的车辆，将孩子送达学校后，钥匙交给孩子保管，放学后，安全将孩子接回家；\n本价格仅限1名学生接送。如学生住址和学校地址一致，每增加一名学生加收800元/月或3000/学期；\n本卡不退不换，不可做其他用途"
#define REGISTERCARD @"下载嘀嘀代驾客户端，注册成功即送5张优惠劵，每张价值十元；\n每次使用嘀嘀代驾服务可用一张，不找零，不兑换现金，不与其他优惠劵同时使用；\n每位客户只获赠一次。"
#define HUNDREDYUAN  @"百元双次卡只通过网站在线购买，只需100元即可获价值300元的两张代金卷。\n代金卷每张150元，每次服务可用一张，不找零，不累计，不足部分需不足。\n150元什么概念？最贵的计价时段--深夜12点之后开一个小时.\n12点之后一小时能开多远？您知道。\n百元双次卡，每人只限购买一张。"
#define ENJOYCARD @"办理畅享卡之后，使用嘀嘀代驾服务只需签字，真正享受私人司机服务。\n拨打4006960666预约服务时，系统自动识别身份，直接享受打折优惠。\n预存/续存不同额度享受相应折扣。\n最低预存额度|最低续存额度|折扣\n       2000       |      1000       |  90\n       5000       |      2500       |  85\n       8000       |      4000       |  80\n可在线充值购买，可转账汇款，还能拨打4006960666预约上门办卡！"
#define PREFERRNTIAL @"活动有效期2012年8月8日到9月8日；\n第一次使用客户端成功预约，就可享受白天\n(6:00-18:00)一小时免费，夜间(18:00-6:00)半小时免费代驾服务；\n半小时什么概念？对于大部分用户，半小时，足！够！到！家！啦！\n1、超出时限部分需按嘀嘀代驾标准收费补足，标准收费请参照客户端首页：\n2、出发地或目的地在五环外，另外各加收20元；出发地或目的地在六环外，另外各加收50元；\n3、请尽量在出发时间前30分钟预约，司机等候时间同样计时哦；\n4、每个手机号码仅在第一次通过客户端预约代驾时享有此优惠，仅限一次，且不与其他优惠同时使用哦！"
#define YINSET 5.0 

#define DOWNLOAD_TYPE_ASI 1
#define DOWNLOAD_TYPE_CON 2

#define PARSE_TYPE_GDATA 1
#define PARSE_TYPE_NSPARSE 2

#define DATABASE_TYPE_C 1
#define DATABASE_TYPE_FMDB 2

#endif
