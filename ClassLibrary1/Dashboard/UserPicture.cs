using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace ClassLibrary1.Dashboard
{
    public class UserPicture : SqlConnBridge
    {
        /* Class Field Declaration Area */
        byte[] img_byte = null;

        /* Class Methods Declaration Area */
        public byte[] getPicture(int bmet_id)
        {
            return getUser_Picture(bmet_id);
        }

        protected byte[] getUser_Picture(int bmet_id)
        {
            using (SqlConnection conn = new SqlConnection(SqlConn()))
            {
                string query = "SELECT bp.UserID, bp.Picture FROM BMET_Pic As bp WHERE UserID= @uid";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    cmd.Parameters.Add(new SqlParameter("@uid", bmet_id));

                    SqlDataReader reader = cmd.ExecuteReader();
                    reader.Read();
                    if (reader.HasRows)
                    {
                        byte[] img = (byte[])reader[1];
                        if (img == null)
                        {
                            this.img_byte = null;
                        }
                        else
                        {
                            this.img_byte = img;//imageBytes;                            
                        }
                    }
                    else
                    {
                        img_byte = null;//Return null so default null image can be displayed                        
                    }
                    conn.Close();
                }
                return this.img_byte;
            }
        }
    }
}
