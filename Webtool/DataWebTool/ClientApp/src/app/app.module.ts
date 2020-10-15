import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { RouterModule } from '@angular/router';
//Syncfusion ej2-angular-calendars module
import { CalendarModule } from '@syncfusion/ej2-angular-calendars';

import { AppComponent } from './app.component';
import { NavMenuComponent } from './nav-menu/nav-menu.component';
import { HomeComponent } from './home/home.component';
import { CounterComponent } from './counter/counter.component';
import { FetchDataComponent } from './fetch-data/fetch-data.component';
import { MapsAllModule, MapsModule  } from '@syncfusion/ej2-angular-maps';
import { DropDownListModule } from '@syncfusion/ej2-angular-dropdowns';
import { ProgressBarModule } from '@syncfusion/ej2-angular-progressbar';
import { AccumulationChartModule, ChartModule } from '@syncfusion/ej2-angular-charts';
import { BarSeriesService, StackingBarSeriesService, CategoryService } from '@syncfusion/ej2-angular-charts';

@NgModule({
  declarations: [
    AppComponent,
    NavMenuComponent,
    HomeComponent,
    CounterComponent,
    FetchDataComponent
  ],
  imports: [
    MapsAllModule, MapsModule, DropDownListModule, ProgressBarModule, ChartModule,
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    HttpClientModule,
    FormsModule,
	 CalendarModule, //declaration of ej2-angular-calendars module into NgModule
    RouterModule.forRoot([
      { path: '', component: HomeComponent, pathMatch: 'full' },
      { path: 'counter', component: CounterComponent },
      { path: 'fetch-data', component: FetchDataComponent },
    ])
  ],
  providers: [BarSeriesService, StackingBarSeriesService, CategoryService],
  bootstrap: [AppComponent]
})
export class AppModule { }
