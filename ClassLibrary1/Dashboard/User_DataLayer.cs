using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ClassLibrary1.Dashboard
{
    /* Get and Set values for variables */
    public struct UserFields
    {
        public int bmet_id { get; set; }
        public string bmet_name { get; set; }
    }

    class User_DataLayer : SqlConnBridge
    {
        /* Class Fields Declaration Area */
        List<UserFields> bmetList = null;

        /* Class Constructor */
        public User_DataLayer()
        {
            this.bmetList = new List<UserFields>();
        }

        /* Class Methods Declaration Area */
        public List<UserFields> returnFields(string query)//Perform Sql Quey & Return Values
        {
            getbmetList(query);
            return this.bmetList;
        }

        private void getbmetList(string query)//Get rows from sql
        {            
            using (SqlConnection conn = new SqlConnection(SqlConn()))
            {                
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            bmetList.Add(new UserFields { bmet_id = Convert.ToInt32(reader[0].ToString()), bmet_name = reader[1].ToString() });
                        }
                    }
                    finally
                    {
                        reader.Close();
                        conn.Close();
                    }
                }
            }            
        }
    }
}
