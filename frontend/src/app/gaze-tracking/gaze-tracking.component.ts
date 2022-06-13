import {Component, OnInit} from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { interval, Subscription} from 'rxjs';


@Component({
  selector: 'app-root',
  templateUrl: './gaze-tracking.component.html',
  styleUrls: ['./gaze-tracking.component.scss']
})

export class GazeTrackingComponent implements OnInit {
  isImageSaved: boolean = false;
  imageUrl: string = "";
  mySubscription: Subscription
  rectangles = "4";
  link = "";
  constructor(private http: HttpClient) {
    this.mySubscription= interval(80).subscribe((x =>{
      this.getVideoFeed();
    }));
  }

  ngOnInit() {
    this.getVideoFeed();
  }
  
  ngOnDestroy() {
    this.mySubscription.unsubscribe();
  }

  getVideoFeed() {
    this.link = 'http://127.0.0.1:5000/eye_tracking?rectangles='.concat(this.rectangles);
    this.http.get<any>(this.link).subscribe(data => {
      let imageBase64String = data.data;
      imageBase64String = imageBase64String.slice(2);
      imageBase64String = imageBase64String.slice(0, -1);
      this.imageUrl = 'data:image/png;base64,' + imageBase64String;
    console.log(this.imageUrl)})
  }
}