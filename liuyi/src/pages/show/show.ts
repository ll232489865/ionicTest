import { Component ,ViewChild,ViewEncapsulation} from '@angular/core';
import { Content,ActionSheetController ,Platform,MenuController,PopoverController,ModalController,NavController,App} from 'ionic-angular';
import {Http} from '@angular/http';
import { ShareMenu } from '../shareMenu/shareMenu';
import { Slide } from '../slides/slide';
import { HistoryCourse } from './histroyCourse/historyCourse';
import echarts from 'echarts'; 

import 'rxjs/add/operator/toPromise';

@Component({
  selector: 'page-show',
  templateUrl: 'show.html',
  encapsulation: ViewEncapsulation.None,
  styleUrls: [ 'assets/css/show.css']
})
export class ShowPage {
  @ViewChild(Content) content: Content;
    constructor(
        public navCtrl: NavController,
        private http: Http,
        public actionSheetCtrl: ActionSheetController,
        public platform: Platform,
        public menu: MenuController,
        public popoverCtrl: PopoverController,
        public mcon : ModalController,
        public app :App
        ) 
        {
            menu.enable(true);
        }
  historycourse = HistoryCourse
  data=[
      {item:'礼',score:'75',bearing:0},
      {item:'乐',score:'80',bearing:0},
      {item:'射',score:'75',bearing:1},
      {item:'御',score:'60',bearing:1},
      {item:'礼',score:'90',bearing:1},
      {item:'数',score:'85',bearing:0},
    ]
  root: any = ShareMenu;
  quanFlag = false;
  propagateUrl = 'http://192.168.1.10:9090/zuting_api/live/public/list';
  goCHatUi(){
    this.content.scrollTo(0,1000,2000,()=> console.log(123));
    console.log(this.content.contentBottom)
  }
  ngOnInit(){
    let myChart = echarts.init(document.getElementById('radar'));
    myChart.setOption({
        title: {
            text: '六艺技能展示',
            textAlign: 'left',
            textStyle:{
                color:'#fff'
            },
            show:false

        },
        tooltip: {},
        // legend: {
        //     data: ['来到想学就学之前'],
        //     right:'right'
        // },
        radar: {
            // shape: 'circle',
            indicator: [
              { name: '礼', max: 100},
              { name: '乐', max: 100},
              { name: '射', max: 100},
              { name: '御', max: 100},
              { name: '书', max: 100},
              { name: '数', max: 100}
            ]
            ,
            splitNumber:6
            ,
            splitLine : false
            ,
            axisLine : {
                lineStyle: {
                    color:'rgba(255,255,255,.1)'
                }
            }
            ,
            splitArea: {
                    areaStyle: {
                        color: [
                            'rgba(255,255,255,.54)',
                            'rgba(255,255,255,.5)',
                            'rgba(255,255,255,.45)',
                            'rgba(255,255,255,.3)',
                            'rgba(255,255,255,.2)',
                            'rgba(255,255,255,.1)'
                        ],
                        shadowColor: 'rgba(255, 255, 255, 1)',
                        shadowBlur: 20
                    }
                }

        },
         
        name:{
            textStyle: {
                color:'#fff'
            }
            ,
            formatter: ''
        }
        ,
        series: [{
            name: '预算 vs 开销（Budget vs spending）',
            type: 'radar',
            // areaStyle: {normal: {}},
            data : [
                {
                    value : [70, 85, 70, 60, 90, 85],
                    name : '我的六艺成绩'
                }
            ]
            ,
            inlineStyle :{
                normal : {
                    color:"#666",
                    opacity:1
                }
            }
        }]
        ,
        color:['#fff']
    });
    document.getElementById('radar').style.height = myChart.getHeight() + 'px';
    myChart.showLoading();
    
    
    this.getPropagates(myChart);
    let fragment = document.createDocumentFragment();
    let item;
    for(let i = 0 ; i < 6 ;  i++){
        // item = document.createElement('img');
        // item.src = "assets/img/icon-0"+(i+1)+".png";
        item = document.createElement('span');
        if(!this.data[i].bearing){
            item.innerHTML = "<img src='assets/img/icon-0"+(i+1)+".png'><span class='btn btn_opa1 btn_low transform_top'>"+this.data[i].item +" :"+this.data[i].score+"</span>"
        }else{
          item.innerHTML = "<img src='assets/img/icon-0"+(i+1)+".png'><span class='btn btn_opa1 btn_low transform_bottom'>"+this.data[i].item +" :"+this.data[i].score+"</span>"
        }
        
        item.className = 'quan'
        item.id = 'quan-'+i;
        fragment.appendChild(item)
        item.onclick = (e) => {
          console.log(this.mcon);
        let  profileModal = this.mcon.create(Slide, { id: i },{
              // enterAnimation: 'modal-fade-out',
              // leaveAnimation: 'modal-fade-in'
          });
          profileModal.present();
        }

    }
    document.getElementById('radar').appendChild(fragment);
    setTimeout(()=>{this.setSpanPosition(myChart)},1000) 
  }
  presentProfileModal() {
   let profileModal = this.mcon.create(ShareMenu, { userId: 8675309 },{
      //  enterAnimation: 'modal-fade-out',
      //  leaveAnimation: 'modal-fade-in'
   });
   profileModal.present();
 }
  toggleLeftMenu() {
        this.menu.toggle();
    }
  setSpanPosition(Cr){
    document.getElementById('radar').classList.add('trans');
    let radarHeight_1 = Cr.getHeight() * 0.13 ;
    let radarHeight_2 = Cr.getHeight() * 0.31 ;
    let radarHeight_3 = Cr.getHeight() * 0.69 ;
    let radarHeight_4 = Cr.getHeight() * 0.87 ;
    var spanObj = document.querySelectorAll('.quan');
    for(let i=0,len =spanObj.length; i<len; i++){
      switch(i)
      {
      case 0:
        spanObj[i].setAttribute('style',"top:" + (radarHeight_1 - 30) + "px");
        break;
      case 1:
        spanObj[i].setAttribute('style',"top:" + (radarHeight_2) + "px;left:10px");
        break;
      case 2:
        spanObj[i].setAttribute('style',"top:" + (radarHeight_3) + "px;left:10px");
        break;
      case 3:
        spanObj[i].setAttribute('style',"top:" + (radarHeight_4 + 30) + "px");
        break;
      case 4:
        spanObj[i].setAttribute('style',"top:" + (radarHeight_3) + "px;right:"+15+"px;");
        break;
      case 5:
        spanObj[i].setAttribute('style',"top:" + (radarHeight_2) + "px;right:"+15+"px;");
        break;
      default:
        break;
      }
    }
  }
  historyCourse(){
    //  this.navCtrl.push(HistoryCourse)
     this.app.getRootNav().push(HistoryCourse);
    //  this.appCtrl.getRootNav().push(SecondPage);
  }
  getPropagates(ec): Promise<any []> {
    return this.http.get(this.propagateUrl)
            .toPromise()
            .then(response => { 
                setTimeout(function() {
                    ec.hideLoading();
                }, 1000);
                return response.json().result}
            );
    }
}

