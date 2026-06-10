using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace CampusPhotoShare.Common
{
    public class DBHelper
    {
        private static readonly string ConnString = ConfigurationManager.ConnectionStrings["CampusPhotoConn"].ConnectionString;

        public static MySqlConnection GetConnection()
        {
            return new MySqlConnection(ConnString);
        }

        public static int ExecuteNonQuery(string sql, params MySqlParameter[] parameters)
        {
            using (MySqlConnection conn = GetConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    AddParameters(cmd, parameters);
                    conn.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        public static object ExecuteScalar(string sql, params MySqlParameter[] parameters)
        {
            using (MySqlConnection conn = GetConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    AddParameters(cmd, parameters);
                    conn.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }

        public static DataTable GetDataTable(string sql, params MySqlParameter[] parameters)
        {
            using (MySqlConnection conn = GetConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    AddParameters(cmd, parameters);
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);
                        return table;
                    }
                }
            }
        }

        public static DataSet GetDataSet(string sql, params MySqlParameter[] parameters)
        {
            using (MySqlConnection conn = GetConnection())
            {
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    AddParameters(cmd, parameters);
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                    {
                        DataSet dataSet = new DataSet();
                        adapter.Fill(dataSet);
                        return dataSet;
                    }
                }
            }
        }

        private static void AddParameters(MySqlCommand cmd, MySqlParameter[] parameters)
        {
            if (parameters == null)
            {
                return;
            }

            for (int i = 0; i < parameters.Length; i++)
            {
                if (parameters[i] != null)
                {
                    cmd.Parameters.Add(parameters[i]);
                }
            }
        }
    }
}
