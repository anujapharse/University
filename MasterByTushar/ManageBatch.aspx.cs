using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using University.BAL.MasterByTushar;
using University.Data;

namespace University.UI.MasterByTushar
{
    public partial class ManageBatch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(grid_batch.PageSize, grid_batch.PageIndex);
                BindClass();
                BindCourse();

            }
        }
        protected void grdPagger_PageChanged(object sender, EventArgs e)
        {
            grid_batch.PageIndex = grdPagger.CurrentPageIndex - 1;
            BindGrid(grid_batch.PageSize, grid_batch.PageIndex);
        }
        protected void BindGrid(int pagesize, int pageIndex)
        {
            List<usp_GetBatch_GetWithPaging_Result> batchlist = ManageBatchBAL.GetBatchList(pagesize, pageIndex, txtsearch.Text);

            grid_batch.DataSource = batchlist;
            grid_batch.PageIndex = pageIndex;
            grid_batch.DataBind();

            if (batchlist != null && batchlist.Count > 0)
                grdPagger.RecordCount = (int)batchlist[0].TotalCount.Value;
            if (grdPagger.PageCount > 1)
                trPagger.Visible = true;
            else
                trPagger.Visible = false;
        }
        private void BindClass()
        {
            ddlclass.DataSource = ManageBatchBAL.GetClassDetails();
            ddlclass.DataTextField = "ClassName";
            ddlclass.DataValueField = "ClassID";
            ddlclass.DataBind();
        }
        private void BindCourse()
        {
            ddlcourseid.DataSource = ManageBatchBAL.GetCourseDetails();
            ddlcourseid.DataTextField = "Degree";
            ddlcourseid.DataValueField = "CourseID";
            ddlcourseid.DataBind();
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string IP = GetVisitorIpAddress();
            Batch_tbl tblBatch = new Batch_tbl();
            Tuple<Batch_tbl, UniversityEntities> tuple = new Tuple<Batch_tbl, UniversityEntities>(null, null);
            
            if (btn_submit.Text == "Submit")
            {

                try
                {
                    tblBatch.CenterID = 1;
                    tblBatch.BatchName = txtbx_batchname.Text;
                    tblBatch.ClassID = Convert.ToInt32(ddlclass.SelectedValue);
                    tblBatch.CourseID = Convert.ToInt32(ddlcourseid.SelectedValue);
                    tblBatch.StartDate = Convert.ToDateTime(DatePicker1.Text);
                    tblBatch.BDesc = txtbx_desc.Text;
                    tblBatch.IsBitDeleted = false;
                    tblBatch.CreatedBy = "Admin";
                    tblBatch.CreatedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblBatch.CreatedIP = IP;
                    int deptid = ManageBatchBAL.SaveBatch(tblBatch);
                    lblmsg.Text = "Batch added sucessfully!!!";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");


                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_batch.PageSize, grid_batch.PageIndex);
                    Clear();
                }
            }
            else if (btn_submit.Text == "Update")
            {
                try
                {
                    tblBatch.BatchID = Convert.ToInt32(lblid.Text);
                    tblBatch.BatchName = txtbx_batchname.Text;
                    tblBatch.ClassID = Convert.ToInt32(ddlclass.SelectedValue);
                    tblBatch.CourseID = Convert.ToInt32(ddlcourseid.SelectedValue);
                    tblBatch.StartDate = Convert.ToDateTime(DatePicker1.Text);
                    tblBatch.BDesc = txtbx_desc.Text;

                    tblBatch.ModifiedBy = "Admin";
                    tblBatch.ModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblBatch.ModifiedIP = IP;

                    int subid = ManageBatchBAL.UpdateBatch(tblBatch);
                    lblmsg.Text = "Record Updated Sucessfully";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");

                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_batch.PageSize, grid_batch.PageIndex);
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid(grid_batch.PageSize, grid_batch.PageIndex);
        }

        protected void grid_batch_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int batchid = Convert.ToInt32(grid_batch.DataKeys[e.RowIndex].Value);
            ManageBatchBAL.DeleteBatch(batchid);
            if (batchid > 0)
            {
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Batch has been deleted successfully');", true);
            }
            else
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Error occured while deleting Batch');", true);
            BindGrid(grid_batch.PageSize, grid_batch.PageIndex);
        }

        protected void grid_batch_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lblid.Text = Convert.ToString(grid_batch.DataKeys[e.NewEditIndex][0]);            
            ddlcourseid.SelectedValue = Convert.ToString(grid_batch.DataKeys[e.NewEditIndex][2]);
            txtbx_batchname.Text = Convert.ToString(grid_batch.DataKeys[e.NewEditIndex][3]);
            ddlclass.SelectedValue = Convert.ToString(grid_batch.DataKeys[e.NewEditIndex][4]);
            DatePicker1.Text = Convert.ToString(grid_batch.DataKeys[e.NewEditIndex][5]);
            txtbx_desc.Text = Convert.ToString(grid_batch.DataKeys[e.NewEditIndex][6]);
            e.Cancel = true;
            btn_submit.Text = "Update";
        }

        public void Clear()
        {
            lblid.Text = "";
            txtbx_batchname.Text = "";
            ddlclass.SelectedIndex = 0;
            ddlcourseid.SelectedIndex = 0;
            DatePicker1.Text = "";
            txtbx_desc.Text = "";
            btn_submit.Text = "Submit";
        }



    }
}