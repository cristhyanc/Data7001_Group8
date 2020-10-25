import queenslandjson from '../../../../data/State_electoral_boundaries_2017.json';
import testjson from '../../../../data/test.json';
import { Component, ViewEncapsulation, Inject, OnInit, ViewChild } from '@angular/core';
import {
  MapsTheme, Maps, shapeSelected, IShapeSelectedEventArgs, Highlight,
  MapsTooltip, Marker, ILoadEventArgs,  MapsComponent, LegendService, DataLabelService, MapsTooltipService, SelectionService, Zoom, LayerSettings, LayerSettingsModel 
} from '@syncfusion/ej2-angular-maps';
import { Bubble, MapAjax } from '@syncfusion/ej2-maps';
import { HttpClient } from '@angular/common/http';
import { DropDownListComponent } from '@syncfusion/ej2-angular-dropdowns';
import { AnimationModel } from '@syncfusion/ej2-progressbar';
import { ProgressBar } from '@syncfusion/ej2-angular-progressbar';
import { ChangeArgs, ChangeEventArgs } from '@syncfusion/ej2-angular-buttons';
import { ChartTheme, Double, IPointRenderEventArgs, ILoadedEventArgs, Chart} from '@syncfusion/ej2-angular-charts';
import { Browser } from '@syncfusion/ej2-base';

Maps.Inject(Highlight, MapsTooltip, Marker, Zoom);

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
})
export class HomeComponent implements OnInit {

  public data2: bubblePoint[] = [];

  public pointRender(args: IPointRenderEventArgs): void {
 
    if (args.point.text === 'ALP') {
      args.fill = '#DE3533';
    } else if (args.point.text === 'GRN') {
      args.fill = '#00a651';
    } else if (args.point.text === 'KAP') {
      args.fill = '#B50204';
    } else if (args.point.text === 'LNP') {
      args.fill = '#1456F1';
    } else if (args.point.text === 'ONP') {
      args.fill = '#f36c21';
    } else if (args.point.text === 'LIB') {
      args.fill = '#080CAB';
    } else if (args.point.text === 'NPA') {
      args.fill = 'green';
    }

  }

  public bubbleload(args: ILoadedEventArgs): void {
    let selectedTheme: string = location.hash.split('/')[1];
    selectedTheme = selectedTheme ? selectedTheme : 'Material';
    args.chart.theme = <ChartTheme>(selectedTheme.charAt(0).toUpperCase() + selectedTheme.slice(1)).replace(/-dark/i, "Dark");
  };

  public bubblewidth: string = Browser.isDevice ? '100%' : '60%';

  public bubbletitle: string = '';

  public bubbleminRadius: number = 3;
  public bubblemaxRadius: number = Browser.isDevice ? 6 : 8;

  public bubblelegend: Object = {
    visible: false
  };

  public  bubbletooltip: Object = {
    enable: true,
    format: "${point.text}<br/>Electoral District Rate : <b>${point.size}</b>" 
  };

  public bubblechartArea: Object = {
    border: {
      width: 0
    }
  };

  public bubbleprimaryXAxis: Object = {
    title: '',
    minimum: 0,
    maximum: 100,
    interval: 10
  };
 
  public bubbleprimaryYAxis: Object = {
    title: '',
    minimum: 0,
    maximum: 100,
    interval: 10
  };

  public bubblemarker: Object = {
    dataLabel: { name: 'text' }
  };

  public primaryXAxis = {
  valueType: 'Category',
    title: 'Departments'
};

  public zoomSettings: object = {
    enable: true,
    maxZoom: 7000,
    doubleClickZoom: true,
    enablePanning: true,
    enableSelectionZooming: true,
  };

  public titleSettings: object = {
    text: 'Queensland',
    textStyle: {
      size: '16px'
    }
  };

  public legendSettings: Object = {
    visible: true,
    valuePath: 'currentPartyID',
    removeDuplicateLegend: true
  }

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
  public lgaBoundaries: string;
  public electoraldistricts: Electoraldistricts[];
  public layers: LayerSettingsModel[] = [];
  public departmentsCount: ItemFunnelChart[] = [];
  public displayProjects: boolean=false;  
  public population: Population[] = [];
  public currentFinancialYearExpenditure: number = 0;
  public lastFinancialYearExpenditure: number = 0;
  public futureFinancialYearExpenditure: number = 0;
  public totalEstimatedCost: number = 0;
  public yearsList: number[] = [2017, 2015, 2012, 2009, 2006, 2004];
  public yearsListValue: number = 2017;
  public electorateSafety: ElectorateSafety[] = [];

