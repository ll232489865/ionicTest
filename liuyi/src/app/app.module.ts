import { NgModule, ErrorHandler } from '@angular/core';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { Storage } from '@ionic/storage';

import { MyApp } from './app.component';
import { AboutPage } from '../pages/about/about';

import { TabsPage } from '../pages/tabs/tabs';
import { NewsPage } from '../pages/news/news';

//news
import { NewsDetail } from '../pages/news/newsDetail';
import { BPages} from '../pages/news/bannerpages';

import { UpdatePage } from '../pages/update/update';
//查询
import { QueryPage } from '../pages/update/query/query';
import { ActivityQuery } from '../pages/update/query/activity/activity-query';
import { ScorePage } from '../pages/update/query/score/score';
//成绩添加
import { ScoreAdd } from '../pages/update/score/score-add';
//活动添加
import { ActivityPage } from '../pages/update/activity/activity';
import { ActivityType } from '../pages/update/activity/type/activity-type';
import { CustomItem } from '../pages/update/activity/custom/custom-item'; 

import { ShowPage } from '../pages/show/show';

//我的
import { MinePage } from '../pages/mine/mine';

import { LoginPage } from '../pages/mine/login/login';
import { MyAboutPage } from '../pages/mine/myaboutF/myabout';
import { MyAccountPage } from '../pages/mine/myaccountF/myaccount';
import { MyInfoPage } from '../pages/mine/myinfoF/myinfo';
import { MySettingPage } from '../pages/mine/mysettingF/mysetting';

import {LoginService} from '../providers/login.service/login.service'
import {MyinfoServer} from '../pages/mine/myinfoF/myinfoF.server'



import {AdPage } from '../pages/ad/ad';

import { TutorialPage } from '../pages/tutorial/tutorial';
import { UserData } from '../providers/user-data';
//shareMenu
import { ShareMenu } from '../pages/shareMenu/shareMenu';
//slides
import {Slide } from '../pages/slides/slide';

import {ActivitiesList } from '../pages/show/activitiesList/activitiesList';
import {HistoryCourse } from '../pages/show/histroyCourse/historyCourse';


@NgModule({
  declarations: [
    ScoreAdd,
    ScorePage,
    ActivityQuery,
    QueryPage,
    CustomItem,
    ActivityType,
    ActivityPage,
    AdPage,
    TutorialPage,
    MyApp,
    AboutPage,
    TabsPage,
    NewsPage,
    UpdatePage,
    ShowPage,

    MinePage,
    LoginPage,
    MyAboutPage,
    MyAccountPage,
    MyInfoPage,
    MySettingPage,
    NewsDetail,  
    ShareMenu,
    Slide,
    ActivitiesList,
    HistoryCourse,                                                                                                                                                              
    BPages

  ],
  imports: [
    IonicModule.forRoot(MyApp)
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    ScoreAdd,
    ScorePage,
    ActivityQuery,
    QueryPage,
    CustomItem,
    ActivityType,
    ActivityPage,
    AdPage,
    TutorialPage,
    MyApp,
    AboutPage,
    TabsPage,
    NewsPage,
    UpdatePage,
    ShowPage,

    MinePage,
    LoginPage,
    MyAboutPage,
    MyAccountPage,
    MyInfoPage,
    MySettingPage,
    NewsDetail,                                                                     ShareMenu,
    Slide,
    ActivitiesList,
    HistoryCourse,                                                                                            
    BPages
  ],
  providers: [{ provide: ErrorHandler, useClass: IonicErrorHandler }, 
  UserData,LoginService,MyinfoServer, Storage]
})
export class AppModule { }
