using System;
using System.Configuration;
using System.Data.SqlClient;

public static class DbHelper
{
    public static SqlConnection GetConnection()
    {
        string connStr = ConfigurationManager.ConnectionStrings["EquipmentDb"].ConnectionString;
        return new SqlConnection(connStr);
    }
}
