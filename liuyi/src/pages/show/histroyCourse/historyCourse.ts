import { Component } from '@angular/core';

import { NavController } from 'ionic-angular';
import { ActivitiesList } from '../activitiesList/activitiesList';
import * as echarts from 'echarts';
import { Profile } from './profile';

@Component({
  templateUrl: 'historyCourse.html'
})
export class HistoryCourse {

  constructor(public navCtrl: NavController) {

  }

  //基础定义
  courseName:string="礼"; //title,课程名称
  tabNameArr:Array<string>=["礼","|","乐","|","射","|","御","|","书","|","数"]; //tab,选择课程
  echartsXData:Array<string>=['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
  echartsYData:Array<any>;
  echartsYDataMax:any=100;

  echartsYDataLi:Array<any> = this.getScore();
  echartsYDataYue:Array<any>;
  echartsYDataShe:Array<any>;
  echartsYDataYu:Array<any>;
  echartsYDataShuFa:Array<any>;
  echartsYDataShuXue:Array<any>;

  echartsYDataArr:any=[this.echartsYDataLi,[],[]];

  echartsObject:any;  //定义echarts对象



  getScore():Array<number>{
    let scoreArr=[];
    for(let i=0; i<10; i++){
      let randomScore=Math.random()*100;
      scoreArr.push(randomScore);
    }

    return scoreArr;
  }

  ngOnInit() {
    this.echartsObject = echarts.init(document.getElementById("courseScore"));
    this.initHistoryScore(this.echartsXData,this.echartsYDataArr[0],this.echartsYDataMax);

    this.echartsObject.on('click',(parmas:any)=>{
      this.navCtrl.push(ActivitiesList,{
        courseId:1
      });
    });
  }

  //切换课程
  cutCourse(index):void {
    let _index = index%2;
    if(!_index){
      this.courseName=this.tabNameArr[index];
      this.echartsYData=this.getScore();
      this.initHistoryScore(this.echartsXData,this.echartsYData,this.echartsYDataMax);
    }

  };

  //绘制柱状图
  initHistoryScore(echartsXData:Array<any>,echartsYData:Array<any>,echartsYDataMax:any):void {

    //x轴数据
    let dataAxis = echartsXData;
    //y轴数据
    let data = echartsYData;
    //最大值
    let yMax = echartsYDataMax;
    let dataShadow = [];

    for (let i = 0; i < data.length; i++) {
      dataShadow.push(yMax);
    }

    let option = {
      tooltip: {},
      //表格相对于DOM的位置
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
      },
      xAxis: {
        data: dataAxis,
        axisTick: {
          show: false
        },
        axisLine: {
          show: false
        }
      },
      yAxis: {
        axisLine: {
          show: false
        },
        axisTick: {
          show: false
        },
        axisLabel: {
          textStyle: {
            color: 'red'
          }
        }
      },
      series: [
        {
          type: 'bar',
          name:"分数",
          itemStyle: {
            //条状阴影
            normal: {color: 'rgba(0,0,0,0.00)'}
          },
          barGap:'-100%',
          barCategoryGap:'40%',  //控制条状的粗细,0-100%(粗->细)
          data: dataShadow,
          animation: false
        },
        {
          type: 'bar',
          itemStyle: {
            //初始色彩
            normal: {
              color: new echarts.graphic.LinearGradient(
                0, 0, 0, 1,
                [
                  {offset: 0, color: 'red'},
                  {offset: 0.5, color: '#188df0'},
                  {offset: 1, color: '#188df0'}
                ]
              )
            },
            //点击之后的色彩
            emphasis: {
              color: new echarts.graphic.LinearGradient(
                0, 0, 0, 1,
                [
                  {offset: 0, color: 'yellow'},
                  {offset: 0.7, color: '#2378f7'},
                  {offset: 1, color: '#83bff6'}
                ]
              )
            }
          },
          data: data
        }
      ]
    };

    //绘制
    this.echartsObject.setOption(option);

  };

  //点击事件,回调函数
  // this.echartsObject.on('click',function (parmas) {
  //   alert(this==this.that);
  //   // this.navCtrl.push(ActivitiesList,{
  // //   courseId:1
  // // });
  // });

}
