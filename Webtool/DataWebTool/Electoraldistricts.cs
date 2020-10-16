using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace DataWebTool.dbs863472
{
    public partial class Electoraldistricts
    {
        [NotMapped]
        public string Coordinates { get; set; }
    }
}
