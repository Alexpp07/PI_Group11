import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { WebcamModule } from 'ngx-webcam';

import { MainScreenModule } from './mainScreen-routing.module';
import { MainScreenComponent } from './mainScreen.component';

@NgModule({
  declarations: [
    MainScreenComponent
  ],
  imports: [
    BrowserModule,
    MainScreenModule,
    FormsModule,
    ReactiveFormsModule,
    WebcamModule
  ],
  providers: [],
  bootstrap: [MainScreenComponent]
})
export class AppModule { }