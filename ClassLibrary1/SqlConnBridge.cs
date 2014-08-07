using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1
{
    public abstract class SqlConnBridge
    {
        //CIRALAP005\\SQLEXPRESS
        //Server=CIRACETSRV002\\CIRACETSRV002; Database=CiracetNew;Integrated security= true;User Id=ciracet;Password=Ciracet@ponce
        //Server=CIRACET-CAMS-01; Database=CiracetNew;Persist Security Info=True;User Id=sa;Password=Ciracet@ponce
        private static string sqlconn = "Server=CIRACET-CAMS-01; Database=CiracetNew;Persist Security Info=True;User Id=sa;Password=Ciracet@ponce";
        public static string SqlConn()
        {
            return sqlconn;
        }
    }
}
