using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Data7001WebTool.data
{
    public class Geometry
    {
        public string type { get; set; }
        public List<List<List<double>>> coordinates { get; set; }
    }

    public class Properties
    {
        public string NAME { get; set; }
        public int ID { get; set; }
        public double SHAPE_Leng { get; set; }
        public double SHAPE_Area { get; set; }
    }

    public class Feature
    {
        public string type { get; set; }
        public Geometry geometry { get; set; }
        public Properties properties { get; set; }
    }

    public class Root
    {
        public string type { get; set; }
        public List<Feature> features { get; set; }
    }
}
