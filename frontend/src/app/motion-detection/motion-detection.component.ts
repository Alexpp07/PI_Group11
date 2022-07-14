import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { interval, Subscription} from 'rxjs';
import {MatButtonModule} from '@angular/material/button';
import RecordRTC from 'recordrtc';
import { DomSanitizer } from '@angular/platform-browser';

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

    constructor(private http: HttpClient, private domSanitizer: DomSanitizer) {
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
      const body = {"rectangle": this.setRect, "sound": "teddybear"}
      this.link = "http://127.0.0.1:5000/square"
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
    /**
     * Process Error.
     */
    errorCallback(error:any) {
        this.error = 'Can not play audio in your browser';
    }
}