  @ViewChild("maps") public maps: MapsComponent;
  @ViewChild('listElectoralDistrict') public listElectoralDistrict: DropDownListComponent;
  @ViewChild('listyears') public listyears: DropDownListComponent;
  @ViewChild('progressBar')  public progressBar1: ProgressBar;
  @ViewChild("chartcontainer") public charBubble: Chart;

  

  public processelectorateSafetyYear(year: number) {

   
    let data: bubblePoint[] = [];
    let years = this.electorateSafety.filter(x => x.year == year);

    let pointALP: bubblePoint = new bubblePoint('ALP');
    let pointLNP: bubblePoint = new bubblePoint('LNP');
    let pointKAP: bubblePoint = new bubblePoint('KAP');
    let pointGRN: bubblePoint = new bubblePoint('GRN');
    let pointONP: bubblePoint = new bubblePoint('ONP');
    let pointNPA: bubblePoint = new bubblePoint('NPA');
    let pointLIB: bubblePoint = new bubblePoint('LIB');
    let totalPoints: number = this.electorateSafety.filter(x =>  x.year == year).length;


    this.bubbletitle = "State Elections " + year + ". Total of " + totalPoints + " Electoral Districts";

    pointALP.size = this.electorateSafety.filter(x => x.party ==='ALP' && x.year == year).length/100;
    pointLNP.size = this.electorateSafety.filter(x => x.party === 'LNP' && x.year == year).length / 100;
    pointKAP.size = this.electorateSafety.filter(x => x.party === 'KAP' && x.year == year).length / 100;
    pointGRN.size = this.electorateSafety.filter(x => x.party === 'GRN' && x.year == year).length / 100;
    pointONP.size = this.electorateSafety.filter(x => x.party === 'ONP' && x.year == year).length / 100;
    pointNPA.size = this.electorateSafety.filter(x => x.party === 'NPA' && x.year == year).length / 100;
    pointLIB.size = this.electorateSafety.filter(x => x.party === 'LIB' && x.year == year).length / 100;

    pointALP.percentage = pointALP.size * 100;
    pointLNP.percentage = pointLNP.size * 100;
    pointKAP.percentage = pointKAP.size * 100;
    pointGRN.percentage = pointGRN.size * 100;
    pointONP.percentage = pointONP.size * 100;
    pointNPA.percentage = pointNPA.size * 100;
    pointLIB.percentage = pointLIB.size * 100;

    if (pointALP.size > 0) {
      data.push(pointALP);
    }

    if (pointLNP.size > 0) {
      data.push(pointLNP);
    }

    if (pointKAP.size > 0) {
      data.push(pointKAP);
    }

    if (pointGRN.size > 0) {
      data.push(pointGRN);
    }

    if (pointONP.size > 0) {
      data.push(pointONP);
    }

    if (pointNPA.size > 0) {
      data.push(pointNPA);
    }

    if (pointLIB.size > 0) {
      data.push(pointLIB);
    }
     

    data = data.sort((x, y) => x.size > y.size ? 1 : -1);

    let xPOsition = 10;
    for (var point of data) {
      point.x = xPOsition;
      point.y = xPOsition;
      xPOsition = xPOsition + 10;
    }

    this.data2 = [...data];
    this.charBubble.refresh();
  }
  

  constructor(http: HttpClient, @Inject('BASE_URL') baseUrl: string) {

    http.get<ElectorateSafety[]>(baseUrl + 'data7001/GetElectorateSafety').subscribe(result => {
      this.electorateSafety = result;
      this.processelectorateSafetyYear(2017);
    }, error => console.error(error));

    http.get<Population[]>(baseUrl + 'data7001/GetPopulation').subscribe(result => {
      this.population = result;
    
    }, error => console.error(error));

    http.get<Projectscsv[]>(baseUrl + 'data7001/GetProjects').subscribe(result => {
      this.projects = result;
      this.createFunnelDepartmentData(result);
      this.CreateInitialMapLayers();
    }, error => console.error(error));

    http.get<string>(baseUrl + 'data7001/GetLGABoundaries').subscribe(result => {
      this.lgaBoundaries = result;
      this.CreateInitialMapLayers();
    }, error => console.error(error));

    http.get<string>(baseUrl + 'data7001/GetElectoralBoundaries').subscribe(result => {
      this.electoralBoundaries = result;
      this.CreateInitialMapLayers();
    }, error => console.error(error));

    http.get<Electoraldistricts[]>(baseUrl + 'data7001/GetElectoraldistricts').subscribe(result => {
      this.electoraldistricts = result;    
      this.CreateInitialMapLayers();
    }, error => console.error(error));
  }

 
  ngOnInit() {

    try {

      this.displayProjects = true;

    } catch (e) {
      console.error(e);
    }
  }

