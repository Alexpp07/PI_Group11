import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { interval, Subscription} from 'rxjs';

@Component({
  selector: 'app-motion-detection',
  templateUrl: './motion-detection.component.html',
  styleUrls: ['./motion-detection.component.css']
})
export class MotionDetectionComponent implements OnInit {
    isImageSaved: boolean = false;
    imageUrl: string = "";
    mySubscription: Subscription

    items: any[] = [
      { id: 1, name: '4' },
      { id: 2, name: '8' },
      { id: 3, name: '12' },
      { id: 4, name: '16' },
    ];
    selected: number = 1;


    constructor(private http: HttpClient) {
      this.mySubscription= interval(30).subscribe((x =>{
        this.ngOnInit();
      }));
    }

    ngOnInit() {
      this.http.get<any>('http://127.0.0.1:5000/movement_detection?rectangles=4').subscribe(data => {
        let imageBase64String = data.data;
        imageBase64String = imageBase64String.slice(2);
        imageBase64String = imageBase64String.slice(0, -1);
        this.imageUrl = 'data:image/png;base64,' + imageBase64String;
      console.log(this.imageUrl)})
    }

  
  
  selectOption(id: number) {
    console.log(id);
    console.log(this.selected)
  }

}
