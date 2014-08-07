using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClassLibrary.Entity;
using ClassLibrary.Business_Logic_Layer;


namespace webapp_reports.Location_By_User
{
    public partial class User_Detail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {                                  
            GetHospital();  //Fill Hospital            
            GetLocation2(); //Fill Location2
            GetAllUsers();  //Fill cmbUsers         
        }

        protected void cmbUsers_Init(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EvalQueryString();
            }           
        }

        protected void cmbUsers_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {               
                Get_UserPicture();//Fill ImgUser with binary value
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            //Clear Cmb Controls
            cmbHospital.SelectedIndex = -1;
            cmbLocation2.SelectedIndex = -1;
        }

        static int indexUser;
        static int userID;
        static string bmet;
        protected void cmbUsers_SelectedIndexChanged(object sender, EventArgs e)
        {                        
            indexUser = Int32.Parse(cmbUsers.SelectedIndex.ToString());
            userID = Int32.Parse(cmbUsers.Value.ToString());

            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getAllBMETUsers();

            bmet = list[indexUser].bmet.ToString();
            lblUserName.Text = list[indexUser].bmet.ToString();

            Get_UserPicture();//Fill ImgUser with binary value
                        
        }                

        #region Add | Remove Hospital
        //Declare global static variables for Hospital Add | Remove
        public static int indexHospital;
        public static int idHospital;
        public static string hospital;
        public static int idLocation;
        public static int byLocation;

        protected void cmbHospital_SelectedIndexChanged(object sender, EventArgs e)
        {
            #region Get idHospital, indexHospital & byLocation values. Hide || Show cmbLocation
            
            idHospital = Int32.Parse(cmbHospital.Value.ToString());            
            indexHospital = Int32.Parse(cmbHospital.SelectedIndex.ToString());

            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getNotAssignedHospital();
            
            byLocation = Int32.Parse(list[indexHospital].bylocation.ToString());
            
            try
            {                                
                //If by location == 1 then show cmbLocation
                switch (byLocation)
                {
                    case 0:
                        hiddenByLocation.Value = "0";
                        break;
                    case 1:                                                
                        hiddenByLocation.Value = "1";
                        break;
                }
            }
            catch (ArgumentOutOfRangeException)
            {
            }             
            #endregion
        }

        protected void cmbLocation1_SelectedIndexChanged(object sender, EventArgs e)
        {
            idLocation = Int32.Parse(cmbLocation1.Value.ToString());
        }

        protected void btnHospital_Add_Click(object sender, EventArgs e)
        {   
            #region Save Hospital
           
            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getNotAssignedHospital();            
            try
            {
                if (cmbHospital.SelectedIndex > -1 && byLocation == 0)
                {
                    userID = Int32.Parse(cmbUsers.Value.ToString());//Get User ID From cmbUser
                    obj.insertHospital(idHospital, 0, userID, DateTime.Today.ToString());                    
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Hospital has been saved sucessfully!')", true);
                    
                    //Clear Cmb Controls
                    cmbHospital.SelectedIndex = -1;
                    cmbLocation1.SelectedIndex = -1;

                    ASPxGridView1.DataBind();//Bind grid data
                }
                else if (cmbHospital.SelectedIndex > -1 && byLocation == 1)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showPopLocation()", true);//Call javascript function
                }
                else if (cmbHospital.SelectedIndex < 0)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Please, select an hospital!')", true);
                    return;
                }
                else
                {
                    return;
                }
            }
            catch (SqlException ex)
            {
                Location_Bll obj_User = new Location_Bll();
                List<Location_Entity> lstName = obj.getAllBMETUsers();
                if (ex.Message.Contains("Violation of PRIMARY KEY constraint"))                    
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Hospital already assigned')", true);
                return;
            }            
            #endregion 
        }

        protected void btnHospital_Remove_Click(object sender, EventArgs e)
        {
            #region Remove Hospital by idHospital && idUser

            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getNotAssignedHospital();

            hospital = list[indexHospital].hospital.ToString(); //Get selected hospital name.            

            if (cmbHospital.SelectedIndex > -1)
            {
                /*DialogResult result1 = MessageBox.Show("Remove " + hospital + "?", "Important Question",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);*/
                
                userID = Int32.Parse(cmbUsers.Value.ToString());//Get User ID From cmbUser
                obj.removeHospital(userID, idHospital);                
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Hospital was removed succesfully!')", true);

                cmbHospital.SelectedIndex = -1;
                ASPxGridView1.DataBind();
                
            }
            else
            {                
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Please, select an hospital!')", true);
            }
            #endregion                             
        }

        protected void popLocation_Load(object sender, EventArgs e)
        {
            GetLocation1();//Fill Location1
        }  

        protected void btnSaveLocation_Click(object sender, EventArgs e)
        {
            #region Save Hospital && Location
            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getNotAssignedHospital();

            try
            {
                if (cmbLocation1.SelectedIndex > -1)
                {
                    userID = Int32.Parse(cmbUsers.Value.ToString());//Get User ID From cmbUser
                    obj.insertHospital(idHospital, idLocation, userID, DateTime.Today.ToString());                    
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Hospital & Location had been saved sucessfully!')", true);
                    //Clear Cmb Controls
                    cmbHospital.SelectedIndex = -1;
                    cmbLocation1.SelectedIndex = -1;                   

                    //Close pop-up
                    popLocation.ShowOnPageLoad = false;
                    cmbHospital.SelectedIndex = -1;
                    
                    //Refresh GridView
                    ASPxGridView1.DataBind();
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Please select a location for this hospital.')", true);
                    return;
                }
            }
            catch (SqlException ex)
            {                
                if (ex.Message.Contains("Violation of PRIMARY KEY constraint"))                    
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Hospital & Location already assigned.')", true);
                return;
            }
            #endregion 
        }
        #endregion

        #region Add | Remove Location

        //Declare static global variables for Location Add | Remove        
        static int indexLocation;
        static int idLocation2;
        static int idHospital2;

        protected void cmbLocation2_SelectedIndexChanged(object sender, EventArgs e)
        {
            hiddenLocation2Index.Value = cmbLocation2.SelectedIndex.ToString();
            indexLocation = Int32.Parse(cmbLocation2.SelectedIndex.ToString());
            idLocation2 = Int32.Parse(cmbLocation2.Value.ToString());

            if (cmbLocation2.SelectedIndex > -1)
            {
                hiddenOpenPopRemove.Value = "1";
            }
            else
            {
                hiddenOpenPopRemove.Value = "0";
            }
        }

        protected void btnLocation_Add_Click(object sender, EventArgs e)
        {            
            if (cmbLocation2.SelectedIndex < 0)
            {                
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Please, select an location!')", true);
                return;
            }
            else if (cmbLocation2.SelectedIndex > 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showPopHospital()", true);//Call javascript function
            }
            else
            {
                return;
            }
        }
        
        protected void btnLocationl_Remove_Click(object sender, EventArgs e)
        {            
            if (cmbLocation2.SelectedIndex < 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Please, select an location!')", true);
                hiddenOpenPopRemove.Value = "0";
                return;
            }
            else
            {
                hiddenOpenPopRemove.Value = "1";//Trigger to show PopRemoveLocation
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showPopRemoveHospital()", true);//Call javascript function                
            }                       
        }

        protected void popHospital_Load(object sender, EventArgs e)
        {
            GetHospital2();
        }

        protected void popRemoveLocation_Load(object sender, EventArgs e)
        {
            Location_Bll obj = new Location_Bll();
            cmbHospital3.DataSource = obj.getHospitalsWithLocation();
            cmbHospital3.TextField = "hospital";
            cmbHospital3.ValueField = "idhospital";
            cmbHospital3.DataBind();
        }

        protected void btnRemoveLocation_Click(object sender, EventArgs e)
        {
            #region Remove Location by idLocation, idHospital && userID

            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getLocation();

            string location = list[indexLocation].location.ToString(); //Get selected hospital name.            

            if (cmbHospital3.SelectedIndex > -1)
                
            {                                
                userID = Int32.Parse(cmbUsers.Value.ToString());//Get User ID From cmbUser
                idHospital = Int32.Parse(cmbHospital3.Value.ToString());

                obj.removeLocation(userID, idHospital, idLocation2);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Location was removed sucessfully!')", true);

                hiddenOpenPopRemove.Value = "0";
                cmbLocation2.SelectedIndex = -1;
                popRemoveLocation.ShowOnPageLoad = false;

                //Refresh GridView
                ASPxGridView1.DataBind();                               
            }
            else
            {                
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Please select an Hospital.')", true);
                return;
            }
            #endregion
        }        

        protected void btnSaveHospital_Click(object sender, EventArgs e)
        {
            #region Save Location With Hospital
            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getNotAssignedHospital();

            try
            {
                if (cmbHospital2.SelectedIndex > -1)
                {
                    idHospital2 = Int32.Parse(cmbHospital2.Value.ToString()); //Get value from cmbHospital2 on pop-up

                    userID = Int32.Parse(cmbUsers.Value.ToString());//Get User ID From cmbUser
                    obj.insertLocation(idHospital2, idLocation2, userID, DateTime.Today.ToString());
                    
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Location for current hospital has been saved sucessfully!')", true);

                    cmbHospital2.SelectedIndex = -1;

                    //Close pop-up
                    popHospital.ShowOnPageLoad = false;
                    cmbLocation2.SelectedIndex = -1;

                    //Refresh GridView
                    ASPxGridView1.DataBind();
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Please select a hospital for this location')", true);
                    return;
                }
            }
            catch (SqlException ex)
            {                              
                if (ex.Message.Contains("Violation of PRIMARY KEY constraint"))
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Msg", "alert('Location & Hospital already assigned!')", true);

                return;
            }
            #endregion
        }
        #endregion

        #region Methods declaration area 

        public void EvalQueryString()
        {            
            Location_Bll obj = new Location_Bll();
            List<Location_Entity> list = obj.getAllUsers();
            try
            {
                int userIndex = Int32.Parse(Request.QueryString["UID"]);
                cmbUsers.SelectedIndex = Compare_UserID_ToFindIndex(userIndex);//Call method to get index
                lblUserName.Text = list[userIndex].bmet.ToString();
                Get_UserPicture(userIndex);//Fill ImgUser with binary value
            }
            catch (ArgumentNullException) { }
        }

        public void GetHospital()
        {
            Location_Bll obj = new Location_Bll();
            cmbHospital.DataSource = obj.getNotAssignedHospital();
            cmbHospital.TextField = "hospital";
            cmbHospital.ValueField = "idhospital";
            cmbHospital.DataBind();
        }

        public void GetHospital2()
        {
            Location_Bll obj = new Location_Bll();
            cmbHospital2.DataSource = obj.getHospitalsWithLocation();
            cmbHospital2.TextField = "hospital";
            cmbHospital2.ValueField = "idhospital";
            cmbHospital2.DataBind();
        }

        public void GetLocation1()
        {
            Location_Bll obj = new Location_Bll();
            cmbLocation1.DataSource = obj.getLocation();
            cmbLocation1.TextField = "location";
            cmbLocation1.ValueField = "idlocation";
            cmbLocation1.DataBind();
        }

        public void GetLocation2()
        {
            Location_Bll obj = new Location_Bll();
            cmbLocation2.DataSource = obj.getLocation();
            cmbLocation2.TextField = "location";
            cmbLocation2.ValueField = "idlocation";
            cmbLocation2.DataBind();
        }

        public void GetAllUsers()
        {
            Location_Bll obj = new Location_Bll();
            cmbUsers.DataSource = obj.getAllBMETUsers();
            cmbUsers.TextField = "bmet";
            cmbUsers.ValueField = "idbmet";
            cmbUsers.DataBind();            
        }

        public List<string> GetUserID()
        {
            string conn_string = "Server=CIRACETSRV002\\CIRACETSRV002; Database=CiracetNew;Integrated security= true;User Id=ciracet;Password=Ciracet@ponce";
            //List<Location_Entity> list = new List<Location_Entity>();
            List<string> list = new List<string>();
            using (SqlConnection conn = new SqlConnection(conn_string))
            {
                string query = "SELECT	lu.UserID, s.Name + ' ' + s.FirstLastName As 'BMET'" +
                               "FROM	LocationUsers As lu Left Outer Join SecUsers As s On lu.UserID = s.UserID " +                    
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

            string conn_string = "Server=CIRACETSRV002\\CIRACETSRV002; Database=CiracetNew;Integrated security= true;User Id=ciracet;Password=Ciracet@ponce";
            int uid = Int32.Parse(cmbUsers.Value.ToString());
            byte[] img = null;//value to be returned

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
                        img = (byte[])reader[1];
                        
                        if (img == null)
                        {
                            ImgUser.Value = null;
                        }
                        else
                        {                            
                            ImgUser.Value = img;//imageBytes;
                        }                         
                    }
                    else
                    {                        
                        ImgUser.Value = null; //Return null so default null image can be displayed                        
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
            string conn_string = "Server=CIRACETSRV002\\CIRACETSRV002; Database=CiracetNew;Integrated security= true;User Id=ciracet;Password=Ciracet@ponce";
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

        private int Compare_UserID_ToFindIndex(int qsIndex)
        {
            int indx = 0;//Returned value
            int i = 0;//Incremental variable
            string uid = null;
            int k = 0;//Incremental variable

            try
            {
                List<string> list = GetUserID();//Populate list with UserID's From LocationUsers Table
                Dictionary<int, string> dictionary = new Dictionary<int, string>();//Create dictionary that will hold <index, UserID>

                foreach (string value in list)
                {
                    dictionary.Add(i, value);
                    i++;
                }
                if (dictionary.ContainsKey(qsIndex))
                {
                    uid = dictionary[qsIndex];
                }
                //Once I get uid from LocationUsers based on index then...
                Location_Bll obj = new Location_Bll();
                List<Location_Entity> lstUserID = obj.getAllBMETUsers();//Populate list with UserID's From SecUsers Table
                List<string> idbmet = lstUserID //Get idbmet field from lstUserID
                                        .Select(j => j.idbmet)
                                        .ToList();
                Dictionary<string, int> dc = new Dictionary<string, int>();
                foreach (string value in idbmet)
                {
                    dc.Add(value, k);
                    k++;
                }

                if (dc.ContainsKey(uid))
                {
                    indx = dc[uid];
                }
                //...get index from selected value
            }
            catch (ArgumentNullException) { }
            return indx;
        }

        #endregion                                                                        
    }
}