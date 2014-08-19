using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1.Dashboard
{
    public class User_BusinessLayer
    {
        /* Class Field Declaration Area */
        List<UserFields> list = null;

        /* Class Constructor */
        public User_BusinessLayer()
        {
            this.list = new List<UserFields>();
        }

        /* Class Methods Declaration Area */
        public List<UserFields> getBMET()
        {
            string query = "Select	s.UserID, s.Name + ' ' + s.FirstLastName As 'BMET' " +
                            "From	LocationUsers lu Left Outer Join " +
                            "SecUsers s On lu.UserID = s.UserID " +
                            "WHERE s.active = 1" +
                            "GROUP BY	s.UserID, s.Name, s.FirstLastName,  s.SecondLastName " +
                            "ORDER BY	BMET";
            User_DataLayer obj = new User_DataLayer();
            this.list = obj.returnFields(query);
            return this.list;
        }
    }
}
