using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1.Return_Lists
{
    public class List_BusinessLayer
    {
        List<Entity> list = null;
        public List_BusinessLayer()
        {
            this.list = new List<Entity>();
        }
        public List<Entity> getHospital_Field()
        {
            string query = "SELECT	IDINSTITUCION, NOMBREHOSPITAL " +
                           "FROM	HOSPITAL " +
                           "WHERE	ELIMINADO = 0 AND PM = 1 " +
                           "UNION " +
                           "SELECT 0 AS 'EXPR1', 'ALL' AS EXPR2 " +
                           "ORDER BY NOMBREHOSPITAL";
            Fields fields_obj = new Fields();
            this.list = fields_obj.returnFields(query);

            return this.list;
        }        
    }
}
