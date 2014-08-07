using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ClassLibrary1.Return_Lists
{
    public class Entity
    {
        public int id_field { get; set; }
        public string str_field { get; set; }
    }
    public class Fields : SqlConnBridge
    {
        List<Entity> list = null; //Field(type LIST) declaration
        public Fields()
        {
            this.list = new List<Entity>();
        }
        public List<Entity> returnFields(string query)
        {
            getFields(query);
            return this.list;
        }
        private void getFields(string query)
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
                            list.Add(new Entity { id_field = Convert.ToInt32(reader[0].ToString()), str_field = reader[1].ToString() });
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
