import { Component } from '@angular/core';

import { NavController, ToastController } from 'ionic-angular';

@Component({
  templateUrl: 'activitiesList.html'
})
export class ActivitiesList {

  constructor(public navCtrl: NavController, public toastCtrl: ToastController) {

  }

  tabNameArr:Array<string>=["礼","|","乐","|","射","|","御","|","书","|","数"]; //tab,选择课程

  activityArr:Array<any>;

  ngOnInit(){
    this.activityArr=[
      {
        course:{
          courseName:"数学",
          courseScore:150,
          courseTime:"2010/7/30"
        },
        active:{
          activeName:"AI VS 人类 围棋大赛",
          activeScore:"∞",
          activeTime:"2010/9/1"
        }
      },
      {
        course:{
          courseName:"语文",
          courseScore:150,
          courseTime:"2011/7/30"
        },
        active:{
          activeName:"NBA挑战赛",
          activeScore:"∞",
          activeTime:"2011/9/1"
        }
      },
      {
        course:{
          courseName:"物理",
          courseScore:150,
          courseTime:"2012/7/30"
        },
        active:{
          activeName:"LOL世界总决赛",
          activeScore:"∞",
          activeTime:"2012/9/1"
        }
      },
      {
        course:{
          courseName:"化学",
          courseScore:150,
          courseTime:"2013/7/30"
        },
        active:{
          activeName:"LOL S7",
          activeScore:"∞",
          activeTime:"2013/9/1"
        }
      }
    ];
  }

  //切换课程
  cutCourse(index):void {
    let _index = index%2;
    if(!_index){
      let toast = this.toastCtrl.create({
        message: '该科目数据暂未填充',
        duration: 2000,
        position: 'top'
      });

      toast.present(toast);
    }
  };

}
