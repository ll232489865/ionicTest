import { Component } from '@angular/core';

import { App, MenuController ,ViewController} from 'ionic-angular';


@Component({
  template: `
  <div style="background:rgba(0,0,0,.5); height:100%" (click) ="dismiss($event)" >
    <div style="width:100%; background:#fff; shadow:0 0 10px rgba(0,0,0,.5); position:absolute; bottom:0; left:0;" (click) = "stopPropagation($event)">
        <ion-grid>
            <ion-row style="text-align: center">
                <ion-col width-1>
                    <div style="padding:15px 10px; border-bottom:1px solid #ddd; font-size:20px; color:#999" class="fzsy">
                        分享我的六艺成绩
                    </div>
                    
                </ion-col>
            </ion-row>
            <ion-row style="text-align: center; padding:15px 0 20px;">
                <ion-col width-3>
                    <span style="width:3em; height:3em; border-radius:1.5em; margin-bottom:5px; display:inline-block; text-align:center; line-height:3em; background:#738790">
                        <span class="icon-wechat" style="color:rgba(255,255,255,.8); font-size:2em"></span>
                    </span> 
                    <br>
                    <span style="color:#999">微信</span>
                </ion-col>
                <ion-col width-3>
                    <span style="width:3em; height:3em; border-radius:1.5em;  margin-bottom:5px; display:inline-block;text-align:center; line-height:3em; background:#A4D349">
                        <span class="icon-friend" style="color:rgba(255,255,255,.8); font-size:2em"></span>
                    </span> 
                    <br>
                    <span style="color:#999">朋友圈</span>
                </ion-col>
                <ion-col width-3>
                    <span style="width:3em; height:3em; border-radius:1.5em; margin-bottom:5px; display:inline-block; text-align:center; line-height:3em; background:#87B7E7">
                        <span class="icon-qq" style="color:rgba(255,255,255,.8); font-size:2em"></span>
                    </span>
                    <br>
                    <span style="color:#999">QQ</span>
                </ion-col>
            </ion-row>
        </ion-grid>
    </div>   
  </div>
`
})
export class ShareMenu {
  constructor(app: App, menu: MenuController,public viewcon: ViewController) {
    menu.enable(true);
  }
  dismiss(e){
      this.viewcon.dismiss();
  }
  stopPropagation(e){
      e.stopPropagation();
  }
}
