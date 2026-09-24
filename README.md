
# Smart Campus Equipment Booking - ASP.NET Web Forms (complete)

Full conversion from the ASP.NET Core MVC version to classic ASP.NET Web Forms.

## Setup order

1. Database first: open SQL Server Object Explorer in Visual Studio, connect to
   (localdb)\mssqllocaldb, run database_setup.sql (creates EquipmentBookingDb,
   3 tables, and seed data).

2. Open the site: Visual Studio 2026 -> File -> Open -> Web Site... -> select this
   extracted folder.

3. Set start page: right-click Default.aspx -> Set as Start Page.

4. Run: F5, or View in Browser.

## Pages

| Page | Purpose |
|---|---|
| Default.aspx | Dashboard - equipment count, pending count, borrowed count |
| Equipment.aspx | View all equipment, add new items, delete items |
| Requests.aspx | View all bookings, Approve / Reject / Mark Returned (stock auto-updates) |
| NewRequest.aspx | Student-facing form to submit a booking request |

## Supporting files

| File | Purpose |
|---|---|
| Web.config | Database connection string ((localdb)\mssqllocaldb, EquipmentBookingDb) |
| App_Code/DbHelper.cs | Shared SQL connection helper used by every page |
| css/site.css | Full styling (sidebar, cards, status badges, forms) |
| database_setup.sql | Run once in SQL Server to create the database |

## Core logic

- Stock (AvailableQuantity) decreases only when a request is Approved.
- Stock increases again when a request is marked Returned.
- New students are auto-registered by name when they submit their first request
  via NewRequest.aspx - no separate registration screen needed.
- All queries use parameterized SqlCommand (no string-concatenated SQL), so
  it's safe from SQL injection.

## Full flow to test

1. NewRequest.aspx -> enter a name, pick equipment, submit
2. Requests.aspx -> see it as Pending -> click Approve
3. Equipment.aspx -> confirm available quantity dropped
4. Requests.aspx -> click Mark Returned -> confirm quantity restored
