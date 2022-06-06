import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { WebcamModule} from 'ngx-webcam';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { GazeTrackingComponent } from './gaze-tracking/gaze-tracking.component';
import { MainScreenComponent } from './main-screen/main-screen.component';
import { HttpClientModule } from '@angular/common/http';
import { MotionDetectionComponent } from './motion-detection/motion-detection.component';
import { ColorDetectionComponent } from './color-detection/color-detection.component';

@NgModule({
  declarations: [
    AppComponent,
    MainScreenComponent,
    GazeTrackingComponent,
    MotionDetectionComponent,
    ColorDetectionComponent
  ],
  imports: [
    WebcamModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
