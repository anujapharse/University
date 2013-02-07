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
    public partial class ManageDepartments : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(gvdept.PageSize, gvdept.PageIndex);
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            string IP = GetVisitorIpAddress();
            Department_tbl tblDept = new Department_tbl();
            Tuple<Department_tbl, UniversityEntities> tuple = new Tuple<Department_tbl, UniversityEntities>(null, null);


            if (btn_submit.Text == "Submit")
            {

                try
                {
                    tblDept.CenterID = 1;
                    tblDept.DeptRoomID = Convert.ToInt32(txtbx_roomid.Text);
                    tblDept.DeptName = txtbx_deptname.Text;
                    tblDept.DeptDesc = txtbx_desc.Text;

                    tblDept.IsBitDeleted = false;
                    tblDept.CreatedBy = "Admin";
                    tblDept.CreatedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblDept.CreatedIP = IP;
                    int deptid = ManageDepartmentBAL.SaveDepartment(tblDept);
                    lblmsg.Text = "Department added sucessfully!!!";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");
                    Clear();

                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(gvdept.PageSize, gvdept.PageIndex);
                }
            }
            else if (btn_submit.Text == "Update")
            {
                try
                {
                    tblDept.DeptID = Convert.ToInt32(lbldeptid.Text);
                    tblDept.DeptRoomID = Convert.ToInt32(txtbx_roomid.Text);
                    tblDept.DeptName = txtbx_deptname.Text;
                    tblDept.DeptDesc = txtbx_desc.Text;
                    tblDept.CreatedBy = lblcreator.Text;
                    tblDept.CreatedDate = Convert.ToDateTime(lblcreatedate.Text);
                    tblDept.CreatedIP = lblCreateIP.Text;
                    tblDept.ModifiedBy = "Admin";
                    tblDept.ModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblDept.ModifiedIP = IP;

                    int deptId = ManageDepartmentBAL.UpdateDept(tblDept);
                    lblmsg.Text = "Record Updated Sucessfully";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");
                    Clear();
                    btn_submit.Text = "Submit";
                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(gvdept.PageSize, gvdept.PageIndex);
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
            List<usp_GetDepartment_GetWithPaging_Result> deptlist = ManageDepartmentBAL.GetDepartmentList(pagesize, pageIndex, txtsearch.Text);
            gvdept.DataSource = deptlist;
            gvdept.PageIndex = pageIndex;
            gvdept.DataBind();

            if (deptlist != null && deptlist.Count > 0)
                grdPagger.RecordCount = (int)deptlist[0].TotalCount.Value;
            if (grdPagger.PageCount > 1)
                trPagger.Visible = true;
            else
                trPagger.Visible = false;

        }
        protected void grdPagger_PageChanged(object sender, EventArgs e)
        {
            gvdept.PageIndex = grdPagger.CurrentPageIndex - 1;
            BindGrid(gvdept.PageSize, gvdept.PageIndex);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid(gvdept.PageSize, gvdept.PageIndex);
        }

        protected void gvdept_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lbldeptid.Text = Convert.ToString(gvdept.DataKeys[e.NewEditIndex][0]);
            txtbx_roomid.Text = Convert.ToString(gvdept.DataKeys[e.NewEditIndex][1]);
            txtbx_deptname.Text = Convert.ToString(gvdept.DataKeys[e.NewEditIndex][2]);
            txtbx_desc.Text = Convert.ToString(gvdept.DataKeys[e.NewEditIndex][3]);
            lblcreator.Text = Convert.ToString(gvdept.DataKeys[e.NewEditIndex][4]);
            lblcreatedate.Text = Convert.ToString(gvdept.DataKeys[e.NewEditIndex][5]);
            lblCreateIP.Text = Convert.ToString(gvdept.DataKeys[e.NewEditIndex][6]);
            btn_submit.Text = "Update";
            e.Cancel = true;

        }
        public void Clear()
        {
            lbldeptid.Text = "";
            lblcreator.Text = "";
            lblcreatedate.Text = "";
            lblCreateIP.Text = "";
            txtbx_roomid.Text = "";
            txtbx_deptname.Text = "";
            txtbx_desc.Text = "";
        }

        protected void btn_canel_Click(object sender, EventArgs e)
        {
            Clear();
            lblmsg.Text = "";
        }



        protected void gvdept_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int deptid = Convert.ToInt32(gvdept.DataKeys[e.RowIndex].Value);
            ManageDepartmentBAL.DeleteDepartment(deptid);
            if (deptid > 0)
            {
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Department has been deleted successfully');", true);
            }
            else
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Error occured while deleting Department');", true);
            BindGrid(gvdept.PageSize, gvdept.PageIndex);
        }
    }
}