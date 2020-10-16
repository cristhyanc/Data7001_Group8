﻿using DataWebTool.dbs863472;
using GeoJSON.Net.Feature;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataWebTool.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class Data7001Controller : ControllerBase
    {

        dbs863472Context _context;

        public Data7001Controller(dbs863472Context context)
        {
            _context = context;
        }

        [HttpGet("Test1")]
        public string Test1()
        {
            return "I am in";
        }

        [HttpGet("GetProjects")]
        public IEnumerable<Projectscsv> GetProjects()
        {
            return _context.Projectscsv.ToList();
        }

        [HttpGet("GetElectoralBoundaries")]
        public string GetElectoralBoundaries()
        {
            var data = System.IO.File.ReadAllText(@"data\State_electoral_boundaries_2017.json");
            return data;
        }


        [HttpGet("GetElectoraldistricts2017")]
        public IEnumerable<Electoraldistricts> GetElectoraldistricts2017()
        {
            var data = System.IO.File.ReadAllText(@"data\State_electoral_boundaries_2017.json");
            var featureCollection = JsonConvert.DeserializeObject<FeatureCollection>(data);

            var districts=_context.Electoraldistricts.Where(x => x.Year == 2017);

            Parallel.ForEach(districts, (district) =>
            {
                var coordinates=featureCollection.Features.Where(x => x.Properties["NAME"].ToString().ToUpper().Equals(district.ElectoralDistrict.ToUpper())).FirstOrDefault();
                if(coordinates!=null)
                {
                    var list=new List<Feature>();
                    list.Add(coordinates);

                    var newFeatu = new FeatureCollection(list);
                    newFeatu.BoundingBoxes = featureCollection.BoundingBoxes;
                    newFeatu.CRS = featureCollection.CRS;

                    district.Coordinates = JsonConvert.SerializeObject(newFeatu);

                   // district.Coordinates = System.IO.File.ReadAllText(@"data\test.json"); 
                }
                
            });

            return _context.Electoraldistricts.Where(x => x.Year == 2017);
        }
    }
}
