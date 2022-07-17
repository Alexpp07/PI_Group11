import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { interval, Subscription} from 'rxjs';
import {MatButtonModule} from '@angular/material/button';
import RecordRTC from 'recordrtc';
import { DomSanitizer } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

@Component({
  selector: 'app-motion-detection',
  templateUrl: './mediapipe-hands.component.html',
  styleUrls: ['./mediapipe-hands.component.css']
})
export class MediaPipeHandsComponent implements OnInit {
  isImageSaved: boolean = false;
  imageUrl: string = "";
  mySubscription: Subscription
  rectangles = "4";
  link = "";
  setSong = " ";
  songs = ["WAV_files/a4.wav", "WAV_files/b4.wav", "WAV_files/c4.wav", "WAV_files/g3.wav"]
  
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
    this.link = 'http://127.0.0.1:5000/mediapipe_hands?rectangles='.concat(this.rectangles);
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
    const body = {"sound": this.setSong}
    console.log(this.setSong)
    this.link = "http://127.0.0.1:5000/index_finger"
    console.log(this.link)
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