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
    public partial class ManageSubject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(grid_subject.PageSize, grid_subject.PageIndex);
            }
        }
        protected void grdPagger_PageChanged(object sender, EventArgs e)
        {
            grid_subject.PageIndex = grdPagger.CurrentPageIndex - 1;
            BindGrid(grid_subject.PageSize, grid_subject.PageIndex);
        }

        protected void BindGrid(int pagesize, int pageIndex)
        {
            List<usp_GetSubject_GetWithPaging_Result> subjectlist = ManageSubjectsBAL.GetDesignationList(pagesize, pageIndex, txtsearch.Text);

            grid_subject.DataSource = subjectlist;
            grid_subject.PageIndex = pageIndex;
            grid_subject.DataBind();

            if (subjectlist != null && subjectlist.Count > 0)
                grdPagger.RecordCount = (int)subjectlist[0].TotalCount.Value;
            if (grdPagger.PageCount > 1)
                trPagger.Visible = true;
            else
                trPagger.Visible = false;

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
            Subject_tbl tblSub = new Subject_tbl();
            Tuple<Subject_tbl, UniversityEntities> tuple = new Tuple<Subject_tbl, UniversityEntities>(null, null);


            if (btn_submit.Text == "Submit")
            {

                try
                {
                    tblSub.SubjectName = txtbx_subname.Text;
                    tblSub.CenterID = 1;
                    tblSub.SubjectType = ddltype.SelectedValue;
                    tblSub.SubjectLang = ddllang.SelectedValue;
                    tblSub.Description = txtbx_subdesc.Text;
                    tblSub.IsBitDeleted = false;
                    tblSub.CreatedBy = "Admin";
                    tblSub.CreateDate = Convert.ToDateTime(System.DateTime.Now);
                    tblSub.CreateIP = IP;
                    int deptid = ManageSubjectsBAL.SaveDesignation(tblSub);
                    lblmsg.Text = "Subjects added sucessfully!!!";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");


                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_subject.PageSize, grid_subject.PageIndex);
                    Clear();
                }
            }
            else if (btn_submit.Text == "Update")
            {
                try
                {
                    tblSub.SubjectID = Convert.ToInt32(lblsubid.Text);
                    tblSub.SubjectName = txtbx_subname.Text;
                    tblSub.SubjectType = ddltype.SelectedValue;
                    tblSub.SubjectLang = ddllang.SelectedValue;
                    tblSub.Description = txtbx_subdesc.Text;

                    tblSub.ModifiedBy = "Admin";
                    tblSub.ModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblSub.ModifiedIP = IP;

                    int subid = ManageSubjectsBAL.UpdateSubject(tblSub);
                    lblmsg.Text = "Record Updated Sucessfully";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");

                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_subject.PageSize, grid_subject.PageIndex);
                    Clear();
                }
            }
        }


        protected void grid_subject_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lblsubid.Text = Convert.ToString(grid_subject.DataKeys[e.NewEditIndex][0]);
            txtbx_subname.Text = Convert.ToString(grid_subject.DataKeys[e.NewEditIndex][2]);
            ddltype.SelectedValue = Convert.ToString(grid_subject.DataKeys[e.NewEditIndex][3]);
            ddllang.Text = Convert.ToString(grid_subject.DataKeys[e.NewEditIndex][4]);
            txtbx_subdesc.Text = Convert.ToString(grid_subject.DataKeys[e.NewEditIndex][5]);
            btn_submit.Text = "Update";
            e.Cancel = true;
        }

        protected void grid_subject_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int subid = Convert.ToInt32(grid_subject.DataKeys[e.RowIndex].Value);
            ManageSubjectsBAL.DeleteSubject(subid);
            if (subid > 0)
            {
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Subject has been deleted successfully');", true);
            }
            else
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Error occured while deleting Subject');", true);
            BindGrid(grid_subject.PageSize, grid_subject.PageIndex);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid(grid_subject.PageSize, grid_subject.PageIndex);
        }
        public void Clear()
        {
            lblsubid.Text = "";
            txtbx_subname.Text = "";
            txtbx_subdesc.Text = "";
            ddllang.SelectedValue = "0";
            ddltype.SelectedValue = "0";
            btn_submit.Text = "Submit";
        }
    }
}