import queenslandjson from '../../../../data/State_electoral_boundaries_2017.json';
import testjson from '../../../../data/test.json';
import { Component, ViewEncapsulation, Inject, OnInit, ViewChild } from '@angular/core';
import {
  MapsTheme, Maps, shapeSelected, IShapeSelectedEventArgs, Highlight,
  MapsTooltip, Marker, ILoadEventArgs, ILoadedEventArgs, MapsComponent, LegendService, DataLabelService, MapsTooltipService, SelectionService, Zoom 
} from '@syncfusion/ej2-angular-maps';
import { MapAjax } from '@syncfusion/ej2-maps';
import { HttpClient } from '@angular/common/http';
Maps.Inject(Highlight, MapsTooltip, Marker, Zoom);

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
})
export class HomeComponent implements OnInit {

  public projects: object[];
  public electoralBoundaries: string;
  public electoraldistricts: Electoraldistricts[];
  public layers: object[]=[];
  @ViewChild("maps") public maps: MapsComponent;

  constructor(http: HttpClient, @Inject('BASE_URL') baseUrl: string) {

    http.get<object[]>(baseUrl + 'data7001/GetProjects').subscribe(result => {
      this.projects = result;
      this.createLayers();
    }, error => console.error(error));

    http.get<string>(baseUrl + 'data7001/GetElectoralBoundaries').subscribe(result => {
      this.electoralBoundaries = result;
      console.log(this.electoralBoundaries);
      this.createLayers();
    }, error => console.error(error));

    http.get<Electoraldistricts[]>(baseUrl + 'data7001/GetElectoraldistricts2017').subscribe(result => {
      this.electoraldistricts = result;
      //console.log(this.electoraldistricts);
      this.createLayers();
    }, error => console.error(error));
  }

  public load = (args: ILoadEventArgs) => {
    let theme: string = location.hash.split('/')[1];
    theme = theme ? theme : 'Material';
    args.maps.theme = <MapsTheme>(theme.charAt(0).toUpperCase() + theme.slice(1));
  }

  ngOnInit() {

    try {



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

        markerClusterSettings: {
          allowClustering: true,
          shape: 'Image',
          height: 40,
          width: 40,
          labelStyle: { color: 'white' },
          imageUrl: 'css/cluster.svg'
        },

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

          markerClusterSettings: {
            allowClustering: true,
            shape: 'Image',
            height: 40,
            width: 40,
            labelStyle: { color: 'white' },
            imageUrl: 'css/cluster.svg'
          },

          markerSettings:
            [{
              visible: true,
              shape: "Image",
              imageUrl: "css/ballon.png",
              height: 20,
              width: 20,
              dataSource: this.projects,
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

   
    if (this.maps.baseLayerIndex === 0)
    {
      var district = this.electoraldistricts.filter(x => x.electoralDistrict.toUpperCase() === shapeData.NAME.toUpperCase());
      if (district.length>0) {
        this.maps.baseLayerIndex = district[0].position;
        this.maps.refresh();
        let button: HTMLElement = document.getElementById('button'); button.style.display = 'block';
       
        (<HTMLElement>document.getElementById('category')).style.visibility = 'visible';
        (<HTMLElement>document.getElementById('text')).innerHTML = district[0].electoralDistrict;
        (<HTMLElement>document.getElementById('symbol')).style.visibility = 'visible';


      }

     
    }




    //if (this.maps.baseLayerIndex === 0 ) {
    //  if (shape === 'Africa') { 
    //    this.maps.baseLayerIndex = shape.ID;
    //    this.maps.refresh();
    //  }
    //  console.log(shape);
    //  //let button: HTMLElement = document.getElementById('button'); button.style.display = 'block';
    //  //document.getElementById('content').innerHTML = '';
    //  //(<HTMLElement>document.getElementById('category')).style.visibility = 'visible';
    //  //(<HTMLElement>document.getElementById('text')).innerHTML = shape;
    //  //(<HTMLElement>document.getElementById('symbol')).style.visibility = 'visible';
    //};
    //touchmove = false;
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
    document.getElementById('category').onclick = () => {
      this.maps.baseLayerIndex = 0;
      this.maps.refresh();
      let button: HTMLElement = document.getElementById('button');
      button.style.display = 'none';
      (<HTMLElement>document.getElementById('category')).style.visibility = 'hidden';
      (<HTMLElement>document.getElementById('text')).innerHTML = '';
      (<HTMLElement>document.getElementById('symbol')).style.visibility = 'hidden';
    };
  }

}

export interface ShapeData { NAME: string; ID: number }
export interface Electoraldistricts {
  idelectoralDistrict: number;
  electoralDistrict: string;
  year: number | null;
  coordinates: string;
  position: number;
}
