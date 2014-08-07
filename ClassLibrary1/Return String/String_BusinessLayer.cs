using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1.Return_String
{
    public class String_BusinessLayer
    {
        String name = null;
        
        public string getHospital_Name(string hospital)
        {
            string query = "Select InicialesHospital From Hospital Where idInstitucion = " + hospital;

            strField strField_obj = new strField();

            this.name = strField_obj.return_strField(query);
            return this.name;
        }
    }
}
