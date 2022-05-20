import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MainScreenComponent } from './main-screen/main-screen.component';
import { AppComponent } from './app.component';
import { GazeTrackingComponent } from './gaze-tracking/gaze-tracking.component';

const routes: Routes = [
  { path: 'main-screen', component: MainScreenComponent },
  { path: 'gaze-tracking', component: GazeTrackingComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
