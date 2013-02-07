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
    public partial class BatchSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBatch();
                BindGrid(grid_batchschedule.PageSize, grid_batchschedule.PageIndex);
            }
        }

        private void BindBatch()
        {
            ddlbatchid.DataSource = ManageBatchBAL.GetBatchDetails();
            ddlbatchid.DataTextField = "BatchName";
            ddlbatchid.DataValueField = "BatchID";
            ddlbatchid.DataBind();
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
            TimeSpan starttime = TimeSpan.Parse(txtbx_starttime.Text);
            TimeSpan endtime = TimeSpan.Parse(txtbx_endtime.Text);

            string IP = GetVisitorIpAddress();
            BatchSchedule_tbl tblBatchSchedule = new BatchSchedule_tbl();
            Tuple<BatchSchedule_tbl, UniversityEntities> tuple = new Tuple<BatchSchedule_tbl, UniversityEntities>(null, null);

            if (btn_submit.Text == "Submit")
            {

                try
                {
                    tblBatchSchedule.BatchID = Convert.ToInt32(ddlbatchid.SelectedValue);
                    tblBatchSchedule.CenterID = 1;
                    tblBatchSchedule.BatchDay = ddldays.SelectedValue;
                    tblBatchSchedule.BatchStartTime = starttime;
                    tblBatchSchedule.BatchEndTime = endtime;
                    tblBatchSchedule.IsBitDeleted = false;
                    tblBatchSchedule.CreatedBy = "Admin";
                    tblBatchSchedule.CreatedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblBatchSchedule.CreatedIP = IP;
                    int deptid = ManageBatchBAL.SaveBatchSchedule(tblBatchSchedule);
                    lblmsg.Text = "Batch Schedule added sucessfully!!!";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");


                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_batchschedule.PageSize, grid_batchschedule.PageIndex);
                    //Clear();
                }
            }
            else if (btn_submit.Text == "Update")
            {
                try
                {
                    tblBatchSchedule.BatchScheduleID = Convert.ToInt32(lblid.Text);
                    tblBatchSchedule.BatchID = Convert.ToInt32(ddlbatchid.SelectedValue);
                    tblBatchSchedule.BatchDay = ddldays.SelectedValue;
                    tblBatchSchedule.BatchStartTime = starttime;
                    tblBatchSchedule.BatchEndTime = endtime;

                    tblBatchSchedule.ModifiedBy = "Admin";
                    tblBatchSchedule.ModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblBatchSchedule.ModifiedIP = IP;


                    int deptId = ManageBatchBAL.UpdateBatchSchedule(tblBatchSchedule);
                    lblmsg.Text = "Record Updated Sucessfully";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");

                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_batchschedule.PageSize, grid_batchschedule.PageIndex);
                    //Clear();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
        protected void BindGrid(int pagesize, int pageIndex)
        {
            List<usp_GetBatchSchedule_GetWithPaging_Result> desigantionlist = ManageBatchBAL.GetBatchScheduleList(pagesize, pageIndex);
            grid_batchschedule.DataSource = desigantionlist;
            grid_batchschedule.PageIndex = pageIndex;
            grid_batchschedule.DataBind();

            if (desigantionlist != null && desigantionlist.Count > 0)
                grdPagger.RecordCount = (int)desigantionlist[0].TotalCount.Value;
            if (grdPagger.PageCount > 1)
                trPagger.Visible = true;
            else
                trPagger.Visible = false;

        }

        protected void grid_batchschedule_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int batchscheduleid = Convert.ToInt32(grid_batchschedule.DataKeys[e.RowIndex].Value);
            ManageBatchBAL.DeleteBatchSchedule(batchscheduleid);
            if (batchscheduleid > 0)
            {
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Batch Schedule has been deleted successfully');", true);
            }
            else
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Error occured while deleting Batch Schedule');", true);
            BindGrid(grid_batchschedule.PageSize, grid_batchschedule.PageIndex);
        }

        protected void grid_batchschedule_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lblid.Text = Convert.ToString(grid_batchschedule.DataKeys[e.NewEditIndex][0]);
            ddlbatchid.SelectedValue = Convert.ToString(grid_batchschedule.DataKeys[e.NewEditIndex][2]);
            ddldays.SelectedValue = Convert.ToString(grid_batchschedule.DataKeys[e.NewEditIndex][3]);
            txtbx_starttime.Text = Convert.ToString(grid_batchschedule.DataKeys[e.NewEditIndex][4]);
            txtbx_endtime.Text = Convert.ToString(grid_batchschedule.DataKeys[e.NewEditIndex][5]);
            btn_submit.Text = "Update";
            e.Cancel = true;
        }

       
    }
}