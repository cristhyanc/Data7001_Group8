using System;
using System.Collections.Generic;

namespace Data7001WebTool.dbs863472
{
    public partial class Population
    {
        public int Code { get; set; }
        public string Label { get; set; }
        public int Year { get; set; }
        public double MedianAgeMales { get; set; }
        public double MedianAgeFemales { get; set; }
        public double MedianAgePersons { get; set; }
        public int MalesTotal { get; set; }
        public int FemalesTotal { get; set; }
        public int PersonsTotal { get; set; }
        public double PopulationDensityPersonsKm2 { get; set; }
    }
}
