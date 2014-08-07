using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ClassLibrary1.Return_String
{            
    public class strField : SqlConnBridge
    {
        string str_field = null;

        public string return_strField(string query)
        {
            getFields(query);
            return this.str_field;
        }
        private void getFields(string query)
        {
            using (SqlConnection conn = new SqlConnection(SqlConn()))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    //SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        this.str_field = (string)cmd.ExecuteScalar();
                    }
                    finally
                    {                        
                        conn.Close();
                    }
                }
            }
        }
    }
    
}
