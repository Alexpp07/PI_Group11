import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AppComponent } from './app.component';
import { GazeTrackingComponent } from './gaze-tracking/gaze-tracking.component';
import { MotionDetectionComponent } from './motion-detection/motion-detection.component';
import { ColorDetectionComponent } from './color-detection/color-detection.component';

const routes: Routes = [
  { path: 'gaze-tracking', component: GazeTrackingComponent },
  { path: 'motion-detection', component: MotionDetectionComponent },
  { path: 'color-detection', component: ColorDetectionComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }