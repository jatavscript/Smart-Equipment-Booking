using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class NewRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindEquipmentDropdown();
        }
    }

    private void BindEquipmentDropdown()
    {
        try
        {
            using (SqlConnection conn = DbHelper.GetConnection())
            {
                string query = "SELECT Id, Name + ' (' + CAST(AvailableQuantity AS VARCHAR) + ' available)' AS DisplayText FROM Equipment WHERE AvailableQuantity > 0";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlEquipment.DataSource = dt;
                ddlEquipment.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error loading equipment list: " + ex.Message;
        }
    }

    protected void btnSubmitBooking_Click(object sender, EventArgs e)
    {
        string studentName = txtStudentName.Text.Trim();
        int equipmentId = Convert.ToInt32(ddlEquipment.SelectedValue);
        int qty, duration;

        // Validation: No numbers or special characters allowed in Student Name
        if (string.IsNullOrEmpty(studentName) || !Regex.IsMatch(studentName, @"^[a-zA-Z\s]+$"))
        {
            lblMessage.Text = "Student Name must contain only letters and spaces (no numbers).";
            return;
        }

        if (!int.TryParse(txtQuantity.Text, out qty) || !int.TryParse(txtDuration.Text, out duration) || qty <= 0 || duration <= 0)
        {
            lblMessage.Text = "Please enter valid values for Quantity and Duration.";
            return;
        }

        try
        {
            using (SqlConnection conn = DbHelper.GetConnection())
            {
                string query = "INSERT INTO BookingRequests (StudentName, EquipmentId, Quantity, DurationDays, Status, RequestDate) VALUES (@StudentName, @EquipmentId, @Quantity, @Duration, 'Pending', GETDATE())";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@StudentName", studentName);
                cmd.Parameters.AddWithValue("@EquipmentId", equipmentId);
                cmd.Parameters.AddWithValue("@Quantity", qty);
                cmd.Parameters.AddWithValue("@Duration", duration);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("Requests.aspx");
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error submitting request: " + ex.Message;
        }
    }

    protected void btnSubmitEquipment_Click(object sender, EventArgs e)
    {
        string name = txtEqName.Text.Trim();
        string category = ddlCategory.SelectedValue;
        int qty;

        // Validation: No numbers or special characters allowed in Equipment Name
        if (string.IsNullOrEmpty(name) || !Regex.IsMatch(name, @"^[a-zA-Z\s]+$"))
        {
            lblMessage.Text = "Equipment Name must contain only letters and spaces (no numbers).";
            return;
        }

        if (!int.TryParse(txtEqQuantity.Text, out qty) || qty <= 0)
        {
            lblMessage.Text = "Please enter a valid quantity.";
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