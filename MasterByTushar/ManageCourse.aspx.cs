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
    public partial class ManageCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(grid_course.PageSize, grid_course.PageIndex);
            }
        }
        protected void grdPagger_PageChanged(object sender, EventArgs e)
        {
            grid_course.PageIndex = grdPagger.CurrentPageIndex - 1;
            BindGrid(grid_course.PageSize, grid_course.PageIndex);
        }

        protected void grid_course_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseid = Convert.ToInt32(grid_course.DataKeys[e.RowIndex].Value);
            ManageCourseBAL.DeleteCourse(courseid);
            if (courseid > 0)
            {
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Subject has been deleted successfully');", true);
            }
            else
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Error occured while deleting Subject');", true);
            BindGrid(grid_course.PageSize, grid_course.PageIndex);
        }

        protected void grid_course_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lblid.Text = Convert.ToString(grid_course.DataKeys[e.NewEditIndex][0]);
            ddltype.SelectedValue = Convert.ToString(grid_course.DataKeys[e.NewEditIndex][3]);
            txtbx_coursename.Text = Convert.ToString(grid_course.DataKeys[e.NewEditIndex][2]);
            //txtbx_subjects.Text = Convert.ToString(grid_course.DataKeys[e.NewEditIndex][3]);
            txtbx_duration.Text = Convert.ToString(grid_course.DataKeys[e.NewEditIndex][4]);
            txtbx_desc.Text = Convert.ToString(grid_course.DataKeys[e.NewEditIndex][5]);
            btn_submit.Text = "Update";
            e.Cancel = true;
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string IP = GetVisitorIpAddress();
            Course_tbl tblCourse = new Course_tbl();
            Tuple<Course_tbl, UniversityEntities> tuple = new Tuple<Course_tbl, UniversityEntities>(null, null);

            if (btn_submit.Text == "Submit")
            {

                try
                {
                    tblCourse.CenterID = 1;
                    tblCourse.CourseType = ddltype.SelectedValue;
                    tblCourse.Degree = txtbx_coursename.Text;
                    //tblCourse.CourseSubjects = txtbx_subjects.Text;
                    tblCourse.CourseDuration = txtbx_duration.Text;
                    tblCourse.CourseDesc = txtbx_desc.Text;
                    tblCourse.IsBitDeleted = false;
                    tblCourse.CreatedBy = "Admin";
                    tblCourse.CreatedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblCourse.CreatedIP = IP;
                    int courseid = ManageCourseBAL.SaveCourse(tblCourse);
                    lblmsg.Text = "Course added sucessfully!!!";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");
                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_course.PageSize, grid_course.PageIndex);
                    Clear();
                }
            }

            else if (btn_submit.Text == "Update")
            {
                try
                {                    
                    tblCourse.CourseID = Convert.ToInt32(lblid.Text);
                    tblCourse.CourseType = ddltype.SelectedValue;
                    tblCourse.Degree = txtbx_coursename.Text;
                    //tblCourse.CourseSubjects = txtbx_subjects.Text;
                    tblCourse.CourseDuration = txtbx_duration.Text;
                    tblCourse.CourseDesc = txtbx_desc.Text;

                    tblCourse.ModifiedBy = "Admin";
                    tblCourse.ModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblCourse.ModifiedIP = IP;

                    int subid = ManageCourseBAL.UpdateCourse(tblCourse);
                    lblmsg.Text = "Record Updated Sucessfully";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");
                    Clear();
                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_course.PageSize, grid_course.PageIndex);
                    Clear();
                }
            }
        }
        protected void BindGrid(int pagesize, int pageIndex)
        {
            List<usp_GetCourse_GetWithPaging_Result> courselist = ManageCourseBAL.GetCourseList(pagesize, pageIndex, txtsearch.Text);

            grid_course.DataSource = courselist;
            grid_course.PageIndex = pageIndex;
            grid_course.DataBind();

            if (courselist != null && courselist.Count > 0)
                grdPagger.RecordCount = (int)courselist[0].TotalCount.Value;
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

        public void Clear()
        {
            lblid.Text = "";
            ddltype.SelectedValue = "--Select a Type--";
            txtbx_coursename.Text = "";
            //txtbx_subjects.Text = "";
            txtbx_duration.Text = "";
            txtbx_desc.Text = "";
            btn_submit.Text = "Submit";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid(grid_course.PageSize, grid_course.PageIndex);
        }
    }
}