using System;
using System.Collections.Generic;

namespace DataWebTool.dbs863472
{
    public partial class Population2016
    {
        public int Code { get; set; }
        public string Label { get; set; }
        public int Year { get; set; }
        public double MedianAgeMales { get; set; }
        public double MedianAgeFemales { get; set; }
        public double MedianAgesPersons { get; set; }
        public int MalesTotal { get; set; }
        public int FemalesTotal { get; set; }
        public int PersonsTotal { get; set; }
        public double PopulationDensityPersonsKm2 { get; set; }
    }
}
