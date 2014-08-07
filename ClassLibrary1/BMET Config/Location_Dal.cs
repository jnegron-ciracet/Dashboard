using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using ClassLibrary.Entity;

namespace ClassLibrary.Data_Access_Layer
{
    class Location_Dal
    {
        //Declare global variables
        //public string conn_string = "Server=CIRACETSRV003\\SQLEXPRESS; Database=CiracetDev;Integrated security= true;User Id=ciracet;Password=Ciracet@ponce";
        public string conn_string = "Server=CIRACET-CAMS-01; Database=CiracetNew;Persist Security Info=True;User Id=sa;Password=Ciracet@ponce";
        List<Location_Entity> list = new List<Location_Entity>();

        public List<Location_Entity> Get_User()
        {
            using (SqlConnection conn = new SqlConnection( conn_string ))
            {                
                string query = "SELECT s.Name + s.FirstLastName + s.SecondLastName As 'BMET' " +
                               "FROM LocationUsers As ls INNER JOIN SecUsers As s On ls.UserID = s.UserID " +
                               "GROUP BY s.Name, s.FirstLastName, s.SecondLastName";                

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(new Location_Entity { bmet = reader["BMET"].ToString() });
                        }
                    }
                    finally
                    {
                        reader.Close();
                        conn.Close();
                    }
                }
            }
            return list;
        }

        public List<Location_Entity> Get_AllUsers()
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT	lu.UserID, s.Name + ' ' + s.FirstLastName + ' ' + s.SecondLastName As 'BMET' " +
                               "FROM	LocationUsers As lu Left Outer Join SecUsers As s On lu.UserID = s.UserID " +
                               "GROUP BY lu.UserID, s.Name, s.FirstLastName,  s.SecondLastName " +
                               "ORDER BY BMET";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(new Location_Entity { idbmet = reader["userID"].ToString(), bmet = reader["BMET"].ToString() });
                        }
                    }
                    finally
                    {
                        reader.Close();
                        conn.Close();
                    }
                }
            }
            return list;
        
        }

        public List<Location_Entity> Get_AllBMETUsers()
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT	s.UserID, s.Name + ' ' + s.FirstLastName + ' ' + s.SecondLastName As 'BMET' " +
                               "FROM	SecUsers As s " +
                               "WHERE Active = 1  And isTechnitian = 1 and roleid = 3 And UserID NOT IN (57, 60)" +
                               "ORDER BY BMET";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(new Location_Entity { idbmet = reader["UserID"].ToString(), bmet = reader["BMET"].ToString() });
                        }
                    }
                    finally
                    {
                        reader.Close();
                        conn.Close();
                    }
                }
            }
            return list;
        }

        public List<Location_Entity> Get_UserHospital(int uid) //Get current assigned hospitals for selected user
        {
            using (SqlConnection conn = new SqlConnection( conn_string ))
            {
                string query = "SELECT	lu.IDInstitucion, h.NombreHospital " +
                               "FROM	LocationUsers As lu INNER JOIN Hospital As h On lu.IDInstitucion = h.IDInstitucion " +
                               "WHERE   lu.UserID= @UID " +
                               "GROUP BY lu.IDInstitucion, h.NombreHospital";
                
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add(new SqlParameter("@uid", uid));

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(new Location_Entity { idhospital = reader["IDInstitucion"].ToString(), hospital = reader["NombreHospital"].ToString() });
                        }
                    }
                    finally
                    {
                        reader.Close();
                        conn.Close();
                    }
                }		
            }

            return list;
        }

        public List<Location_Entity> Get_NotAssigned_Hospital() //Get not assigned hospital for selected user
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT ID, Hospital, ByLocation FROM Hospital_ByLocation";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {                    
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(new Location_Entity { idhospital = reader["ID"].ToString(), hospital = reader["Hospital"].ToString(), bylocation = reader["ByLocation"].ToString() });
                        }
                    }
                    finally
                    {
                        reader.Close();
                        conn.Close();
                    }
                }
            }

            return list;
        }

        public List<Location_Entity> Get_Hospitals_With_Location()
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT ID, Hospital FROM Hospital_ByLocation WHERE ByLocation = 1";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(new Location_Entity { idhospital = reader["ID"].ToString(), hospital = reader["Hospital"].ToString() });
                        }
                    }
                    finally
                    {
                        reader.Close();
                        conn.Close();
                    }
                }
            }

            return list;
        }

        public List<Location_Entity> Get_Location()
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT ID, Nombre FROM Location WHERE ID NOT BETWEEN 180 And 227";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {                    
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(new Location_Entity { idlocation = reader["ID"].ToString(), location = reader["Nombre"].ToString() });
                        }
                    }
                    finally
                    {
                        reader.Close();
                        conn.Close();
                    }
                }
            }

            return list;
        }

        public void Insert_Hospital(int idhospital, int idlocation, int uid, string date)
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "INSERT INTO LocationUsers VALUES ( @IDInstitucion, @IDLocation, @UID, @Date )";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {                    
                    cmd.Parameters.Add(new SqlParameter("@IDInstitucion", idhospital));
                    cmd.Parameters.Add(new SqlParameter("@IDLocation", idlocation));
                    cmd.Parameters.Add(new SqlParameter("@UID", uid));
                    cmd.Parameters.Add(new SqlParameter("@Date", date));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }

        public void Insert_Location(int idhospital, int idlocation, int uid, string date)
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "INSERT INTO LocationUsers VALUES ( @IDInstitucion, @IDLocation, @UID, @Date )";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add(new SqlParameter("@IDInstitucion", idhospital));
                    cmd.Parameters.Add(new SqlParameter("@IDLocation", idlocation));
                    cmd.Parameters.Add(new SqlParameter("@UID", uid));
                    cmd.Parameters.Add(new SqlParameter("@Date", date));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }

        public void Remove_Hospital(int uid, int idhospital)
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "DELETE FROM LocationUsers WHERE UserID= @UID AND IDInstitucion= @IDHospital";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add(new SqlParameter("@UID", uid));
                    cmd.Parameters.Add(new SqlParameter("@IDHospital", idhospital));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }

        public void Remove_Location(int uid, int idhospital, int idlocation)
        {
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "DELETE FROM LocationUsers WHERE UserID= @UID AND IDInstitucion= @IDHospital AND IDLocation= @IDLocation";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add(new SqlParameter("@UID", uid));
                    cmd.Parameters.Add(new SqlParameter("@IDHospital", idhospital));
                    cmd.Parameters.Add(new SqlParameter("@IDLocation", idlocation));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }
    }
}
