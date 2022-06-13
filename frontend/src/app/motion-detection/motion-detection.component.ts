import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { interval, Subscription} from 'rxjs';
import {MatButtonModule} from '@angular/material/button';

@Component({
  selector: 'app-motion-detection',
  templateUrl: './motion-detection.component.html',
  styleUrls: ['./motion-detection.component.css']
})
export class MotionDetectionComponent implements OnInit {
    isImageSaved: boolean = false;
    imageUrl: string = "";
    mySubscription: Subscription
    rectangles = "4";
    setRect = "0";
    numberArray: number[] = [];
    link = "http://127.0.0.1:5000/movement_detection?rectangles=";

    constructor(private http: HttpClient) {
      this.mySubscription= interval(80).subscribe((x =>{
        this.getVideoFeed();
      }));
      for (let i = 0; i < 17; i++) {
        this.numberArray.push(i);
      }
    }

    ngOnInit() {
      this.getVideoFeed();
    }

    ngOnDestroy() {
      this.mySubscription.unsubscribe()
    }
    
    getVideoFeed() {
      this.link = "http://127.0.0.1:5000/movement_detection?rectangles=".concat(this.rectangles)
      this.http.get<any>(this.link).subscribe(data => {
        let imageBase64String = data.data;
        imageBase64String = imageBase64String.slice(2);
        imageBase64String = imageBase64String.slice(0, -1);
        this.imageUrl = 'data:image/png;base64,' + imageBase64String;})
    }

    attachSound() {
      const headers = { "Content-Type": "application/json" };
      const body = {"rectangle": 3, "sound": "teddybear"}
      this.link = "http://127.0.0.1:5000/square?rectangle=3&sound=teddybear"
      this.http.post<any>(this.link, body, { headers }).subscribe(data => {
        console.log(data)
      })
    }
}
