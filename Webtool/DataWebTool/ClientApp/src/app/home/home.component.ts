import queenslandjson from '../../../../data/State_electoral_boundaries_2017.json';
import testjson from '../../../../data/test.json';
import { Component, ViewEncapsulation, Inject, OnInit, ViewChild } from '@angular/core';
import {
  MapsTheme, Maps, shapeSelected, IShapeSelectedEventArgs, Highlight,
  MapsTooltip, Marker, ILoadEventArgs, ILoadedEventArgs, MapsComponent, LegendService, DataLabelService, MapsTooltipService, SelectionService, Zoom 
} from '@syncfusion/ej2-angular-maps';
import { MapAjax } from '@syncfusion/ej2-maps';
import { HttpClient } from '@angular/common/http';
import { DropDownListComponent } from '@syncfusion/ej2-angular-dropdowns';
import { AnimationModel } from '@syncfusion/ej2-progressbar';
import { ProgressBar } from '@syncfusion/ej2-angular-progressbar';
Maps.Inject(Highlight, MapsTooltip, Marker, Zoom);

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
})
export class HomeComponent implements OnInit {


  public primaryXAxis = {
  valueType: 'Category',
    title: 'Departments'
};


  public animation: AnimationModel = { enable: true, duration: 2000, delay: 0 };
  public type1: string = 'Linear';
  public width1: string = '650';
  public height1: string = '60';
  public trackThickness1: number = 4;
  public progressThickness1: number = 4;
  public min1: number = 0;
  public max1: number = 100;
  public value1: number = 20;
  public isIndeterminate1: boolean = true;
  
  public mapheight: number = 1000;
  
  public electoralDistrictFields: Object = { text: 'electoralDistrict', value: 'electoralDistrict' };
  public electoralDistrictValue: string = '';
  public projects: Projectscsv[];
  public electoralBoundaries: string;
  public electoraldistricts: Electoraldistricts[];
  public layers: object[] = [];
  public departmentsCount: ItemFunnelChart[] = [];

  @ViewChild("maps") public maps: MapsComponent;
  @ViewChild('listElectoralDistrict') public listElectoralDistrict: DropDownListComponent;
  @ViewChild('progressBar')  public progressBar1: ProgressBar;




  constructor(http: HttpClient, @Inject('BASE_URL') baseUrl: string) {

    http.get<Projectscsv[]>(baseUrl + 'data7001/GetProjects').subscribe(result => {
      this.projects = result;
      this.createFunnelDepartmentData(result);
      this.createLayers();
    }, error => console.error(error));

    http.get<string>(baseUrl + 'data7001/GetElectoralBoundaries').subscribe(result => {
      this.electoralBoundaries = result;
    
      this.createLayers();
    }, error => console.error(error));

    http.get<Electoraldistricts[]>(baseUrl + 'data7001/GetElectoraldistricts2017').subscribe(result => {
      this.electoraldistricts = result;
      //console.log(this.electoraldistricts);
      this.createLayers();
    }, error => console.error(error));
  }

 
  ngOnInit() {

    try {



    } catch (e) {
      console.error(e);
    }
  }

  private createFunnelDepartmentData(projects: Projectscsv[]) {  

    try {

      let departments: ItemFunnelChart[] = [];
      let department: ItemFunnelChart;
      

      for (var project of projects) {
        department = departments.find(x => x.name === project.generalDepartment);

        if (department != null) {

          department.y = department.y + 1;

        } else {
          department = {
            name: project.generalDepartment,
            x: project.generalDepartment,
            y: 1
          }
          departments.push(department);
        }

      }

      for (department of departments) {
        department.y = (department.y / projects.length)*100
      }    
      this.departmentsCount = [...departments.sort((x, y) => x.y > y.y ? 1 : -1)];     
    } catch (e) {
      console.error(e);
    }    
  }


