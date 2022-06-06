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
  constructor(private http: HttpClient) {
    this.mySubscription= interval(1).subscribe((x =>{
      this.ngOnInit();
  }));
  }
  ngOnInit() {
    this.http.get<any>('http://127.0.0.1:5000/eye_tracking?rectangles=4').subscribe(data => {
      let imageBase64String = data.data;
      imageBase64String = imageBase64String.slice(2);
      imageBase64String = imageBase64String.slice(0, -1);
      this.imageUrl = 'data:image/png;base64,' + imageBase64String;
    console.log(this.imageUrl)})
  }
}