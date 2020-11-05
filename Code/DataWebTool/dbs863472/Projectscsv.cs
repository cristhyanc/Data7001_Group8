using System;
using System.Collections.Generic;

namespace DataWebTool.dbs863472
{
    public partial class Projectscsv
    {
        public string ProjectTitle { get; set; }
        public string Department { get; set; }
        public string ProjectType { get; set; }
        public decimal? TotalEstimatedCost { get; set; }
        public decimal? LastFinancialYearExpenditure { get; set; }
        public decimal? CurrentFinancialYearExpenditure { get; set; }
        public string OngoingProgram { get; set; }
        public decimal? FutureFinancialYearExpenditure { get; set; }
        public string TenderCall { get; set; }
        public string ProcurementSystem { get; set; }
        public string IndicativePqcrating { get; set; }
        public string Region { get; set; }
        public string Commentary { get; set; }
        public string TenderType { get; set; }
        public string ProjectEnvironment { get; set; }
        public string IndigenousCommunity { get; set; }
        public string ProjectNumber { get; set; }
        public string Annotations { get; set; }
        public string FinancialYear { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string Electorate { get; set; }
        public string GeneralDepartment { get; set; }
    }
}
