import { Component, OnInit } from '@angular/core';
import { ActionSheetController } from 'ionic-angular';
import { Camera, ImagePicker } from 'ionic-native';

import { Storage } from '@ionic/storage';

import { MyinfoServer } from './myinfoF.server';
@Component({
  selector: 'my-component',
  templateUrl: 'myinfo.html'
})
export class MyInfoPage implements OnInit {
  public base64Image: string;
  loadImage:string;
  loadNickName:string;


  constructor(
    public myinfoserver: MyinfoServer,
    public actionsheetCtrl: ActionSheetController,
    public storage: Storage,
  ) { }
  //上传图片
  uploadImage() {

    let actionSheet = this.actionsheetCtrl.create({
      title: '修改头像',
      cssClass: 'action-sheets-basic-page',
      buttons: [
        {
          text: '相机',
          role: 'Camera',
          handler: () => {
            // alert("点击相机");

            Camera.getPicture({
              quality: 75,
              destinationType: Camera.DestinationType.FILE_URI,
              sourceType: Camera.PictureSourceType.CAMERA,
              allowEdit: false,//可编辑
              encodingType: Camera.EncodingType.JPEG,
              targetWidth: 300,
              targetHeight: 300,
              saveToPhotoAlbum: false
            }).then((fileUrl) => {
              this.myinfoserver.qiniuImage(fileUrl, (results) => {
                this.loadImage = results;
              });

              // alert(fileUrl);                
            }, (err) => {
              // Handle error
              alert("ERROR -> " + JSON.stringify(err));
            });

          }
        },
        {
          text: '从手机相册选择',
          //   icon: !this.platform.is('ios') ? 'share' : null,
          handler: () => {
            // alert("选择图片");
            ImagePicker.getPictures({}).then((results) => {
              // for (var i = 0; i < results.length; i++) {
              //     console.log('Image URI: ' + results[i]);
              //     alert('Image URI: ' + results[i]);
              // }
              // this.myinfoserver.qiniuImage(results[0],this.Callback);


              this.myinfoserver.qiniuImage(results[0], (results) => {
                this.loadImage = results;
              });
            }, (err) => {
              alert("errrrrr选择图片失败");
            });


          }
        },
        {
          text: '取消',
          role: 'cancel', // will always sort to be on the bottom
          handler: () => {
          }
        }
      ]
    });
    actionSheet.present();
  }


  ngOnInit(): void {

    this.storage.get("INFO_ID").then(result => {

      if (result) {
        this.loadImage = result.avatar ? result.avatar : "assets/source/img/logo.png";
        this.loadNickName=result.nicknm;

      } else {
        this.loadImage = "assets/source/img/logo.png";
      }
    })

  }


}