import { Injectable } from '@angular/core';
import { Http, URLSearchParams ,RequestOptions,Headers} from '@angular/http';
import 'rxjs/add/observable/of';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/delay';

import 'rxjs/add/operator/toPromise';

import { Storage } from '@ionic/storage'


//model
import { LoginHandshakeModel, model_loginResult } from './login.model'
//plugin
import { Device, Istudy,Qiniu } from 'ionic-native';


@Injectable()
export class LoginService {
  
  private Url_handshake = 'http://192.168.1.10:9090/zuting_api/handshake';
  private Url_login = 'http://192.168.1.10:9090/zuting_api/login';
  private Url_accountInfo = 'http://192.168.1.10:9090/zuting_api/account/info';
  //	accountInfo:{url:env.apiURL + '/account/info',type:"get",path:'/account/info'},

  isLoggedIn: boolean = false;

  model_handshake: LoginHandshakeModel;
  constructor(
    private http: Http,
    public storage: Storage
  ) { }

  //登录
  login(account, passwordv, callBack) {
    var str_random = Math.random().toString();

    this.handshakeRequest(str_random)
      .then(model => {
        this.model_handshake = model;
        //greeting:'clientGreeting+&+serverGreeting
        var verifyParams = { serverGreeting: str_random + "&" + this.model_handshake.serverGreeting, serverSign: this.model_handshake.serverSign };

        Istudy.verify(verifyParams).then(succ => {

          if (succ) {//验签通过
            var str_handshakeCodeRandom = Math.random().toString();

            var str_handshakeparams = this.model_handshake.serverGreeting + "&" + str_handshakeCodeRandom;

            Istudy.encrypt(str_handshakeparams)
              .then(result => {//handshakeCode

                this.storage.get("DEVICE_ID")
                  .then((val) => {//DEVICE_ID                    
                    Istudy.generateMd5(passwordv)
                      .then(passwordMd5 => {
                        var passwordCode = passwordMd5 + "&" + this.model_handshake.serverGreeting;

                        Istudy.encrypt(passwordCode)
                          .then(pass => {//password

                            var params = "mobile=" + account + "&password=" + encodeURIComponent(pass) + "&handshakeCode=" + encodeURIComponent(result) + "&appSrc=" + "STUDENT" + "&deviceID=" + val;

                            let headers = new Headers({ 'Content-Type': 'application/x-www-form-urlencoded' });
                            let options = new RequestOptions({ headers: headers });

                            this.http.post(this.Url_login, params, options)
                              .toPromise()
                              .then(res => {//登录成功

                                if (res.json().resultCode == 0) {
                                  this.isLoggedIn = true;
                                  callBack(res.json().result as model_loginResult);

                                } else {
                                  console.log(res.json().resultCode);
                                }
                              })
                              .catch(this.handleError);
                          });
                      });
                  });
              });
          }
        });
      });
  }

  //获取 handshake
  handshakeRequest(str_random): Promise<LoginHandshakeModel> {
    let params = new URLSearchParams();
    params.set("greeting", str_random);

    return this.http.get(this.Url_handshake, { search: params })
      .toPromise()
      .then(
      response =>
        // {
        //console.log(JSON.stringify(response.json()));
        (response.json().result as LoginHandshakeModel)
      // }
      )
      .catch(this.handleError);
  }

  //获取 用户信息
  getAccountInfo(callBack) {
        this.getSession().then(session => {  
        console.log("session" + JSON.stringify(session));

        if (session) {
          Istudy.getHeader({ session: session, path: "/account/info", headers: {}, params: {} })
            .then(head => {

              let headers = new Headers({ 'Content-Type': 'application/x-www-form-urlencoded' });
              let options = new RequestOptions({ headers: head });

              this.http.get(this.Url_accountInfo, options)
                .toPromise()
                .then(result => {
                  callBack(result.json().result)
                })
                .catch(this.handleError);

            })
        }
      });
  }

  //获取 session 登录后的信息  请求头
  getSession(): Promise<any> {
    return this.storage.get("SESSION")
      .then(result => {
        return result;
      });
  }


  //登出
  logout(): void {
    this.isLoggedIn = false;
    this.storage.remove("SESSION");
    this.storage.remove("INFO_ID");//个人信息
  }



  private handleError(error: any): Promise<any> {
    console.error('An error occurred', error);
    return Promise.reject(error.message || error);
  }

}



/*
Copyright 2016 Google Inc. All Rights Reserved.
Use of this source code is governed by an MIT-style license that
can be found in the LICENSE file at http://angular.io/license
*/