<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRequest.aspx.cs" Inherits="NewRequest" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>New Booking & Equipment - Smart Equipment Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/site.css" />
    <style>
        .tab-container {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
        }
    </style>
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
                    <li><a href="Default.aspx" class="nav-link"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="Equipment.aspx" class="nav-link"><i class="bi bi-box-seam"></i> Equipment</a></li>
                    <li><a href="Requests.aspx" class="nav-link"><i class="bi bi-calendar-check"></i> Bookings</a></li>
                    <li><a href="NewRequest.aspx" class="nav-link active"><i class="bi bi-plus-circle"></i> New </a></li>
                </ul>
            </div>
            <div class="sidebar-footer">
                Panel · v1.0
            </div>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1 id="pageTitle">New Booking</h1>
            </div>

            <!-- Tab Navigation for Switching Forms -->
            <div class="tab-container">
                <button type="button" id="btnTabBooking" class="tab-btn active" onclick="showForm('booking')">
                    <i class="bi bi-calendar-plus"></i> New Booking
                </button>
                <button type="button" id="btnTabEquipment" class="tab-btn" onclick="showForm('equipment')">
                    <i class="bi bi-box-seam"></i> Add New Equipment
                </button>
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="#dc2626" Style="margin-bottom: 12px; display: block; font-weight: 600;" />

           <!-- Form 1: New Booking Request -->
<div id="bookingForm" class="form-card">
    <div class="form-group">
        <label>STUDENT NAME</label>
        <asp:TextBox ID="txtStudentName" runat="server" CssClass="form-control" placeholder="Enter full name" />
        <asp:RegularExpressionValidator 
            ID="revStudentName" 
            runat="server" 
            ControlToValidate="txtStudentName" 
            ValidationExpression="^[a-zA-Z\s]+$" 
            ErrorMessage="Student Name must contain only letters and spaces." 
            ForeColor="#dc2626" 
            Display="Dynamic" 
            Style="font-size: 12px; font-weight: 600; margin-top: 4px;" />
    </div>

    <div class="form-group">
        <label>EQUIPMENT</label>
        <asp:DropDownList ID="ddlEquipment" runat="server" CssClass="form-control" DataTextField="DisplayText" DataValueField="Id" />
    </div>

    <div class="form-group">
        <label>QUANTITY</label>
        <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Text="1" CssClass="form-control" />
    </div>

    <div class="form-group">
        <label>DURATION (DAYS)</label>
        <asp:TextBox ID="txtDuration" runat="server" TextMode="Number" Text="1" CssClass="form-control" />
    </div>

    <asp:Button ID="btnSubmitBooking" runat="server" Text="Submit Request" OnClick="btnSubmitBooking_Click" CssClass="btn-submit" />
</div>

<!-- Form 2: Add New Equipment -->
<div id="equipmentForm" class="form-card" style="display: none;">
    <div class="form-group">
        <label>EQUIPMENT NAME</label>
        <asp:TextBox ID="txtEqName" runat="server" CssClass="form-control" placeholder="e.g. Football" />
        <asp:RegularExpressionValidator 
            ID="revEqName" 
            runat="server" 
            ControlToValidate="txtEqName" 
            ValidationExpression="^[a-zA-Z\s]+$" 
            ErrorMessage="Equipment Name must contain only letters and spaces." 
            ForeColor="#dc2626" 
            Display="Dynamic" 
            Style="font-size: 12px; font-weight: 600; margin-top: 4px;" />
    </div>

    <div class="form-group">
        <label>CATEGORY</label>
        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
            <asp:ListItem Text="Sports" Value="Sports" />
            <asp:ListItem Text="Lab" Value="Lab" />
            <asp:ListItem Text="Electronics" Value="Electronics" />
            <asp:ListItem Text="Event" Value="Event" />
            <asp:ListItem Text="Library" Value="Library" />
        </asp:DropDownList>
    </div>

    <div class="form-group">
        <label>TOTAL QUANTITY</label>
        <asp:TextBox ID="txtEqQuantity" runat="server" TextMode="Number" CssClass="form-control" placeholder="e.g. 10" />
    </div>

    <asp:Button ID="btnSubmitEquipment" runat="server" Text="Save Equipment" OnClick="btnSubmitEquipment_Click" CssClass="btn-submit" />
</div>
        </div>
    </form>

    <script type="text/javascript">
        function showForm(type) {
            var bookingForm = document.getElementById('bookingForm');
            var equipmentForm = document.getElementById('equipmentForm');
            var btnBooking = document.getElementById('btnTabBooking');
            var btnEquipment = document.getElementById('btnTabEquipment');
            var pageTitle = document.getElementById('pageTitle');

            if (type === 'equipment') {
                bookingForm.style.display = 'none';
                equipmentForm.style.display = 'block';
                btnBooking.className = 'tab-btn';
                btnEquipment.className = 'tab-btn active';
                pageTitle.innerText = 'Add New Equipment';
            } else {
                bookingForm.style.display = 'block';
                equipmentForm.style.display = 'none';
                btnBooking.className = 'tab-btn active';
                btnEquipment.className = 'tab-btn';
                pageTitle.innerText = 'New Booking';
            }
        }

        // Auto-select tab if redirected with ?form=equipment parameter
        window.onload = function () {
            var urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('form') === 'equipment') {
                showForm('equipment');
            }
        };
    </script>
</body>
</html>