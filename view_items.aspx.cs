using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TodoList
{
    public partial class view_items : System.Web.UI.Page
    {
        string seq = null;
        string title = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            seq = Request.QueryString["id"];
            if (!IsPostBack)
            {
                string ConnectStr = ConfigurationManager.AppSettings["ConnectionString"];

                SqlConnection Con = new SqlConnection(ConnectStr);
                Con.Open();
                SqlCommand Cmd = new SqlCommand();
                Cmd.Connection = Con;
                Cmd.CommandText =
                    "select l.[work] as '할 일', l.success as '성취도' l.listname" +
                    "from list_item_todo l " +
                    "inner join list_todo a " +
                    "on l.owner = a.Tuser " +
                    "where and a.id=@seq and l.listname = a.tltle";

                Cmd.Parameters.Add("@seq", SqlDbType.Int);
                Cmd.Parameters["@seq"].Value = seq;

                SqlDataReader reader = Cmd.ExecuteReader();
                reader.Read();

                title = reader["listname"].ToString();

                SqlDataAdapter adp = new SqlDataAdapter(Cmd);
                DataSet dsitem = new DataSet();
                adp.Fill(dsitem, "list_item_todo");

                lits_items.DataSource = dsitem;
                lits_items.DataBind();

                lblLink.Text += seq;
            }
        }

        protected void btnreturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/listPage.aspx");
        }

        protected void isSucceed_CheckedChanged(object sender, EventArgs e)
        {
            string ConnectStr = ConfigurationManager.AppSettings["ConnectionString"];
            CheckBox cb = (CheckBox)sender;
            DataGridItem row = (DataGridItem)cb.NamingContainer;
            int rowIndex = row.ItemIndex;
            DataGridItem item = lits_items.Items[rowIndex];

            SqlConnection Con = new SqlConnection(ConnectStr);
            Con.Open();
            SqlCommand Cmd = new SqlCommand();
            Cmd.Connection = Con;
            Cmd.CommandText =
                "UPDATE list_item_todo SET [success]=@biit where id IN (SELECT id FROM list_todo WHERE id = @id) and [work] LIKE @con";

            Cmd.Parameters.Add("@id", SqlDbType.Int);
            Cmd.Parameters.Add("@biit", SqlDbType.Bit);
            Cmd.Parameters.Add("@con", SqlDbType.Text);

            Cmd.Parameters["@id"].Value = seq;

            try
            {
                Cmd.Parameters["@biit"].Value = cb.Checked;
                Cmd.Parameters["@con"].Value = item.Cells[0].Text;
                Cmd.ExecuteNonQuery();

                /*Response.Write($"<script>alert();</script>");*/
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Con.Close();
            }
        }
    }
}