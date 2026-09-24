<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Requests.aspx.cs" Inherits="Requests" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Bookings - Smart Equipment Booking</title>
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
                    <li><a href="Equipment.aspx" class="nav-link"><i class="bi bi-box-seam"></i> Equipment</a></li>
                    <li><a href="Requests.aspx" class="nav-link active"><i class="bi bi-calendar-check"></i> Bookings</a></li>
                    <li><a href="NewRequest.aspx" class="nav-link"><i class="bi bi-plus-circle"></i> New </a></li>
                </ul>
            </div>
            <div class="sidebar-footer">
                Panel · v1.0
            </div>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1>Bookings</h1>
            </div>

            <!-- Submit New Request Redirect Link -->
            <div style="margin-bottom: 20px;">
                <a href="NewRequest.aspx" style="color: #4f46e5; font-weight: 700; text-decoration: none; font-size: 14px; display: inline-flex; align-items: center; gap: 6px;">
                    <i class="bi bi-plus-circle-fill"></i> Submit New Request
                </a>
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="#dc2626" Style="margin-bottom: 12px; display: block; font-weight: 600;" />

            <div class="table-container">
                <asp:GridView ID="gvRequests" runat="server" CssClass="custom-table" AutoGenerateColumns="false"
                    OnRowCommand="gvRequests_RowCommand" DataKeyNames="Id" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="StudentName" HeaderText="STUDENT" />
                        <asp:BoundField DataField="EquipmentName" HeaderText="EQUIPMENT" />
                        <asp:BoundField DataField="Quantity" HeaderText="QTY" />
                        <asp:TemplateField HeaderText="DURATION">
                            <ItemTemplate>
                                <%# Eval("DurationDays") %> day(s)
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="STATUS">
                            <ItemTemplate>
                                <span class='badge badge-<%# Eval("Status").ToString().ToLower() %>'>
                                    &bull; <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="RequestDate" HeaderText="REQUESTED" DataFormatString="{0:dd MMM yyyy}" />
                        <asp:TemplateField HeaderText="ACTIONS">
                            <ItemTemplate>
                                <asp:Panel runat="server" Visible='<%# Eval("Status").ToString() == "Pending" %>' Style="display: flex; gap: 8px;">
                                    <asp:Button runat="server" Text="Approve" CssClass="btn-table btn-green"
                                        CommandName="Approve" CommandArgument='<%# Eval("Id") %>' />
                                    <asp:Button runat="server" Text="Reject" CssClass="btn-table btn-red"
                                        CommandName="Reject" CommandArgument='<%# Eval("Id") %>' />
                                </asp:Panel>
                                <asp:Panel runat="server" Visible='<%# Eval("Status").ToString() == "Approved" %>'>
                                    <asp:Button runat="server" Text="Mark Returned" CssClass="btn-table btn-dark"
                                        CommandName="ReturnItem" CommandArgument='<%# Eval("Id") %>' />
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>