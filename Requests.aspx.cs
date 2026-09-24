using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Requests : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    private void BindGrid()
    {
        try
        {
            using (SqlConnection conn = DbHelper.GetConnection())
            {
                // Updated query using StudentName instead of UserId
                string sql = @"
                    SELECT 
                        r.Id,
                        r.StudentName,
                        e.Name AS EquipmentName,
                        r.Quantity,
                        r.DurationDays,
                        r.Status,
                        r.RequestDate
                    FROM BookingRequests r
                    INNER JOIN Equipment e ON r.EquipmentId = e.Id
                    ORDER BY r.RequestDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRequests.DataSource = dt;
                gvRequests.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error loading bookings: " + ex.Message;
        }
    }

    protected void gvRequests_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Approve" || e.CommandName == "Reject" || e.CommandName == "ReturnItem")
        {
            int requestId = Convert.ToInt32(e.CommandArgument);
            string newStatus = e.CommandName == "Approve" ? "Approved" : (e.CommandName == "Reject" ? "Rejected" : "Returned");

            try
            {
                using (SqlConnection conn = DbHelper.GetConnection())
                {
                    conn.Open();

                    // 1. Update status in BookingRequests
                    string updateSql = "UPDATE BookingRequests SET Status = @Status WHERE Id = @Id";
                    SqlCommand cmd = new SqlCommand(updateSql, conn);
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@Id", requestId);
                    cmd.ExecuteNonQuery();

                    // 2. Adjust available stock on Equipment
                    if (e.CommandName == "Approve")
                    {
                        string reduceStock = @"
                            UPDATE Equipment 
                            SET AvailableQuantity = AvailableQuantity - r.Quantity 
                            FROM Equipment e 
                            INNER JOIN BookingRequests r ON e.Id = r.EquipmentId 
                            WHERE r.Id = @Id";
                        SqlCommand cmdStock = new SqlCommand(reduceStock, conn);
                        cmdStock.Parameters.AddWithValue("@Id", requestId);
                        cmdStock.ExecuteNonQuery();
                    }
                    else if (e.CommandName == "ReturnItem")
                    {
                        string restoreStock = @"
                            UPDATE Equipment 
                            SET AvailableQuantity = AvailableQuantity + r.Quantity 
                            FROM Equipment e 
                            INNER JOIN BookingRequests r ON e.Id = r.EquipmentId 
                            WHERE r.Id = @Id";
                        SqlCommand cmdStock = new SqlCommand(restoreStock, conn);
                        cmdStock.Parameters.AddWithValue("@Id", requestId);
                        cmdStock.ExecuteNonQuery();
                    }
                }

                BindGrid();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating request: " + ex.Message;
            }
        }
    }
}