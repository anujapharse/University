using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using University.Data;
using University.BAL.MasterByTushar;


//Created By Tushar Solanki      Dated:11-Jan-2013 @17:27 
namespace University.UI.EmployeeRecruitment
{
    public partial class EmployeeEducationalDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FirstGridViewRow();
                Bind();
            }
        }
        private void FirstGridViewRow()
        {
            DataTable dt = new DataTable();
            DataRow dr = null;
            dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            dt.Columns.Add(new DataColumn("Col1", typeof(string)));
            dt.Columns.Add(new DataColumn("Col2", typeof(string)));
            dt.Columns.Add(new DataColumn("Col3", typeof(string)));
            dt.Columns.Add(new DataColumn("Col4", typeof(string)));

            //dr = dt.NewRow();
            //dr["RowNumber"] = 1;
            //dr["Col1"] = string.Empty;
            //dr["Col2"] = string.Empty;
            //dr["Col3"] = string.Empty;
            //dr["Col4"] = string.Empty;

            //dt.Rows.Add(dr);

            ViewState["CurrentTable"] = dt;

            //grid_employeeeducational.DataSource = dt;
            //grid_employeeeducational.DataBind();
        }
        protected void Bind()
        {
            ddl_employeeid.DataSource = ManageEmployeesBAL.GetEmployees();
            ddl_employeeid.DataTextField = "EmployeeID";
            ddl_employeeid.DataValueField = "EmployeeID";
            ddl_employeeid.DataBind();
        }
        protected void btn_Add_Click(object sender, EventArgs e)
        {
            AddNewRow();
        }
        

        private void AddNewRow()
        {
            //int rowIndex = 0;

            if (ViewState["CurrentTable"] != null)
            {
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    for (int i = 0; i < dtCurrentTable.Rows.Count; i++)
                    {
                        TextBox TextBoxDegree = (TextBox)grid_employeeeducational.Rows[i].Cells[1].FindControl("txtbx_degree");
                        TextBox TextBoxInstituteName = (TextBox)grid_employeeeducational.Rows[i].Cells[2].FindControl("txtbx_institutename");
                        TextBox TextBoxPassingYear = (TextBox)grid_employeeeducational.Rows[i].Cells[3].FindControl("txtbx_passingyear");
                        TextBox TextBoxPercentage = (TextBox)grid_employeeeducational.Rows[i].Cells[4].FindControl("txtbx_percentage");

                        dtCurrentTable.Rows[i]["RowNumber"] = i + 1;
                        dtCurrentTable.Rows[i]["Col1"] = TextBoxDegree.Text;
                        dtCurrentTable.Rows[i]["Col2"] = TextBoxInstituteName.Text;
                        dtCurrentTable.Rows[i]["Col3"] = TextBoxPassingYear.Text;
                        dtCurrentTable.Rows[i]["Col4"] = TextBoxPercentage.Text;

                    }
                }    

                        drCurrentRow = dtCurrentTable.NewRow();
                        drCurrentRow["RowNumber"] = dtCurrentTable.Rows.Count+1;
                        drCurrentRow["Col1"] = "";
                        drCurrentRow["Col2"] = "";
                        drCurrentRow["Col3"] = "";
                        drCurrentRow["Col4"] = "";                                   
                    dtCurrentTable.Rows.Add(drCurrentRow);

                    ViewState["CurrentTable"] = dtCurrentTable;

                    grid_employeeeducational.DataSource = dtCurrentTable;
                    grid_employeeeducational.DataBind();
                
            }
            else
            {
                //Response.Write("ViewState is null");
                
            }
            SetPreviousData();
        }
        private void SetPreviousData()
        {
            
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                grid_employeeeducational.DataSource = dt;
                grid_employeeeducational.DataBind();              
                
            }
        }
        public string GetVisitorIpAddress()
        {
            string stringIpAddress;
            stringIpAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (stringIpAddress == null) //may be the HTTP_X_FORWARDED_FOR is null
            {
                stringIpAddress = Request.ServerVariables["REMOTE_ADDR"];//we can use REMOTE_ADDR
            }
            return stringIpAddress;
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
            
            string IP = GetVisitorIpAddress();
            EmployeeEducationalInformation educational_tbl;
            Tuple<EmployeeEducationalInformation, UniversityEntities> tuple;
            try
            {
                foreach (GridViewRow r in grid_employeeeducational.Rows)
                {
                          educational_tbl = new EmployeeEducationalInformation();
                           tuple = new Tuple<EmployeeEducationalInformation, UniversityEntities>(null, null);
                        educational_tbl.EmployeeID = Convert.ToInt32(ddl_employeeid.SelectedValue);
                        educational_tbl.CenterID = 1;
                        educational_tbl.ModificationType = "A";
                        educational_tbl.ModifiedBy = "Admin";
                        educational_tbl.ModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                        educational_tbl.ModifiedIP = IP;
                        educational_tbl.IsActive = true;
                        
                        
                    educational_tbl.Degree = ((TextBox)grid_employeeeducational.Rows[r.RowIndex].Cells[1].FindControl("txtbx_degree")).Text;
                    educational_tbl.InstituteName =( (TextBox)grid_employeeeducational.Rows[r.RowIndex].Cells[2].FindControl("txtbx_institutename")).Text;
                    educational_tbl.Passyear = ((TextBox)grid_employeeeducational.Rows[r.RowIndex].Cells[3].FindControl("txtbx_passingyear")).Text;
                    educational_tbl.Percentage =( (TextBox)grid_employeeeducational.Rows[r.RowIndex].Cells[4].FindControl("txtbx_percentage")).Text;
                     int result = ManageEmployeesBAL.AddEducationalDetails(educational_tbl);
                }

              
               

                EmployeeExperience_tbl experience_tbl = new EmployeeExperience_tbl();
                Tuple<EmployeeExperience_tbl, UniversityEntities> tuple2 = new Tuple<EmployeeExperience_tbl, UniversityEntities>(null, null);
                experience_tbl.CenterID = 1;
                experience_tbl.EmployeeID = Convert.ToInt32(ddl_employeeid.SelectedValue);
                experience_tbl.TotalExp = txtbx_totalexp.Text;
                experience_tbl.LastJobProfile = ddl_jobprofile.SelectedValue;
                experience_tbl.LastSalary = txtbx_salary.Text;
                experience_tbl.PreviousInstitute = txtbx_institute.Text;
                experience_tbl.ModificationType = "A";
                experience_tbl.ModifiedBy = "Admin";
                experience_tbl.ModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                experience_tbl.ModifiedIP = IP;
                experience_tbl.IsActive = true;
                int experienceid = ManageEmployeesBAL.AddExperienceDetails(experience_tbl);
                if (experienceid > 0)
                {
                    this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Record has been added successfully');", true);
                }
                else
                    this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Unable to add the records');", true);

            }
            catch 
            { 
                //Code to handle exception
            }
            finally
            { 
                 
            }
        }
    }
}