  private createFunnelDepartmentData(projects: Projectscsv[]) {  

    try {

      this.lastFinancialYearExpenditure = projects.reduce((sum, current) => sum + current.lastFinancialYearExpenditure, 0);
      this.futureFinancialYearExpenditure = projects.reduce((sum, current) => sum + current.futureFinancialYearExpenditure, 0);
      this.totalEstimatedCost = projects.reduce((sum, current) => sum + current.totalEstimatedCost, 0);
      this.currentFinancialYearExpenditure = projects.reduce((sum, current) => sum + current.currentFinancialYearExpenditure, 0);

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


 
  private CreateInitialMapLayers() {
    try {

      if (this.electoraldistricts == null || this.projects == null || this.electoralBoundaries == null || this.lgaBoundaries == null || this.population==null ) {
        return;
      }

     
      this.layers = [];

      let layer: LayerSettingsModel =

        {
        shapeData: this.electoralBoundaries ,
        shapePropertyPath: 'NAME',
        shapeDataPath: 'electoralDistrict',
        layerType: 'Geometry', 
        dataSource: this.electoraldistricts.filter(x => x.year == this.listyears.value),
        shapeSettings:
        {
          fill: "#E5E5E5",
          border:
          {
            width: 0.2,
            color: "#000000"
          },
          colorValuePath: 'currentPartyID',
          colorMapping: [
            {
              value: "ALP", color: '#DE3533'
            },
            {
              value: "GRN", color: '#00a651'
            },
            {
              value: "KAP", color: '#B50204'
            },
            {
              value: "LNP", color: '#1456F1'
            },
            {
              value: "ONP", color: '#f36c21'
            },
            {
              value: "LIB", color: '#080CAB'
            },
            {
              value: "NPA", color: '#green'
            }
          ]

        },

        dataLabelSettings:
        {
          visible: true,
          labelPath: "electoralDistrict",
          smartLabelMode: "Hide"
        },      

        markerSettings:
          [{            
            visible: false,
           shape: "Image",
           imageUrl: "css/ballon.png",
           height : 20,
           width : 20,
            dataSource: this.projects,
            tooltipSettings: { visible: true, valuePath: 'projectTitle' }
          }]

      };

      this.layers.push(layer);
     
      var posti: number = 1;
      for (var district of this.electoraldistricts.filter(x => x.year == this.listyears.value)) {
        district.position = posti;
        posti = posti + 1;
        let disProjects = this.projects.filter(x => x.electorate.toUpperCase() === district.electoralDistrict.toUpperCase());

         layer = {
          layerType: 'Geometry',         
          shapeData: JSON.parse(district.coordinates),
          shapePropertyPath: 'NAME',
          shapeDataPath: 'electoralDistrict',
           dataSource: this.electoraldistricts.filter(x => x.year == this.listyears.value),
          shapeSettings:
          {
            fill: "#E5E5E5",
            border:
            {
              width: 0.2,
              color: "#000000"
            },
            colorValuePath: 'currentPartyID',
            colorMapping: [
              {
                value: "ALP", color: '#DE3533'
              },
              {
                value: "GRN", color: '#00a651'
              },
              {
                value: "KAP", color: '#B50204'
              },
              {
                value: "LNP", color: '#1456F1'
              },
              {
                value: "ONP", color: '#f36c21'
              },
              {
                value: "LIB", color: '#080CAB'
              },
              {
                value: "NPA", color: '#green'
              }
            ]
          },

          dataLabelSettings:
          {
            visible: true,
            labelPath: "electoralDistrict",
            smartLabelMode: "Hide"
          },

          markerSettings:
            [{
              visible: false,
              shape: "Image",
              imageUrl: "css/ballon.png",
              height: 20,
              width: 20,
              dataSource: disProjects,
              tooltipSettings: { visible: true, valuePath: 'projectTitle' }
            }]

        };

        this.layers.push(layer);
      }
        
      
      layer = {
        shapeData: this.lgaBoundaries,
        shapePropertyPath: 'qld_lga__3',
        shapeDataPath: 'label',
        layerType: 'Geometry',
        dataSource: this.population,
        shapeSettings:
        {
          fill: "#E5E5E5",
          border:
          {
            width: 0.2,
            color: "#000000"
          },
          colorValuePath: 'personsTotal',
          colorMapping: [
            {
              from: 0, to: 20000, color: '#F9EBEA', label: '<20'
            },
            {
              from: 20000, to: 40000, color: '#F1948A', label: '20-40'
            },
            {
              from: 40000, to: 60000, color: '#EC7063', label: '40-60'
            },
            {
              from: 60000, to: 80000, color: '#E74C3C', label: '60-80'
            },
            {
              from: 80000, to: 100000, color: '#CD6155', label: '80-100'
            },
            {
              from: 100000, to: 200000, color: '#C0392B', label: '100-200'
            },
            {
              from: 200000, to: 400000, color: '#A93226', label: '200-400'
            },
            {
              from: 400000, to: 700000, color: '#922B21', label: '400-700'
            },           
            {
              from: 700000, to: 1400000, color: '#641E16', label: '700-1.4M'
            }
          ]

        },

        dataLabelSettings:
        {
          visible: true,
          labelPath: "label",
          smartLabelMode: "Hide"
        },       

        markerSettings:
          [{
            visible: false,
            shape: "Image",
            imageUrl: "css/ballon.png",
            height: 20,
            width: 20,
            dataSource: this.projects,
            tooltipSettings: { visible: true, valuePath: 'projectTitle' }
          }]

      };

     
      this.layers.push(layer);           

    } catch (e) {
      console.error(e);
    }
  }

  public displayProjectsChange(arg: ChangeEventArgs) {
    try {
      this.displayProjects = arg.checked;

      for (var layer of this.maps.layers) {
        layer.markerSettings[0].visible = this.displayProjects;
      }

      this.maps.refresh();

      if (arg.checked) {
        (<HTMLElement>document.getElementById('chartDepartments')).style.visibility = 'visible';
      } else {
        (<HTMLElement>document.getElementById('chartDepartments')).style.visibility = 'hidden';
      }
     
    } catch (e) {
      console.error(e);
    }

  }

  public electoralLGAChange(arg: ChangeArgs) {
    try {

      if (arg.value === 'lga') {
        this.maps.baseLayerIndex = this.maps.layers.length - 1;
        this.maps.refresh();
      } else {
        this.maps.baseLayerIndex = 0;
        this.maps.refresh();
      }
      console.log(arg);

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

  public onlistyearChange(args: any): void {

    if (this.listyears.value != null) {
      let year: number = +this.listyears.value;
      this.processelectorateSafetyYear(year);

      //for (var layer of this.maps.layers) {
      //  layer.dataSource = this.electoraldistricts.filter(x => x.year == this.listyears.value);
      //}

      //this.maps.refresh();
    }

  }

  private DrillMap(newDistrict: string) {

    var district = this.electoraldistricts.filter(x => x.year == this.listyears.value && x.electoralDistrict.toUpperCase() === newDistrict.toUpperCase());
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

  ngAfterViewInit() {

    (<HTMLElement>document.getElementById('chartDepartments')).style.visibility = 'hidden';

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
  currentParty: object;
  currentPartyID: string;
} 


export interface Projectscsv {
  projectTitle: string;
  department: string;
  projectType: string;
  totalEstimatedCost: number;
  lastFinancialYearExpenditure: number;
  currentFinancialYearExpenditure: number;
  ongoingProgram: string;
  futureFinancialYearExpenditure: number;
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

export interface Population {
  code: number;
  label: string;
  year: number;
  medianAgeMales: number;
  medianAgeFemales: number;
  medianAgePersons: number;
  malesTotal: number;
  femalesTotal: number;
  personsTotal: number;
  populationDensityPersonsKm2: number;
}

export class bubblePoint {

  x: number;
  y: number;
  size: number;
  text: string;
  percentage: number

  constructor(party: string) {
    this.text = party;
  }

}

export interface ElectorateSafety {
  electorate: string;
  party: string;
  safety: string;
  margin: number | null;
  year: number | null;
}










