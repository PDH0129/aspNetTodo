using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

namespace TodoList
{
    public partial class logIN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private bool checkingValidate()
        {
            if (txtmail.Text.Trim() == "" || txtpwd.Text.Trim() == "")
            {
                Response.Write("<script>alert(올바른 계정 및 비밀번호를 입력하세요.)</script>");
                return false;
            }
            else
            {
                return true;
            }
        }

        protected void btnUp_Click(object sender, EventArgs e)  // 회원가입
        {
            if (!checkingValidate()) return;
            
            string query = "Insert into Uinfo_todo(Tmail, Tpwd) values(@mail, @pwd) ";
            if (connectDB(query))
            {
                Session["email"] = txtmail.Text.Trim();
                Session["pwd"] = txtpwd.Text.Trim();
                Response.Redirect("~/listPage.aspx");
            }
        }

        protected void btnIn_Click(object sender, EventArgs e) // 로그인
        {
            if (!checkingValidate()) return;

            string query = "select * from Uinfo_todo where Tmail = @mail and Tpwd = @pwd";
            if (connectDB(query))
            {
                Session["email"] = txtmail.Text.Trim();
                Session["pwd"] = txtpwd.Text.Trim();
                Response.Redirect("~/listPage.aspx");
            }
        }

        private bool connectDB(string query)
        {
            string ConnectStr = ConfigurationManager.AppSettings["ConnectionString"];
            SqlConnection conn = new SqlConnection(ConnectStr);
            SqlCommand Cmd = new SqlCommand();
            Cmd.Connection = conn;
            Cmd.CommandText
                = query;

            Cmd.Parameters.Add("@mail", System.Data.SqlDbType.VarChar, 80);
            Cmd.Parameters.Add("@pwd", System.Data.SqlDbType.VarChar, 30);

            Cmd.Parameters["@mail"].Value = txtmail.Text.Trim();
            Cmd.Parameters["@pwd"].Value = txtpwd.Text.Trim();

            try
            {
                conn.Open();

                if(query.Contains("select"))
                {
                    SqlDataReader reader = Cmd.ExecuteReader();
                    int i = 0;
                    while(reader.Read()) { i++; }
                    if (i != 1)
                        return false;
                }
                else
                {
                    Cmd.ExecuteNonQuery();
                    //Response.Redirect("List.aspx");
                }

                return true;
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert({ex.Message})</script>");
                return false;
            }
            finally
            {
                conn.Close();
                Cmd = null;
            }
        }
    }
}