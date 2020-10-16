using Data7001WebTool.data;
using Data7001WebTool.dbs863472;
using Microsoft.AspNetCore.Components;
using Newtonsoft.Json;
using Org.BouncyCastle.Bcpg.OpenPgp;
using Syncfusion.Blazor.Data;
using Syncfusion.Blazor.Maps;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Data7001WebTool.Pages
{
    public class PopulationDetail
    {
        public string Name;
    }

    public partial class Index : ComponentBase
    {
        [Inject] private dbs863472Context dbs863472Context { get; set; }
        public List<PopulationDetail> PopulationDetails { get; set; } = default;
        public List<Projectscsv> Projects { get; set; } = default;
        public List<MapsLayer> Layers { get; set; } = new List<MapsLayer>();
        public double LayerIndex = 0;

        SfMaps mapQueensland;


        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            try
            {
                if (firstRender)
                {
                    //var data = File.ReadAllText("data/State_electoral_boundaries_2017.json");
                    // var asd = new LayerSettingsModel();


                    //asd.Type = Syncfusion.Blazor.Maps.Type.Layer;
                    //asd.ShapeData = data;
                    //asd.DataSource = PopulationDetails;
                    //asd.ShapeDataPath = "Name";
                    //asd.ShapePropertyPath = "Name";
                    //asd.ShapeSettings = new ShapeSettingsModel();
                    //asd.ShapeSettings.Fill = "#E5E5E5";

                    //asd.ShapeSettings.Border = new BorderModel();
                    //asd.ShapeSettings.Border.Width = 0.3;
                    //asd.ShapeSettings.Border.Color = "#000000";



                    //await mapQueensland.AddLayer(asd);
                    //this.StateHasChanged();

                    //var  data = File.ReadAllText("data/test.json");

                    //  var asd = new LayerSettingsModel();


                    //  asd.LayerType = ShapeLayerType.Geometry;
                    //  asd.ShapeData = data;
                    //  asd.DataSource = PopulationDetails;
                    //  asd.ShapeDataPath = "Name";
                    //  asd.ShapePropertyPath = "NAME";

                    //  asd.ShapeSettings = new ShapeSettingsModel();
                    //  asd.ShapeSettings.Fill = "#E5E5E5";
                    //  asd.ShapeSettings.Border = new BorderModel();
                    //  asd.ShapeSettings.Border.Width = 0.3;
                    //  asd.ShapeSettings.Border.Color = "#000000";
                    //  await mapQueensland.AddLayer(asd);
                    //  this.StateHasChanged();
                    //DynamicRender = CreateComponent();
                    //this.StateHasChanged();
                }

            }
            catch (Exception ex)
            {

                throw;
            }
            
        }
        //private Microsoft.AspNetCore.Components.RenderFragment DynamicFragment;
        protected override async Task OnInitializedAsync()
        {
            try
            {

                var data = File.ReadAllText("data/State_electoral_boundaries_2017.json");

                //Root myDeserializedClass = JsonConvert.DeserializeObject<Root>(data);
                PopulationDetails = dbs863472Context.Electoraldistricts.Where(x => x.Year == 2017).Select(x =>
                     new PopulationDetail
                     {
                         Name = x.ElectoralDistrict

                     }
              ).ToList();

                Projects = dbs863472Context.Projectscsv.ToList();

                var asd = new MapsLayer();


                asd.Type = Syncfusion.Blazor.Maps.Type.Layer;
                asd.ShapeData = data;
                asd.DataSource = PopulationDetails;
                asd.ShapeDataPath = "Name";
                asd.ShapePropertyPath = "NAME";

                asd.ShapeSettings = new MapsShapeSettings();
                asd.ShapeSettings.Fill = "#E5E5E5";
                asd.ShapeSettings.Border = new MapsShapeBorder();
                asd.ShapeSettings.Border.Width = 0.3;
                asd.ShapeSettings.Border.Color = "#000000";

                asd.DataLabelSettings = new MapsDataLabelSettings();
                asd.DataLabelSettings.Visible = true;
                asd.DataLabelSettings.LabelPath = "Name";
                asd.DataLabelSettings.SmartLabelMode = SmartLabelMode.Hide;

                asd.MarkerSettings = new List<MapsMarker>();
                var mark = new MapsMarker();
                mark.Visible = true;
                mark.Shape = MarkerType.Image;
                mark.ImageUrl = "css/ballon.png";
                mark.Height = 20;
                mark.Width = 20;
                mark.DataSource = Projects;
                mark.TooltipSettings = new MapsMarkerTooltipSettings();
                mark.TooltipSettings.ValuePath = "ProjectTitle";
                asd.MarkerSettings.Add(mark);

                Layers.Add(asd);

                //data = File.ReadAllText("data/test.json");

                //asd = new MapsLayer();
                //asd.ShapeData = data;
                //asd.LayerType = ShapeLayerType.Geometry;
                //Layers.Add(asd);

                //data = File.ReadAllText("data/test.json");
                //DynamicFragment = builder =>
                //{
                //    builder.OpenComponent(0, typeof(MapsLayer));
                //    builder.AddAttribute(1, "Type", Syncfusion.Blazor.Maps.Type.SubLayer);
                //    builder.AddAttribute(2, "ShapeData", data);
                //    builder.AddAttribute(3, "LayerType", ShapeLayerType.Geometry);
                //    builder.AddAttribute(4, "DataSource", PopulationDetails);
                //    builder.AddAttribute(5, "ShapeDataPath", "Name");
                //    builder.AddAttribute(6, "ShapePropertyPath", "NAME");
                //    builder.CloseComponent();
                //};

            }
            catch (Exception ex)
            {

                throw;

            }
           
        }

        void Zooming(IMapZoomEventArgs args)
        {
            var asd = ((Newtonsoft.Json.Linq.JContainer)((Newtonsoft.Json.Linq.JContainer)args.TranslatePoint).Last).Last;

            //var center = new MapsCenterPosition();
            //center.Longitude  = (double) ((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)args.TranslatePoint).Last).Value).Last).Value;
            //center.Latitude = (double)((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)((Newtonsoft.Json.Linq.JProperty)((Newtonsoft.Json.Linq.JContainer)args.TranslatePoint).Last).Value).First).Value;
            //// mapQueensland.ZoomByPosition(mapQueensland.CenterPosition, 70);
            //  args.Cancel = true;
            //  args.Scale=  "{{'previous': 1.01,'current': 200.01}}";
        }


        //private RenderFragment DynamicRender { get; set; }

        //private RenderFragment CreateComponent() => builder =>
        //{
           

                   

        //    var asd = new LayerSettingsModel();
        //  //  var laa = new MapsLayer();

        //   // asd.Type = Syncfusion.Blazor.Maps.Type.SubLayer;
        //   // asd.LayerType = ShapeLayerType.Geometry;
        //   // asd.ShapeData = data;
        //   // asd.DataSource = PopulationDetails;
        //    //asd.ShapeDataPath = "Name";
        //    //asd.ShapePropertyPath = "NAME";

        //    asd.ShapeSettings = new ShapeSettingsModel();
        //    asd.ShapeSettings.Fill = "#E5E5E5";
        //    asd.ShapeSettings.Border = new BorderModel();
        //    asd.ShapeSettings.Border.Width = 0.3;
        //    asd.ShapeSettings.Border.Color = "#000000";

          
        //   // builder.AddAttribute(7, "ShapeSettings", asd.ShapeSettings);           
        //    builder.CloseComponent();
        //};

        protected async Task Zoom_Button()
        {
            try
            {


                // var data = File.ReadAllText("data/State_electoral_boundaries_2017.json");
                // var asd = new LayerSettingsModel();


                // asd.Type  = Syncfusion.Blazor.Maps.Type.Layer;
                // asd.ShapeData = data;
                // asd.DataSource = PopulationDetails;
                // asd.ShapeDataPath = "Name";
                // asd.ShapePropertyPath = "NAME";

                // asd.ShapeSettings = new ShapeSettingsModel();
                // asd.ShapeSettings.Fill = "#E5E5E5";
                // asd.ShapeSettings.Border = new BorderModel();
                // asd.ShapeSettings.Border.Width = 0.3;
                // asd.ShapeSettings.Border.Color = "#000000";

                // asd.DataLabelSettings = new DataLabelSettingsModel();

                //await mapQueensland.AddLayer(asd);
                //  this.StateHasChanged();

                //var data = File.ReadAllText("data/test.json");

                //var asd = new LayerSettingsModel();
                // var laa = new MapsLayer();

                //asd.Type = Syncfusion.Blazor.Maps.Type.SubLayer;
                //asd.LayerType = ShapeLayerType.Geometry;
                //asd.ShapeData = data;
                //asd.DataSource = PopulationDetails;
                //asd.ShapeDataPath = "Name";
                //asd.ShapePropertyPath = "NAME";

                //asd.ShapeSettings = new ShapeSettingsModel();
                //asd.ShapeSettings.Fill = "#E5E5E5";
                //asd.ShapeSettings.Border = new BorderModel();
                //asd.ShapeSettings.Border.Width = 0.3;
                //asd.ShapeSettings.Border.Color = "#000000";


                ////var para = new ParameterView();
                ////para.
                ////para.SetParameterProperties(asd);
                ////await laa.SetParametersAsync(para);

                ////  await mapQueensland.RemoveLayer(0);

                //await mapQueensland.AddLayer(asd);
                //this.StateHasChanged();

               var data = File.ReadAllText("data/test.json");

              var  asd = new MapsLayer();
                asd.ShapeData = data;
                asd.LayerType = ShapeLayerType.Geometry;
                Layers.Add(asd);
                this.StateHasChanged();
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        private void ShapeSelection(IShapeSelectedEventArgs args)
        {
            if(args.Data!=null)
            {
                Dictionary<string, string> DrillData = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(args.Data.ToString());
                if (mapQueensland.BaseLayerIndex == 0)
                {
                    if (DrillData["Name"] == "Cook")
                    {
                        LayerIndex = 1;
                        this.StateHasChanged();
                    }

                }
            }
           
        }

    }

}