  private createLayers() {
    try {

      if (this.electoraldistricts == null || this.projects == null || this.electoralBoundaries==null ) {
        return;
      }

      let layers = [{
        shapeData: this.electoralBoundaries ,
        shapePropertyPath: 'NAME',
        shapeDataPath: 'electoralDistrict',
        layerType: 'Geometry', 
        dataSource: this.electoraldistricts,
        shapeSettings:
        {
          fill: "#E5E5E5",
          border:
          {
            width: 0.2,
            color: "#000000"
          }
        },

        dataLabelSettings:
        {
           visible: true,
          labelPath: "electoralDistrict",
          smartLabelMode: "Hide"
        },

        //markerClusterSettings: {
        //  allowClustering: true,
        //  shape: 'Image',
        //  height: 40,
        //  width: 40,
        //  labelStyle: { color: 'white' },
        //  imageUrl: 'css/cluster.svg'
        //},

        markerSettings:
          [{            
           visible: true,
           shape: "Image",
           imageUrl: "css/ballon.png",
           height : 20,
           width : 20,
            dataSource: this.projects,
            tooltipSettings: { visible: true, valuePath: 'projectTitle' }
          }]

      }];

      
     
      var posti: number = 1;
      for (var district of this.electoraldistricts) {
        district.position = posti;
        posti = posti + 1;
        let disProjects = this.projects.filter(x => x.electorate.toUpperCase() === district.electoralDistrict.toUpperCase());

        var layer = {
          layerType: 'Geometry',         
          shapeData: JSON.parse(district.coordinates),
          shapePropertyPath: 'NAME',
          shapeDataPath: 'electoralDistrict',
          dataSource: this.electoraldistricts,
          shapeSettings:
          {
            fill: "#E5E5E5",
            border:
            {
              width: 0.2,
              color: "#000000"
            }
          },

          dataLabelSettings:
          {
            visible: true,
            labelPath: "electoralDistrict",
            smartLabelMode: "Hide"
          },

          markerSettings:
            [{
              visible: true,
              shape: "Image",
              imageUrl: "css/ballon.png",
              height: 20,
              width: 20,
              dataSource: disProjects,
              tooltipSettings: { visible: true, valuePath: 'projectTitle' }
            }]

        };

        layers.push(layer);
      }
      
      this.layers = [...layers];
    
     

    } catch (e) {
      console.error(e);
    }
  }

  
  public shapeSelected = (args: IShapeSelectedEventArgs): void => {
   
    let shapeData: ShapeData = (args.shapeData as ShapeData);

   
    if (this.maps.baseLayerIndex === 0 && !touchmove)
    {
      this.DrillMap(shapeData.NAME);
      touchmove = false;
    }

  }

  public onlistElectoralDistrictChange(args: any): void {

    if (this.listElectoralDistrict.value != null) {
      this.DrillMap(this.listElectoralDistrict.value.toString());
    }
   
  }


  private DrillMap(newDistrict: string) {

    var district = this.electoraldistricts.filter(x => x.electoralDistrict.toUpperCase() === newDistrict.toUpperCase());
    if (district.length > 0) {
      this.maps.baseLayerIndex = district[0].position;

      this.createFunnelDepartmentData(this.projects.filter(x => x.electorate.toUpperCase() === newDistrict.toUpperCase()));

      this.maps.refresh();
      this.mapheight = 50;
      let button: HTMLElement = document.getElementById('button'); button.style.display = 'block';

      (<HTMLElement>document.getElementById('category')).style.visibility = 'visible';
      (<HTMLElement>document.getElementById('text')).innerHTML = district[0].electoralDistrict;
      (<HTMLElement>document.getElementById('symbol')).style.visibility = 'visible';




      //(<HTMLElement>document.getElementById('chartDepartments')).style.visibility = 'visible';
    }

  }

  public zoomSettings: object = {
    enable: true,
    maxZoom: 7000,
    doubleClickZoom: true,
    enablePanning: true,
    enableSelectionZooming: true,
  };

  titleSettings: object = {
    text: 'Queensland',
    textStyle: {
      size: '16px'
    }
  };


  ngAfterViewInit() {

    //(<HTMLElement>document.getElementById('chartDepartments')).style.visibility = 'hidden';

    document.getElementById('category').onclick = () => {
      this.maps.baseLayerIndex = 0;     
      this.maps.refresh();
      this.mapheight = 1000;
      let button: HTMLElement = document.getElementById('button');
      button.style.display = 'none';
      (<HTMLElement>document.getElementById('category')).style.visibility = 'hidden';
      (<HTMLElement>document.getElementById('text')).innerHTML = '';
      (<HTMLElement>document.getElementById('symbol')).style.visibility = 'hidden';
      this.createFunnelDepartmentData(this.projects);
      //(<HTMLElement>document.getElementById('chartDepartments')).style.visibility = 'hidden';
    };
  }

  public loaded = (args: ILoadedEventArgs) => {
    let mapsSVG: HTMLElement = document.getElementById('maps') as HTMLElement;
   
    if (mapsSVG) {
      mapsSVG.addEventListener('touchmove', (e: MouseEvent) => { touchmove = true; }, false);
    }
  }


  public load = (args: ILoadEventArgs) => {
    let theme: string = location.hash.split('/')[1];
    theme = theme ? theme : 'Material';
    args.maps.theme = <MapsTheme>(theme.charAt(0).toUpperCase() + theme.slice(1));
  }

}





let touchmove: boolean;
export interface ShapeData { NAME: string; ID: number }
export interface Electoraldistricts {
  idelectoralDistrict: number;
  electoralDistrict: string;
  year: number | null;
  coordinates: string;
  position: number;
} 


export interface Projectscsv {
  projectTitle: string;
  department: string;
  projectType: string;
  totalEstimatedCost: string;
  lastFinancialYearExpenditure: string;
  currentFinancialYearExpenditure: string;
  ongoingProgram: string;
  futureFinancialYearExpenditure: string;
  tenderCall: string;
  procurementSystem: string;
  indicativePqcrating: string;
  region: string;
  commentary: string;
  tenderType: string;
  projectEnvironment: string;
  indigenousCommunity: string;
  projectNumber: string;
  annotations: string;
  financialYear: string;
  latitude: number | null;
  longitude: number | null;
  electorate: string;
  generalDepartment: string;
}

export interface ItemFunnelChart {
  x: string;
  y: number;
  name: string;
}
