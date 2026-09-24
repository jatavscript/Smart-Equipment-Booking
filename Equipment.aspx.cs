using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Equipment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindEquipmentList();
        }
    }

    private void BindEquipmentList()
    {
        try
        {
            using (SqlConnection conn = DbHelper.GetConnection())
            {
                string query = "SELECT Id, Name, Category, TotalQuantity, AvailableQuantity FROM Equipment ORDER BY Name";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvEquipment.DataSource = dt;
                gvEquipment.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error loading equipment: " + ex.Message;
        }
    }

    protected void gvEquipment_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteItem")
        {
            int equipmentId = Convert.ToInt32(e.CommandArgument);

            try
            {
                using (SqlConnection conn = DbHelper.GetConnection())
                {
                    string query = "DELETE FROM Equipment WHERE Id = @Id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", equipmentId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                BindEquipmentList();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error deleting equipment: " + ex.Message;
            }
        }
    }
}