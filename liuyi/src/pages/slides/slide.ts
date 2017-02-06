import { Component } from '@angular/core';
import { TutorialPage } from '../tutorial/tutorial';
import { MenuController ,ViewController} from 'ionic-angular';


@Component({
  selector: 'component-slide',
  templateUrl: 'slide.html'
})
export class Slide {
  constructor(menu: MenuController,public viewcon: ViewController) {
  }
  number = this.viewcon.getNavParams().data.id;
  options= {
    initialSlide : this.number,
    pager:true
  }
  slides = [
    {
      title: "六艺之一'礼'",
      description: "关于'礼'...",
      image: "assets/img/01.png",
    },
    {
      title: "六艺之一'乐'",
      description: "关于'乐'...",
      image: "assets/img/02.png",
    },
    {
      title: "六艺之一'射'",
      description: "关于'射'...",
      image: "assets/img/03.png",
    },
    {
      title: "六艺之一'御'",
      description: "关于'御'...",
      image: "assets/img/04.png",
    },
    {
      title: "六艺之一'书'",
      description: "关于'书'...关于'书'...关于'书'...关于'书'...关于'书'...关于'书'...关于'书'...关于'书'...",
      image: "assets/img/05.png",
    },
    {
      title: "六艺之一'数'",
      description: "关于'数'...",
      image: "assets/img/06.png",
    }
  ];
  dismiss(e){
      this.viewcon.dismiss();
  }
  stopPropagation(e){
      e.stopPropagation();
  }
  historyCourse(){
    
  }
  ngOnInit(){
    // this.number = this.viewcon.getNavParams().data.id;
  }
}
