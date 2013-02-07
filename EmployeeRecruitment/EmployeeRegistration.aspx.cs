using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using University.BAL.MasterByTushar;
using University.Data;
using System.Net.Mail;

namespace University.UI.Management
{
    public partial class FacultyRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDesignation();
                BindDepartment();
            }
        }
        private void BindDesignation()
        {
            ddl_designation.DataSource = ManageDesignationBAL.GetDesignationListForDropDownList();
            ddl_designation.DataTextField = "DPost";
            ddl_designation.DataValueField = "DID";
            ddl_designation.DataBind();
        }
        private void BindDepartment()
        {
            ddl_departmentid.DataSource = ManageDepartmentBAL.GetDepartmentListForDropDownList();
            ddl_departmentid.DataTextField = "DeptName";
            ddl_departmentid.DataValueField = "DeptID";
            ddl_departmentid.DataBind();
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            try
            {   //Checking the which checkbox is selected 
                string gender;
                if (chkmale.Checked)
                {
                    gender = "M";
                }
                else
                {
                    gender = "F";
                }
                //Calling Method GetVisitorIpAddress to track the users IP
                string IP = GetVisitorIpAddress();
                //Creating an object of the PersonalDetails_tbl class of the entity framework which represents a tab
                PersonalDetails_tbl personal_tbl = new PersonalDetails_tbl();
                Tuple<PersonalDetails_tbl, UniversityEntities> tuple = new Tuple<PersonalDetails_tbl, UniversityEntities>(null, null);

                personal_tbl.CenterID = 1;
                personal_tbl.PFirstName = txtbx_firstname.Text;
                personal_tbl.PMiddleName = txtbx_middlename.Text;
                personal_tbl.PLastName = txtbx_lastname.Text;
                personal_tbl.PDob = Convert.ToDateTime(txt_dob.Text);
                personal_tbl.PGender = gender;
                personal_tbl.PNationality = txtbx_Nationality.Text;
                personal_tbl.PReligion = txtbx_religion.Text;
                personal_tbl.PCaste = txtbx_caste.Text;
                personal_tbl.PContactNo = txtbx_contactno.Text;
                personal_tbl.PMobileNo = txtbx_Mobile.Text;
                personal_tbl.PEmailId = txtbx_email.Text;
                personal_tbl.PAddress = txtbx_address.Text;
                personal_tbl.PBloodGroup = ddl_bloodgroup.SelectedValue;
                personal_tbl.PCreatedby = "Admin";
                personal_tbl.PCreatedDate = Convert.ToDateTime(System.DateTime.Now);
                personal_tbl.PCreatedIP = IP;
                personal_tbl.IsBitDeleted = false;

                int personid = ManageEmployeesBAL.SavePersonDetails(personal_tbl);
                if (personid > 0)
                {
                    EmployeeDetails_tbl employee_tbl = new EmployeeDetails_tbl();
                    Tuple<EmployeeDetails_tbl, UniversityEntities> tuple2 = new Tuple<EmployeeDetails_tbl, UniversityEntities>(null, null);

                    employee_tbl.PersonalID = personid;
                    employee_tbl.DID = Convert.ToInt32(ddl_designation.SelectedValue);
                    employee_tbl.DeptID = Convert.ToInt32(ddl_departmentid.SelectedValue);
                    employee_tbl.CenterID = 1;
                    employee_tbl.FJoiningDate = Convert.ToDateTime(DatePicker1.Text);
                    employee_tbl.FJobType = ddl_jobtype.SelectedValue;
                    employee_tbl.FRecruitmentType = ddl_recruitmenttype.SelectedValue;
                    employee_tbl.FCreatedBy = "Admin";
                    employee_tbl.FCreatedate = Convert.ToDateTime(System.DateTime.Now);
                    employee_tbl.FCreatedIP = IP;
                    employee_tbl.IsBitDeleted = false;
                    int employeeid = ManageEmployeesBAL.SaveEmployeeDetails(employee_tbl);
                    if (employeeid > 0)
                    {
                        string LoginID = ManageEmployeesBAL.GenerateLoginID();
                        UserMaster_Tbl login_tbl = new UserMaster_Tbl();
                        Tuple<UserMaster_Tbl, UniversityEntities> tuple3 = new Tuple<UserMaster_Tbl, UniversityEntities>(null, null);

                        login_tbl.UserId = LoginID;
                        login_tbl.Password = LoginID;
                        login_tbl.FullName = txtbx_firstname.Text + " " + txtbx_middlename.Text + " " + txtbx_lastname.Text;
                        login_tbl.IsActive = true;
                        login_tbl.RoleId = Convert.ToInt32(ddl_designation.SelectedValue);
                        login_tbl.CreatedBy = "Admin";
                        login_tbl.CreatedOn = Convert.ToDateTime(System.DateTime.Now);
                        string loginresult = ManageEmployeesBAL.CreateEmployeeLogin(login_tbl);
                        if (loginresult != null)
                        {
                            // Create a MailMessage object which represents an Email message
                            MailMessage mail = new MailMessage();

                            //Using MailMessage body trying to add receipt
                            //MailMessage.To is to represent the receipt
                            //Add is to make a list of receipt
                            mail.To.Add(txtbx_email.Text);

                            //mail.From object is used to initial the email id from which the mail is to be send and MailAddress represents the adress of the sender
                            mail.From = new MailAddress("nonreply360@gmail.com");

                            mail.Subject = "Login Information";
                            DateTime sysdate = System.DateTime.Now;
                            //mail.Body is used to construct the body of the mail
                            mail.Body = "Login Information for" + " " + login_tbl.FullName + " .Created at " + sysdate + "<br/><br/>User ID: " + LoginID + "<br/><br/>" + "Password: " + LoginID;

                            //mail.IsBodyHtml is to check whether the body contains html 
                            mail.IsBodyHtml = true;
                            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                            //smtp.Host = "smtp.gmail.com"; //Or Your SMTP Server Address
                            smtp.Credentials = new System.Net.NetworkCredential
                                 ("nonreply360@gmail.com", "nonreply12");
                            //Or your Smtp Email ID and Password
                            smtp.EnableSsl = true;
                            try
                            {

                                smtp.Send(mail);
                                //Clear1();
                            }
                            catch
                            {
                                //some feedback if it does not work
                                
                            }
                        }
                        else
                        {
 
                        }


                        this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Employee added sucessfully');", true);

                    }
                    else
                    {
                        this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Unable to add Employee Details');", true);
                    }
                }
                else
                {
                    this.Page.ClientScript.RegisterStartupScript(GetType(), "ShowAlert", "alert('Unable to add Employee and Personal Details');", true);
                }

            }
            catch
            {
                //Exception
            }
            finally
            {

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
    }
}