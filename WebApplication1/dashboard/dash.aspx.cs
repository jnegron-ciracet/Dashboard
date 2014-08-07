using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using ClassLibrary1.Dashboard;
using ClassLibrary1.Return_Lists;
using ClassLibrary1.Return_String;


namespace WebApplication1.dashboard
{
    public partial class dash : System.Web.UI.Page
    {
        //Class field declaration...
        User_BusinessLayer bmet = new User_BusinessLayer();
        List<UserFields> userList = null;
        UserPicture bmet_picture = new UserPicture();

        static int index = 0;   //Index for USERLIST

        public dash()
        {
            this.userList = bmet.getBMET();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getHospital();
                setOverall();

                //Specify current date
                lblMonth1.Text = DateTime.Now.ToString("MMMM");
                lblMonth2.Text = DateTime.Now.ToString("MMMM");

                getUser();
                setUser();
            }            
        }
        
        //Manage Control NATIVE property based on device screen
        protected void cmbHospital_Load(object sender, EventArgs e)
        {
            int screen = Convert.ToInt32(hidden_screenwidth.Value);

            if (screen > 1023)
            {
                cmbHospital.Native = false;
            }
            else
            {
                cmbHospital.Native = true;
            }
        }
        protected void cmbHospital_SelectedIndexChanged(object sender, EventArgs e)
        {            
            //Update Interactive Charts
            SqlDataSource7.SelectParameters["hospital"].DefaultValue = selectedHospitalValue();
            SqlDataSource4.SelectParameters["hospital"].DefaultValue = selectedHospitalValue();
            SqlDataSource5.SelectParameters["hospital"].DefaultValue = selectedHospitalValue();
            WebChartControl4.DataBind();
            WebChartControl5.DataBind();
            WebChartControl7.DataBind();

            //Update overalls
            setOverall();
        }
        //Manage Control NATIVE property based on device screen
        protected void cmbUser_Load(object sender, EventArgs e)
        {
            int screen = Convert.ToInt32(hidden_screenwidth.Value);

            if (screen > 1023)
            {
                cmbUser.Native = false;
            }
            else
            {
                cmbUser.Native = true;
            }
        }
        protected void cmbUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            index = cmbUser.SelectedIndex;
            setUser();

        }
        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {            
            //Resize charts at page_load
            this.WebChartControl1.Width = new Unit(hidden_rsz1.Value);
            this.WebChartControl2.Width = new Unit(hidden_rsz2.Value);
            this.WebChartControl3.Width = new Unit(hidden_chrt1Width.Value);
            this.WebChartControl4.Width = new Unit(hidden_chrt2Width.Value);
            this.WebChartControl5.Width = new Unit(hidden_chrt3Width.Value);
            this.WebChartControl6.Width = new Unit(hidden_chrt5Width.Value);
            this.WebChartControl7.Width = new Unit(hidden_chrt1Width.Value);
        }
        protected void UpdatePanel2_Load(object sender, EventArgs e)
        {            
            //Show/Hide chrt1_summary/chrt1_detail
            if (selectedHospitalValue() != "0")
            {
                chrt1_summary.Visible = false;
                chrt1_detail.Visible = true;
            }
            else
            {
                chrt1_summary.Visible = true;
                chrt1_detail.Visible = false;
            }
        }        
        protected void UpdatePanel3_Load(object sender, EventArgs e)
        {            
            switch (hdn_index.Value)
            {                
                case "-1":                    
                    index--;
                    if (index < 0)
                    {
                        index = userList.Count() - 1;
                    }
                    setUser();
                    break;
                case "+1":
                    index++;
                    if (index > userList.Count() - 1)
                    {
                        index = 0;
                    }
                    setUser();
                    break;
                default :
                    setUser();
                    break;
            }            
        }        

        #region Custom Methods
        private void getHospital()
        {
            List_BusinessLayer list_obj = new List_BusinessLayer();
            cmbHospital.DataSource = list_obj.getHospital_Field();
            cmbHospital.TextField = "str_field";
            cmbHospital.ValueField = "id_field";
            cmbHospital.DataBind();
            cmbHospital.SelectedIndex = 0;            
        }
        private void getUser()
        {
            User_BusinessLayer list_obj = new User_BusinessLayer();
            cmbUser.DataSource = list_obj.getBMET();
            cmbUser.TextField = "bmet_name";
            cmbUser.ValueField = "bmet_id";
            cmbUser.DataBind();
            cmbUser.SelectedIndex = 0;
        }
        private string selectedHospitalValue()
        {
            string value = cmbHospital.Value.ToString();
            return value;
        }
        private void setOverall()
        {
            Overalls_BusinessLayer objOverall = new Overalls_BusinessLayer();
            /*TOP SECTION OVERALL */
            lblOpenPM.Text = objOverall.getOpenedPMs(30).ToString();           //Current Month Opened PMs
            lblOpenedPriorities.Text = objOverall.getOpenedPMs(31).ToString(); //Current Month Opened PMs Priorities
            lblPendingPickUp1.Text = objOverall.getPendingPickUp().ToString(); //Total Pending PickUp
            lblOpenedWO.Text = objOverall.getOpenedWO().ToString();            //All Opened WO

            /*CHART HEADER OVERALL */
            String_BusinessLayer objString = new String_BusinessLayer();
            //Set selected hospital name
            if (selectedHospitalValue() == "0")
            {
                lblSelectedHospital.Text = "All";
            }
            else
            {
                lblSelectedHospital.Text = objString.getHospital_Name(selectedHospitalValue());
            }

            //Set selected hospital overall
            if (selectedHospitalValue() == "0")
            {
                lblPMCompliance.Text = objOverall.getPMComplianceOverall("0").ToString();//All hospitals overall
            }
            else
            {
                lblPMCompliance.Text = objOverall.getHospitalYTDOverall(selectedHospitalValue()).ToString();//Selected hospital overall
            }
                        
            lblMonthlyPMCompliance2.Text = objOverall.getPMComplianceOverall(selectedHospitalValue()).ToString();       //Monthly PM Compliance Percentage
            lblYTDPriorityCompliance.Text = objOverall.getYTDPrioritiesCompliance(selectedHospitalValue()).ToString();  //YTD Priority Compliance Percentage
        }
        private void setUser()
        {
            Overalls_BusinessLayer objOverall = new Overalls_BusinessLayer();

            ASPxBinaryImage1.Value = bmet_picture.getPicture(this.userList[index].bmet_id);                 //User Picture
            lblUserName.Text = " " + this.userList[index].bmet_name.ToString();                             //User Name
            lblUserOverall.Text = objOverall.getUserCompliance(this.userList[index].bmet_id).ToString();    //User Overall
            SqlDataSource1.SelectParameters[0].DefaultValue = this.userList[index].bmet_id.ToString();      //User Chart1
            SqlDataSource2.SelectParameters[0].DefaultValue = this.userList[index].bmet_id.ToString();      //User Chart2
        }
        #endregion                                
        
    }
}