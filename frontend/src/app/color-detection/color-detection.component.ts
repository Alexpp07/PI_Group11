import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { interval, Subscription} from 'rxjs';

@Component({
  selector: 'app-color-detection',
  templateUrl: './color-detection.component.html',
  styleUrls: ['./color-detection.component.css']
})
export class ColorDetectionComponent implements OnInit {
  isImageSaved: boolean = false;
  imageUrl: string = "";
  mySubscription: Subscription
  constructor(private http: HttpClient) {
    this.mySubscription= interval(30).subscribe((x =>{
      this.ngOnInit();
  }));
  }
  ngOnInit() {
    this.http.get<any>('http://127.0.0.1:5000/color_detection?rectangles=4&colorR=75&colorG=90&colorB=32&threshold=15').subscribe(data => {
      let imageBase64String = data.data;
      imageBase64String = imageBase64String.slice(2);
      imageBase64String = imageBase64String.slice(0, -1);
      this.imageUrl = 'data:image/png;base64,' + imageBase64String;
    console.log(this.imageUrl)})
  }
}
