<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Equipment.aspx.cs" Inherits="Equipment" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Equipment - Smart Equipment Booking</title>
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
                    <li><a href="Default.aspx" class="nav-link"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="Equipment.aspx" class="nav-link active"><i class="bi bi-box-seam"></i> Equipment</a></li>
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
                <h1>Equipment</h1>
            </div>

            <!-- Add New Equipment Redirect Link -->
            <div style="margin-bottom: 20px;">
                <a href="NewRequest.aspx?form=equipment" style="color: #4f46e5; font-weight: 700; text-decoration: none; font-size: 14px; display: inline-flex; align-items: center; gap: 6px;">
                    <i class="bi bi-plus-circle-fill"></i> Add New Equipment
                </a>
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="#dc2626" Style="margin-bottom: 12px; display: block; font-weight: 600;" />

            <div class="table-container">
                <asp:GridView ID="gvEquipment" runat="server" CssClass="custom-table" AutoGenerateColumns="false"
                    OnRowCommand="gvEquipment_RowCommand" DataKeyNames="Id" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="NAME" />
                        <asp:BoundField DataField="Category" HeaderText="CATEGORY" />
                        <asp:BoundField DataField="TotalQuantity" HeaderText="TOTAL" />
                        <asp:BoundField DataField="AvailableQuantity" HeaderText="AVAILABLE" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-table btn-red"
                                    CommandName="DeleteItem" CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick="return confirm('Delete this item?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>