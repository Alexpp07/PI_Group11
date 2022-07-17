import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { WebcamModule} from 'ngx-webcam';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { GazeTrackingComponent } from './gaze-tracking/gaze-tracking.component';
import { HttpClientModule } from '@angular/common/http';
import { MotionDetectionComponent } from './motion-detection/motion-detection.component';
import { MediaPipeHandsComponent } from './mediapipe-hands/mediapipe-hands.component';
import { MediaPipe2HandsComponent } from './mediapipe-2hands/mediapipe-2hands.component';
import { ColorDetectionComponent } from './color-detection/color-detection.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MatSelectModule} from '@angular/material/select';
import {MatMenuModule} from '@angular/material/menu';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import {MatGridListModule} from '@angular/material/grid-list';
import { ColorPickerModule } from '@iplab/ngx-color-picker';
import { AngularFileUploaderModule } from "angular-file-uploader";

@NgModule({
  declarations: [
    AppComponent,
    GazeTrackingComponent,
    MotionDetectionComponent,
    ColorDetectionComponent,
    MediaPipeHandsComponent,
    MediaPipe2HandsComponent
  ],
  imports: [
    WebcamModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    MatSelectModule,
    MatMenuModule,
    MatToolbarModule,
    MatButtonModule,
    MatGridListModule,
    ColorPickerModule,
    AngularFileUploaderModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
