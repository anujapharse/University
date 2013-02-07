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
    public partial class ManageClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(grid_class.PageSize, grid_class.PageIndex);
                BindSubjects();
            }
        }
        protected void grdPagger_PageChanged(object sender, EventArgs e)
        {
            grid_class.PageIndex = grdPagger.CurrentPageIndex - 1;
            BindGrid(grid_class.PageSize, grid_class.PageIndex);
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
            List<usp_GetClass_GetWithPaging_Result> classlist = ManageClassBAL.GetClassList(pagesize, pageIndex, txtsearch.Text);

            grid_class.DataSource = classlist;
            grid_class.PageIndex = pageIndex;
            grid_class.DataBind();

            if (classlist != null && classlist.Count > 0)
                grdPagger.RecordCount = (int)classlist[0].TotalCount.Value;
            if (grdPagger.PageCount > 1)
                trPagger.Visible = true;
            else
                trPagger.Visible = false;

        }

        protected void grid_class_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lblid.Text = Convert.ToString(grid_class.DataKeys[e.NewEditIndex][0]);
            txtbx_classname.Text = Convert.ToString(grid_class.DataKeys[e.NewEditIndex][1]);
            txtbx_capacity.Text = Convert.ToString(grid_class.DataKeys[e.NewEditIndex][2]);
            DatePicker1.Text = Convert.ToString(grid_class.DataKeys[e.NewEditIndex][3]);
            txtbx_desc.Text = Convert.ToString(grid_class.DataKeys[e.NewEditIndex][4]);
            btn_submit.Text = "Update";
            e.Cancel = true;
        }

        protected void grid_class_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int classid = Convert.ToInt32(grid_class.DataKeys[e.RowIndex].Value);
            ManageClassBAL.DeleteClass(classid);
            if (classid > 0)
            {
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Class has been deleted successfully');", true);
            }
            else
                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Error occured while deleting Class');", true);
            BindGrid(grid_class.PageSize, grid_class.PageIndex);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid(grid_class.PageSize, grid_class.PageIndex);
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            string IP = GetVisitorIpAddress();
            Class_tbl tblClass = new Class_tbl();
            Tuple<Class_tbl, UniversityEntities> tuple = new Tuple<Class_tbl, UniversityEntities>(null, null);
            tblClass.ClassName = txtbx_classname.Text;
            tblClass.ClassCapacity = txtbx_capacity.Text;
            tblClass.StartDate = Convert.ToDateTime(DatePicker1.Text);
            tblClass.ClassDesc = txtbx_desc.Text;
            tblClass.IsBitDeleted = false;
            tblClass.CreatedBy = "Admin";
            tblClass.CreatedDate = Convert.ToDateTime(System.DateTime.Now);
            tblClass.CreatedIP = IP;

            if (btn_submit.Text == "Submit")
            {

                try
                {
                    for (int i = 0; i < chkbx_subjects.Items.Count; i++)
                    {
                        if (chkbx_subjects.Items[i].Selected)
                        {
                            ClassSubjects_tbl tblClassSub = new ClassSubjects_tbl();
                            Tuple<ClassSubjects_tbl, UniversityEntities> tupleclasssub = new Tuple<ClassSubjects_tbl, UniversityEntities>(null, null);
                            tblClassSub.SubjectID = Convert.ToInt32(chkbx_subjects.Items[i].Value);
                            tblClassSub.CreatedBy = "Admin";
                            tblClassSub.CreatedDate = Convert.ToDateTime(System.DateTime.Now);
                            tblClassSub.CreatedIP = IP;
                            int classsubjectresult = ManageClassBAL.CheckSubjectsForClass(txtbx_classname.Text, tblClassSub.SubjectID);
                            if (classsubjectresult > 0)
                            {
                                this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Subject alreadyexists for the class');", true);
                            }
                            else
                            {
                                int classid = ManageClassBAL.SaveClass_Subjects(tblClass,tblClassSub);
                                lblmsg.Text = "Class added sucessfully!!!";
                                lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");
                            }

                        }
                    }
                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_class.PageSize, grid_class.PageIndex);
                    Clear();
                }
            }
            else if (btn_submit.Text == "Update")
            {
                try
                {
                    tblClass.ClassID = Convert.ToInt32(lblid.Text);
                    tblClass.ClassName = txtbx_classname.Text;
                    tblClass.ClassCapacity = txtbx_capacity.Text;
                    tblClass.StartDate = Convert.ToDateTime(DatePicker1.Text);
                    tblClass.ClassDesc = txtbx_desc.Text;

                    tblClass.ModifiedBy = "Admin";
                    tblClass.ModifiedDate = Convert.ToDateTime(System.DateTime.Now);
                    tblClass.ModifiedIP = IP;

                    int classid = ManageClassBAL.UpdateClass(tblClass);
                    lblmsg.Text = "Record Updated Sucessfully";
                    lblmsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff6230");

                }
                catch
                {
                    //Exception
                }
                finally
                {
                    BindGrid(grid_class.PageSize, grid_class.PageIndex);
                    Clear();
                }
            }
        }

        public void Clear()
        {
            lblid.Text = "";
            txtbx_classname.Text = "";
            txtbx_capacity.Text = "";
            DatePicker1.Text = "";
            txtbx_desc.Text = "";
            btn_submit.Text = "Submit";
        }
        private void BindSubjects()
        {
            chkbx_subjects.DataSource = ManageClassBAL.GetSubjects();
            chkbx_subjects.DataTextField = "SubjectName";
            chkbx_subjects.DataValueField = "SubjectID";
            chkbx_subjects.DataBind();
        }

    }
}