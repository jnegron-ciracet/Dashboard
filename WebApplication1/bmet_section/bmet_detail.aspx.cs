using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using ClassLibrary.Entity;
using ClassLibrary.Business_Logic_Layer;
using System.Windows.Forms;

namespace webapp_reports.Location_By_User
{
    public partial class User_Detail1 : System.Web.UI.Page
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAllUsers();//Fill cmbUsers            
        }
        
        protected void cmbUsers_Init(object sender, EventArgs e)
        {
            EvalQueryString();
        }

        int indexUser;
        static int userID;
        protected void cmbUsers_SelectedIndexChanged(object sender, EventArgs e)
        {            
            indexUser = Int32.Parse(cmbUsers.SelectedIndex.ToString());
            userID = Int32.Parse(cmbUsers.Value.ToString());            

            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getAllUsers();

            lblUserName.Text = list[indexUser].bmet.ToString();
            Get_UserPicture(); //Fill ImgUser with binary value            
            //Get_UserPicture(indexUser);
        }

        #region Methods declaration area
        public void GetAllUsers()
        {
            Location_Bll obj = new Location_Bll();
            cmbUsers.DataSource = obj.getAllUsers();
            cmbUsers.TextField = "bmet";
            cmbUsers.ValueField = "idbmet";
            cmbUsers.DataBind();
        }
        
        public void EvalQueryString()
        {   
            string UID = Request.QueryString["UID"];//Get UID Argument from Query String ?UID

            //Create new instance of getAllUsers() Method
            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getAllUsers();

            //Create new instance of GetUserName Method. Get's user names to be compared with query string value...
            List<string> User = GetUserName();
            Dictionary<string, int> dictionary = new Dictionary<string, int>();
            try
            {
                int i = 0;
                foreach (string value in User)
                {
                    //Add key (User Name) && value (index) to dictionary
                    dictionary.Add(value, i);
                    i++;
                }

                if (dictionary.ContainsKey(UID))
                {
                    cmbUsers.SelectedIndex = dictionary[UID]; //Set index for cmbUsers at page load event
                    lblUserName.Text = list[dictionary[UID]].bmet.ToString(); //Set user name to lblUserName at page load event
                    //int index = cmbUsers.SelectedIndex;
                    Get_UserPicture(dictionary[UID]); //Fill ImgUser with binary value
                }
                else
                {
                    return;
                }
            }
            catch (ArgumentNullException) { }          
        }

        public List<string> GetUserName()
        {            
            string conn_string = "Server=CIRACET-CAMS-01; Database=CiracetNew;Persist Security Info=True;User Id=sa;Password=Ciracet@ponce";
            //List<Location_Entity> list = new List<Location_Entity>();
            List<string> list = new List<string>();
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT	lu.UserID, s.Name + ' ' + s.FirstLastName As 'BMET'" +
                               "FROM	LocationUsers As lu Left Outer Join SecUsers As s On lu.UserID = s.UserID " +
                               //"WHERE s.Name + ' ' + s.FirstLastName =@Name" +
                               "GROUP BY lu.UserID, s.Name, s.FirstLastName " +
                               "ORDER BY BMET";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(reader["BMET"].ToString());                            
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

        public List<string> GetUserID()
        {
            string conn_string = "Server=CIRACET-CAMS-01; Database=CiracetNew;Persist Security Info=True;User Id=sa;Password=Ciracet@ponce";
            //List<Location_Entity> list = new List<Location_Entity>();
            List<string> list = new List<string>();
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT	lu.UserID, s.Name + ' ' + s.FirstLastName As 'BMET'" +
                               "FROM	LocationUsers As lu Left Outer Join SecUsers As s On lu.UserID = s.UserID " +
                    //"WHERE s.Name + ' ' + s.FirstLastName =@Name" +
                               "GROUP BY lu.UserID, s.Name, s.FirstLastName " +
                               "ORDER BY BMET";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            list.Add(reader["UserID"].ToString());
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

        private void Get_UserPicture()
        {
            string conn_string = "Server=CIRACET-CAMS-01; Database=CiracetNew;Persist Security Info=True;User Id=sa;Password=Ciracet@ponce";
            int uid = Int32.Parse(cmbUsers.Value.ToString());
            
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT bp.UserID, bp.Picture FROM BMET_Pic As bp WHERE UserID= @uid";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    cmd.Parameters.Add(new SqlParameter("@UID", uid));

                    SqlDataReader reader = cmd.ExecuteReader();
                    reader.Read();
                    if (reader.HasRows)
                    {
                        byte[] img = (byte[])reader[1];
                        if (img == null)
                        {
                            ImgUser.Value = null;
                        }
                        else
                        {
                            /*
                            const string JPG_ID_BLOCK = "\u00FF\u00D8\u00FF";
                            const int DEFAULT_OLEHEADERSIZE = 78;
                            byte[] imageBytes = null;

                            // Get a UTF7 Encoded string version
                            Encoding u8 = Encoding.UTF7;
                            string strTemp = u8.GetString(img);
                            // Get the first 300 characters from the string
                            string strVTemp = strTemp.Substring(0, 300);
                            // Search for the block
                            int iPos = -1;
                            if (strVTemp.IndexOf(JPG_ID_BLOCK) != -1)
                            {                                
                                iPos = strVTemp.IndexOf(JPG_ID_BLOCK);
                            }
                            // From the position above get the new image
                            if (iPos == -1)
                            {
                                iPos = DEFAULT_OLEHEADERSIZE;                               
                            }                            

                            //Array.Copy(
                            imageBytes = new byte[img.LongLength - iPos];                            
                            MemoryStream ms = new MemoryStream();
                            ms.Write(img, iPos, img.Length - iPos);
                            imageBytes = ms.ToArray();
                            ms.Close();
                            ms.Dispose();
                            */
                            ImgUser.Value = img;//imageBytes;                            
                        }
                    }
                    else
                    {
                        ImgUser.Value = null;//Return null so default null image can be displayed
                        return;
                    }
                    conn.Close();
                }
            }

        }

        private void Get_UserPicture(int index)
        {
            int uid = 0;
            //Create new instance of GetUserName Method. Get's user names to be compared with query string value...
            List<string> User = GetUserID();

            Dictionary<int, string> dictionary = new Dictionary<int, string>();

            try
            {
                int i = 0;
                foreach (string value in User)
                {
                    //Add key (User ID) && value (index) to dictionary
                    dictionary.Add(i, value);
                    i++;
                }

                if (dictionary.ContainsKey(index))
                {
                    uid = Int32.Parse(dictionary[index]);                                        
                }
                else
                {
                    return;
                }
            }
            catch (ArgumentNullException) { }
            
            //Sql Connection String
            string conn_string = "Server=CIRACET-CAMS-01; Database=CiracetNew;Persist Security Info=True;User Id=sa;Password=Ciracet@ponce";            
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT bp.UserID, bp.Picture FROM BMET_Pic As bp WHERE UserID= @uid";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    cmd.Parameters.Add(new SqlParameter("@UID", uid));

                    SqlDataReader reader = cmd.ExecuteReader();
                    reader.Read();
                    if (reader.HasRows)
                    {
                        byte[] img = (byte[])reader[1];
                        if (img == null)
                        {
                            ImgUser.Value = null;
                        }
                        else
                        {                           
                            ImgUser.Value = img;
                        }
                    }
                    else
                    {
                        return;
                    }
                    conn.Close();
                }
            }

        }

        #endregion                                                       
        
    }    
}