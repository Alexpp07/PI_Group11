import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

export class AppComponent implements OnInit{
  isImageSaved: boolean = false;
  imageUrl: string = "";
  constructor(private http: HttpClient) {
  }
  ngOnInit() {
    this.http.get<any>('http://127.0.0.1:5000/movement_detection').subscribe(data => {
      let imageBinary = data.data; //image binary data response from api
      let imageBase64String= btoa(imageBinary);
      this.imageUrl = 'data:image/jpeg;base64,' + imageBase64String;
    console.log(this.imageUrl)})
  }
}

