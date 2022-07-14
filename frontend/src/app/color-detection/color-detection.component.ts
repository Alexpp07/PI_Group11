import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { interval, Subscription} from 'rxjs';
import { Color, ColorPickerControl } from '@iplab/ngx-color-picker';
import RecordRTC from 'recordrtc';
import { DomSanitizer } from '@angular/platform-browser';

@Component({
  selector: 'app-color-detection',
  templateUrl: './color-detection.component.html',
  styleUrls: ['./color-detection.component.css']
})
export class ColorDetectionComponent implements OnInit {
  isImageSaved: boolean = false;
  imageUrl: string = "";
  mySubscription1: Subscription
  mySubscription2: Subscription
  wholeColor = ["0", "0", "0"]
  rectangles = "4";
  colorR = "0";
  colorG = "0";
  colorB = "0";
  threshold = "1";
  link = "";
  setRect = "";

  numberArray: number[] = [];

  chromeControl = new ColorPickerControl().hidePresets().hideAlphaChannel();

  constructor(private http: HttpClient, private domSanitizer: DomSanitizer) {
    this.mySubscription1 = interval(80).subscribe((x =>{
      this.getVideoFeed();
      }));
    this.mySubscription2= this.chromeControl.valueChanges.subscribe((x =>{
      this.wholeColor = this.chromeControl.value.toRgbString().slice(4, -1).split(",");
      this.colorR = this.wholeColor[0].trim();
      this.colorG = this.wholeColor[1].trim();
      this.colorB = this.wholeColor[2].trim();
    }));
    for (let i = 0; i < 256; i++) {
      this.numberArray.push(i);
    }
  }

  ngOnInit() {
    this.getVideoFeed();
  }

  ngOnDestroy() {
    this.mySubscription1.unsubscribe()
    this.mySubscription2.unsubscribe()
  }

  getVideoFeed() {
    this.link = 'http://127.0.0.1:5000/color_detection?rectangles='.concat(this.rectangles, '&colorR=', this.colorR, '&colorG=', this.colorG, '&colorB=', this.colorB, '&threshold=', this.threshold);
    this.http.get<any>(this.link).subscribe(data => {
      let imageBase64String = data.data;
      imageBase64String = imageBase64String.slice(2);
      imageBase64String = imageBase64String.slice(0, -1);
      this.imageUrl = 'data:image/png;base64,' + imageBase64String;
    console.log(this.link)})
  }

  attachSound() {
    const headers = { "Content-Type": "application/json" };
    const body = {"rectangle": this.setRect, "sound": "teddybear"}
    this.link = "http://127.0.0.1:5000/square?rectangle=3&sound=teddybear"
    this.http.post<any>(this.link, body, { headers }).subscribe(data => {
      console.log(data)
    })
  }

  record: any;

  recording = false;

  url: any;
  error: any;
  sanitize(url:string){
      return this.domSanitizer.bypassSecurityTrustUrl(url);
  }

  /**
   * Start recording.
   */
  initiateRecording() {
      
      this.recording = true;
      let mediaConstraints = {
          video: false,
          audio: true
      };
      navigator.mediaDevices
          .getUserMedia(mediaConstraints)
          .then(this.successCallback.bind(this), this.errorCallback.bind(this));
  }

  /**
   * Will be called automatically.
   */
  successCallback(stream:any) {
      var options = {
          mimeType: "audio/wav",
          numberOfAudioChannels: 1
      };
      //Start Actuall Recording
      var StereoAudioRecorder = RecordRTC.StereoAudioRecorder;
      this.record = new StereoAudioRecorder(stream, options);
      this.record.record();
  }

  /**
   * Stop recording.
   */
  stopRecording() {
      this.recording = false;
      this.record.stop(this.processRecording.bind(this));
  }
  /**
   * @param  {any} blob Blog
   */
  processRecording(blob:any) {
      this.url = URL.createObjectURL(blob);
  }

  errorCallback(error:any) {
      this.error = 'Can not play audio in your browser';
  }
}