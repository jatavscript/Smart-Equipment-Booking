using System;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCounts();
        }
    }

    private void LoadCounts()
    {
        using (SqlConnection conn = DbHelper.GetConnection())
        {
            conn.Open();

            SqlCommand cmdEquip = new SqlCommand("SELECT COUNT(*) FROM Equipment", conn);
            lblEquipmentCount.Text = cmdEquip.ExecuteScalar().ToString();

            SqlCommand cmdPending = new SqlCommand("SELECT COUNT(*) FROM BookingRequests WHERE Status = 'Pending'", conn);
            lblPendingCount.Text = cmdPending.ExecuteScalar().ToString();

            SqlCommand cmdApproved = new SqlCommand("SELECT COUNT(*) FROM BookingRequests WHERE Status = 'Approved'", conn);
            lblApprovedCount.Text = cmdApproved.ExecuteScalar().ToString();
        }
    }
}
