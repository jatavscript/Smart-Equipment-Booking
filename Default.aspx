<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Dashboard - Smart Equipment Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/site.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="sidebar">
            <div>
                <div class="brand">
                    <div class="brand-icon"><i class="bi bi-box-seam-fill"></i></div>
                    <div class="brand-text">
                        <h2>SEB</h2>
                        <span>EQUIPMENT BOOKING</span>
                    </div>
                </div>
                <ul class="nav-list">
                    <li><a href="Default.aspx" class="nav-link active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="Equipment.aspx" class="nav-link"><i class="bi bi-box-seam"></i> Equipment</a></li>
                    <li><a href="Requests.aspx" class="nav-link"><i class="bi bi-calendar-check"></i> Bookings</a></li>
                    <li><a href="NewRequest.aspx" class="nav-link"><i class="bi bi-plus-circle"></i> New </a></li>
                </ul>
            </div>
            <div class="sidebar-footer">
                Panel · v1.0
            </div>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1>Dashboard</h1>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblEquipmentCount" runat="server" Text="0" /></div>
                    <div class="stat-label">EQUIPMENT ITEMS</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblPendingCount" runat="server" Text="0" /></div>
                    <div class="stat-label">PENDING REQUESTS</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblApprovedCount" runat="server" Text="0" /></div>
                    <div class="stat-label">CURRENTLY BORROWED</div>
                </div>
            </div>

            <div class="action-grid">
                <a href="Equipment.aspx" class="btn-action"><i class="bi bi-box-seam"></i> Manage Equipment</a>
                <a href="Requests.aspx" class="btn-action"><i class="bi bi-calendar-check"></i> Manage Requests</a>
                <a href="NewRequest.aspx" class="btn-action"><i class="bi bi-plus-circle"></i> Submit Request</a>
            </div>
        </div>
    </form>
</body>
</html>