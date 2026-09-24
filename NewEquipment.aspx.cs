using System;
using System.Data.SqlClient;

public partial class NewEquipment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string category = ddlCategory.SelectedValue;
        int qty;

        if (string.IsNullOrEmpty(name) || !int.TryParse(txtQuantity.Text, out qty) || qty <= 0)
        {
            lblMessage.Text = "Please fill in all fields with valid values.";
            return;
        }

        try
        {
            using (SqlConnection conn = DbHelper.GetConnection())
            {
                string query = "INSERT INTO Equipment (Name, Category, TotalQuantity, AvailableQuantity) VALUES (@Name, @Category, @Qty, @Qty)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Qty", qty);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("Equipment.aspx");
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error saving equipment: " + ex.Message;
        }
    }
}