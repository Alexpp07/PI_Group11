import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MainScreenComponent } from './mainScreen.component';

const routes: Routes = [
  {
    path: "",
    data: {
      title: "MainScreen",
      urls: [{ title: "MainScreen", url: "/mainScreen" }, { title: "MainScreen" }],
    },
    component: MainScreenComponent,
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: []
})
export class MainScreenModule { }