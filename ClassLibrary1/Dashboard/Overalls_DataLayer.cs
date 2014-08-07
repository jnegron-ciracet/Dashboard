using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ClassLibrary1.Dashboard
{    
    class Overalls_DataLayer : SqlConnBridge
    {
        /* Class Fields Declaration Area */
        decimal overall = 0;

        public decimal returnOverall(string query)
        {
            getOveralls(query);
            return this.overall;
        }

        private void getOveralls(string query)//Get rows from sql
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
                            overall = Convert.ToDecimal(reader[0]);
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
