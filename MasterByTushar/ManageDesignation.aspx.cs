using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using University.Data;
using University.BAL.MasterByTushar;

namespace University.UI.MasterByTushar
{
    public partial class AddDesignation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDept();
                BindGrid(grid_designation.PageSize, grid_designation.PageIndex);
            }
        }
        private void BindDept()
        {
            ddldept.DataSource = ManageDesignationBAL.GetDeptDetails();
            ddldept.DataTextField = "DeptName";
            ddldept.DataValueField = "DeptID";
            ddldept.DataBind();
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string IP = GetVisitorIpAddress();
            Designation_tbl tblDesignation = new Designation_tbl();
            Tuple<Designation_tbl, UniversityEntities> tuple = new Tuple<Designation_tbl, UniversityEntities>(null, null);


            if (btn_submit.Text == "Submit")
            {

                try
                {
                    tblDesignation.CenterID = 1;
                    tblDesignation.DeptID = Convert.ToInt32(ddldept.SelectedValue);
                    tblDesignation.DPost = txtbx_designation.Text;
                    tblDesignation.DArea = txtbx_area.Text;
                    tblDesignation.DDescription = txtbx_jobdesc.Text;
                    tblDesignation.IsBitDeleted = false;
                    tblDesignation.DCreatedby = "Admin";
                    tblDesignation.DCreatedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblDesignation.DCreatedIP = IP;
                    int deptid = ManageDesignationBAL.SaveDesignation(tblDesignation);
                    lblmsg.Text = "Department added sucessfully!!!";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");


                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_designation.PageSize, grid_designation.PageIndex);
                    Clear();
                }
            }
            else if (btn_submit.Text == "Update")
            {
                try
                {
                    tblDesignation.DID = Convert.ToInt32(lbldid.Text);
                    tblDesignation.DeptID = Convert.ToInt32(ddldept.SelectedValue);
                    tblDesignation.DPost = txtbx_designation.Text;
                    tblDesignation.DArea = txtbx_area.Text;
                    tblDesignation.DDescription = txtbx_jobdesc.Text;

                    tblDesignation.DModifiedBy = "Admin";
                    tblDesignation.DModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblDesignation.DModifiedIP = IP;


                    int deptId = ManageDesignationBAL.UpdateDesignation(tblDesignation);
                    lblmsg.Text = "Record Updated Sucessfully";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");

                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_designation.PageSize, grid_designation.PageIndex);
                    Clear();
                }
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

        protected void BindGrid(int pagesize, int pageIndex)
        {
            List<usp_GetDesignation_GetWithPaging_Result> desigantionlist = ManageDesignationBAL.GetDesignationList(pagesize, pageIndex, txtsearch.Text);
            grid_designation.DataSource = desigantionlist;
            grid_designation.PageIndex = pageIndex;
            grid_designation.DataBind();

            if (desigantionlist != null && desigantionlist.Count > 0)
                grdPagger.RecordCount = (int)desigantionlist[0].TotalCount.Value;
            if (grdPagger.PageCount > 1)
                trPagger.Visible = true;
            else
                trPagger.Visible = false;

        }

        protected void grid_designation_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lbldid.Text = Convert.ToString(grid_designation.DataKeys[e.NewEditIndex][0]);
            ddldept.SelectedValue = Convert.ToString(grid_designation.DataKeys[e.NewEditIndex][1]);
            txtbx_designation.Text = Convert.ToString(grid_designation.DataKeys[e.NewEditIndex][3]);
            txtbx_area.Text = Convert.ToString(grid_designation.DataKeys[e.NewEditIndex][4]);
            txtbx_jobdesc.Text = Convert.ToString(grid_designation.DataKeys[e.NewEditIndex][5]);
            btn_submit.Text = "Update";
            e.Cancel = true;
        }

        protected void grid_designation_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int did = Convert.ToInt32(grid_designation.DataKeys[e.RowIndex].Value);
            ManageDesignationBAL.DeleteDesignation(did);
            if (did > 0)
            {
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Designation has been deleted successfully');", true);
            }
            else
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Error occured while deleting Designation');", true);
            BindGrid(grid_designation.PageSize, grid_designation.PageIndex);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid(grid_designation.PageSize, grid_designation.PageIndex);
        }
        private void Clear()
        {
            txtbx_designation.Text = "";
            txtbx_area.Text = "";
            txtbx_jobdesc.Text = "";
            lbldid.Text = "";
            btn_submit.Text = "Submit";
        }

        protected void grdPagger_PageChanged(object sender, EventArgs e)
        {
            grid_designation.PageIndex = grdPagger.CurrentPageIndex - 1;
            BindGrid(grid_designation.PageSize, grid_designation.PageIndex);
        }
    }
}