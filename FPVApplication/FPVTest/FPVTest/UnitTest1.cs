using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace FPVTest
{
    [TestClass]
    public class RequestResponse_Testing
    {
        string _connectionString = "Data Source= azi-ms-sql-d002,50501;Initial Catalog= DistributionFPV; Trusted_Connection= True";
        FPVDatabase _db;
        [TestInitialize]
        public void testInitialise()
        {
            _db = new FPVDatabase(_connectionString);
            ExecuteNonQuery("exec [Test].[InitialiseTestData]");
        }

        [TestCleanup]
        public void testFinalise()
        {
            ExecuteNonQuery("exec [Test].[CleanUpTestData]");
        }

        [TestMethod]
        public void MakeInvalidJSONRequest()
        {
            //execute test and assert result
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("RequestInvalidJSON", ""), "error", 0, "=="));
        }

        [TestMethod]
        public void MakeUndefinedJSONRequest()
        {
            //execute test and assert result
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("RequestInvalidRequest", ""), "error", 0, "=="));
        }
        [TestMethod]
        public void GetAllDistributionGroups()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributionGroups_All", ""), "success", 1, ">"));
        }

        [TestMethod]
        public void GetTestOnlyDistributionGroup()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributionGroups_TestOnly", ""), "success", 1, "=="));
        }

        [TestMethod]
        public void GetNonExistantDistributionGroup()
        {
            //execute test and assert result
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributionGroups_xxxxOnly", ""), "success", 0, "=="));
        }

        [TestMethod]
        public void GetDisabledDistributionGroups()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributionGroups_DisabledOnly", ""), "success", 1, "=="));
        }

        [TestMethod]
        public void GetEnabledDistributionGroups()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributionGroups_EnabledOnly", ""), "success", 0, ">"));
        }

        [TestMethod]
        public void GetEnabledTestDistributionGroup()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributionGroups_TestAndEnabled", ""), "success", 0, "=="));
        }

        [TestMethod]
        public void GetDisabledTestDistributionGroup()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributionGroups_TestAndDisabled", ""), "success", 1,"=="));
        }

        [TestMethod]
        public void GetUpdatedTestDistributionGroup()
        {
            //update the enabled status of the test distribution group
            InitialiseTestData();
            ExecuteNonQuery("UPDATE [FPV].[DistributionGroup] SET [Enabled]=1 WHERE [DistributionGroupCode]='TEST'");
            //execute test and assert result
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributionGroups_TestAndEnabled", ""), "success", 1, "=="));
        }

        [TestMethod]
        public void GetAllSocieties()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetSocieties_All", ""), "success", 0, ">"));
        }

        [TestMethod]
        public void GetPRSSociety()
        {
            //execute test and assert result
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetSocieties_PRSOnly", ""), "success", 1, "=="));
        }
        [TestMethod]
        public void GetEnabledSocieties()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetSocieties_EnabledOnly", ""), "success", 0, ">"));
        }

        [TestMethod]
        public void GetDisabledSocieties()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetSocieties_DisabledOnly", ""), "success", 0, "=="));
        }

        [TestMethod]
        public void GetAllDistributions()
        {
            //execute test and assert result
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributions_All", ""), "success", 0, ">"));
        }
        [TestMethod]
        public void GetTestDistribution()
        {
            //execute test and assert result
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetDistributions_TestOnly", ""), "success", 1, "=="));
        }


        [TestMethod]
        public void GetAllCalculationGroups()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetCalculationGroups_All", ""), "success", 0, ">"));
        }

        [TestMethod]
        public void GetTestCalculationGroups()
        {
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetCalculationGroups_TestOnly", ""), "success", 2, "=="));
        }

        [TestMethod]
        public void GetTestStationForDTESTAndPRS_CurrentView()
        {
            //request stations for
            //DistributionGroup:TEST
            //Distribution:DTEST
            //Society:PRS
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetStations_TEST_DTEST_PRS_Current", ""), "success", 3, "=="));
        }
        [TestMethod]
        public void GetTestStationForDTESTAndMCPS_CurrentView()
        {
            //request stations for
            //DistributionGroup:TEST
            //Distribution:DTEST
            //Society:MCPS
            //TemporalView:Default
            //execute test and assert result
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetStations_TEST_DTEST_MCPS_Current", ""), "success", 3, "=="));
        }

        [TestMethod]
        public void GetTestStationForDTESTAndPRS_HistoricalView()
        {
            //request stations for
            //DistributionGroup:TEST
            //Distribution:DTEST
            //Society:PRS
            //test process: 
            //  i.update data to ensure some historical records
            //  ii. execute and assert result

            //ensure some historical records
            InitialiseTestData();
            string sql = "UPDATE [FPV].[MasterStation] SET [StationID]=[StationID] WHERE [DistributionGroupCode]='TEST'";
            ExecuteNonQuery(sql);

            //execute test and assert result
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetStations_TEST_DTEST_PRS_Historical", ""), "success", 3, ">"));
        }
            
        [TestMethod]
        public void GetAllConfig_CurrentView()
        {
            //
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetConfig_ALL_Current", ""), "success", 7, "=="));
        }
        [TestMethod]
        public void GetAllConfig_HistoricalView()
        {
            //
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetConfig_ALL_Historical", ""), "success", 7, ">="));
        }
        [TestMethod]
        public void GetAppConfig_CurrentView()
        {
            //
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetConfig_APP_Current", ""), "success", 5, "=="));
        }
        [TestMethod]
        public void GetAppConfig_HistoricalView()
        {
            //
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetConfig_APP_Historical", ""), "success", 5, ">="));
        }
        [TestMethod]
        public void PutStations_InitialSeeding()
        {
            //add 6 stations to calculation group
            InitialiseTestData();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("PutStations_InitialSeeding", ""), "success", 6, "=="));
        }
        [TestMethod]
        public void PutStations_UpdateNoDelete()
        {
            //update 1 calculation group station with no delete set
            //Society: PRS
            //distribution group: TEST
            //distribution: DTEST
            //StationID: TIR210G
            ReSeedCalculationGroupStations();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("PutStations_UpdateNoDelete", ""), "success", 1, "=="));
        }

        [TestMethod]
        public void PutStations_UpdateWithDelete()
        {
            //update 1 calculation group station with delete set
            //Society: PRS
            //distribution group: TEST
            //distribution: DTEST1
            //StationID: TIR210G
            ReSeedCalculationGroupStations();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("PutStations_UpdateWithDelete", ""), "success", 2, "=="));
        }
        [TestMethod]
        public void PutStations_DeleteAllFromCalculationGroup()
        {
            //remove 2 calculation group stations
            //Society: PRS
            //distribution group: TEST
            //distribution: DTEST2
            //StationID: TIR210G
            ReSeedCalculationGroupStations();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("PutStations_DeleteAllFromCalculationGroup", ""), "success", 2, "=="));
        }
        [TestMethod]
        public void GetRevenue_All()
        {
            // return results should be 3      - set to >250 on Dev DEV   
            //"filters":{"Society":"MCPS","DistributionCode":"D161","DistributionGroupCode":"ILR"}  
            ReSeedCalculationGroupStations();
            Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetRevenue_All", ""), "success", 250, ">"));
        }
        [TestMethod]
        //public void GetMusicMinutes_All()
        //{
        //    // ensure return results for ILR D182 should be >250  [TJF2018JUN25]
        //    Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("GetMusicMinutes_All", ""), "success", 250, ">"));
        //}
        //[TestMethod]
        //public void PutMusicMinutes_All()
        //{
        //    // ensure return results for ILR D182 should be >250  [TJF2018JUN25] 
        //    Assert.AreEqual(true, EvaluateTestResult(_db.ExecuteTest("PutMusicMinutes_All", ""), "success", 250, ">"));
        //}

        private bool EvaluateTestResult(TestResult result, string ExpectedResponseValue, int ExpectedDataRowcount,string RowCountEvaluationType)
        {
            bool responseEvaluation = result.Response.Contains(ExpectedResponseValue);
            bool rowcountEvaluation = result.DataRowcount == ExpectedDataRowcount;

            switch (RowCountEvaluationType)
            {
                case "==": rowcountEvaluation = result.DataRowcount == ExpectedDataRowcount;
                break;
                case ">": rowcountEvaluation = result.DataRowcount > ExpectedDataRowcount;
                break;
                case "<": rowcountEvaluation = result.DataRowcount < ExpectedDataRowcount;
                break;
                case ">=":
                rowcountEvaluation = result.DataRowcount >= ExpectedDataRowcount;
                break;
                case "<=":
                rowcountEvaluation = result.DataRowcount >= ExpectedDataRowcount;
                break;
                default: rowcountEvaluation = false;
                break;
            }
            return responseEvaluation && rowcountEvaluation;
        }

        private bool EvaluateTestResult(TestResult result, string searchPattern)
        {
            return false;
        }

        private void InitialiseTestData()
        {
            ExecuteNonQuery("exec [Test].[InitialiseTestData]");
        }
        private void ReSeedCalculationGroupStations()
        {
            _db.ExecuteTest("PutStations_InitialSeeding", "");
        }
         
        private void ExecuteNonQuery(string sql)
        {
            _db.ExecuteNonQuery(sql);
        }

    }

}
