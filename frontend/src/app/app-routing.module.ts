import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AppComponent } from './app.component';
import { GazeTrackingComponent } from './gaze-tracking/gaze-tracking.component';
import { MotionDetectionComponent } from './motion-detection/motion-detection.component';
import { ColorDetectionComponent } from './color-detection/color-detection.component';
import { MediaPipeHandsComponent } from './mediapipe-hands/mediapipe-hands.component';
import { MediaPipe2HandsComponent } from './mediapipe-2hands/mediapipe-2hands.component';

const routes: Routes = [
  { path: 'gaze-tracking', component: GazeTrackingComponent },
  { path: 'motion-detection', component: MotionDetectionComponent },
  { path: 'color-detection', component: ColorDetectionComponent },
  { path: 'mediapipe_hands', component: MediaPipeHandsComponent },
  { path: 'mediapipe_2hands', component: MediaPipe2HandsComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
