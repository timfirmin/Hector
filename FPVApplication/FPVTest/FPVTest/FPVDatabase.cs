using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;


namespace FPVTest
{
    struct  TestResult { public string Response; public int DataRowcount; };
    class FPVDatabase
    {
        SqlConnection _conn;
        string _connectionString= "Data Source= azi-ms-sql-d002,50501;Initial Catalog= DistributionFPV Trusted_Connection= True";

        public FPVDatabase (string connectionString)
        {
            _connectionString = connectionString;
            SetConnection();
        }
        public FPVDatabase()
        {
            SetConnection();
        }

        private void SetConnection()
        {
            _conn = new SqlConnection(_connectionString);
        }


        public TestResult ExecuteTest(string TestID, string ParamList)
        {
            _conn.Open();
            SqlCommand cmd = new SqlCommand("[Test].[ExecuteTest]",_conn);
            SqlDataReader reader;
            TestResult result = new TestResult();

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@TestID", TestID));
            cmd.Parameters.Add(new SqlParameter("@ParamString", ParamList));

            reader = cmd.ExecuteReader();

            // Data is accessible through the DataReader object here.
            while (reader.Read())
            {
                result.Response = reader.GetString(0);
                result.DataRowcount = reader.GetInt32(1);
            }
            reader.Close();
            _conn.Close();

            return result;
        }

        public void ExecuteNonQuery(string sql)
        {
            SqlCommand cmd = new SqlCommand(sql, _conn);
            cmd.CommandType = CommandType.Text;
            _conn.Open();
            cmd.ExecuteNonQuery();
            _conn.Close();

        }

    }
}
