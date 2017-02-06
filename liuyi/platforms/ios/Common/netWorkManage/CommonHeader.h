//
//  CommonHeader.h
//  SoftWay
//
//  Created by 任雷 on 16/3/9.
//  Copyright © 2016年 lianghuigui. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h

#define Common_User_Query @"/user/query"//获取个人信息

#define Common_Logout @"/logout" //退出登录

#define Common_SchoolList @"/school/list"//学校列表

#define Common_ConditionSbjct @"/conditionsbjct/list"//科目选项

#define Common_Class_NoticeList @"/notice/list"//公告列表 GET

#define Common_Class_AidShareList  @"/aid/share/list"//班级中 老师分享的 资料 列表  GET

#define Common_Class_AidFavList  @"/aid/fav/list"//学生自己收藏的 资料 列表  GET

#define Common_Class_AidFavAdd  @"/aid/fav/add"//添加收藏 讲义 POST

#define Common_Class_AidFavDelete  @"/aid/fav/delete"//取消收藏 讲义 POST

#define Common_Class_QuestionList @"/question/list"//提问 列表 GET

#define Common_Class_QuestionDetail @"/question/detail"//提问 列表 点击详情  GET

#define Common_Class_TypicalList @"/typicalfaq/shared/list"//典题 列表 GET

#define Common_Class_TypicalDetail @"/typicalfaq/shared/detail"//典题 列表 点击详情 GET


#define Common_Class_2DBarcode @"/class/share"//二维码 分享

#define Common_UpGrade_Info @"/upgrade/info"//检测 App升级

#define Common_GetWaterMark @"/api/common/getWaterMark"// 登录后获取水印 GET


#endif /* CommonHeader_h */