import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { interval, Subscription} from 'rxjs';
import {MatButtonModule} from '@angular/material/button';
import RecordRTC from 'recordrtc';
import { DomSanitizer } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

@Component({
  selector: 'app-motion-detection',
  templateUrl: './mediapipe-2hands.component.html',
  styleUrls: ['./mediapipe-2hands.component.css']
})
export class MediaPipe2HandsComponent implements OnInit {
  isImageSaved: boolean = false;
  imageUrl: string = "";
  mySubscription: Subscription
  rectangles = "4";
  link = "";
  setSong = "";
  setSong2 = "";
  setSong3 = "";
  setSong4 = "";
  setSong5 = "";
  setSong6 = "";
  setSong7 = "";
  setSong8 = "";
  songs = ["a4.wav", "b4.wav", "c4.wav", "d5.wav", "e5.wav", "f5.wav","g3.wav", ""]
  
  constructor(private http: HttpClient, private domSanitizer: DomSanitizer) {
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
    this.link = 'http://127.0.0.1:5000/mediapipe_2hands?rectangles='.concat(this.rectangles);
    const body = {"sound": this.setSong}
    this.http.get<any>(this.link).subscribe(data => {
      let imageBase64String = data.data;
      imageBase64String = imageBase64String.slice(2);
      imageBase64String = imageBase64String.slice(0, -1);
      this.imageUrl = 'data:image/png;base64,' + imageBase64String;
    //console.log(this.imageUrl)
  })
  }

  attachSound() {
    const headers = { "Content-Type": "audio/x-wav" };
    const body = {"sound": [this.setSong, this.setSong2, this.setSong3, this.setSong4, this.setSong5, this.setSong6, this.setSong7, this.setSong8] }
    console.log([this.setSong, this.setSong2, this.setSong3, this.setSong4, this.setSong5, this.setSong6, this.setSong7, this.setSong8])
    this.link = "http://127.0.0.1:5000/mediapipe_2hands"
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