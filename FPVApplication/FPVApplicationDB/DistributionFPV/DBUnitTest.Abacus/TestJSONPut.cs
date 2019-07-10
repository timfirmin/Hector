using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace DBUnitTest.Abacus
{
    [TestClass()]
    public class TestJSONPut : SqlDatabaseTestClass
    {

        public TestJSONPut()
        {
            InitializeComponent();
        }

        [TestInitialize()]
        public void TestInitialize()
        {
            base.InitializeTest();
        }
        [TestCleanup()]
        public void TestCleanup()
        {
            base.CleanupTest();
        }

        #region Designer support code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT01_PutStations_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(TestJSONPut));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition TestJSPT01_PutStation;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT02_PutRevenue_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition TestJSP02_PutRevenue;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT03_PutAudienceReach_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition TestJSP03_AudienceMart;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT04_PutRevenueGroup_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition TestJSPT04_RevenueGroup;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT05_PutMissingMinutes_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition TestJSPT05_PutMissingMinutes;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT05_PutMissingMinutes_PosttestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT04_PutRevenueGroup_PosttestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT01_PutStations_PosttestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT02_PutRevenue_PosttestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT03_PutAudienceReach_PosttestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT06_PutMusicMinutes_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition TestJSPT06_PutMusicMinutes;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT06_PutMusicMinutes_PosttestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT07_PutPublicReception_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition TestJSPT07_PutPublicReception;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT07_PutPublicReception_PosttestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT08_PutUDC_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition TestJSPT08_PutUDC;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT08_PutUDC_PosttestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSPT10_PutFPVCalculation_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSPT10_TestScalar;
            this.JSPT01_PutStationsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSPT02_PutRevenueData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSPT03_PutAudienceReachData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSPT04_PutRevenueGroupData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSPT05_PutMissingMinutesData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSPT06_PutMusicMinutesData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSPT07_PutPublicReceptionData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSPT08_PutUDCData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSPT10_PutFPVCalculationData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            JSPT01_PutStations_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            TestJSPT01_PutStation = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSPT02_PutRevenue_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            TestJSP02_PutRevenue = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSPT03_PutAudienceReach_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            TestJSP03_AudienceMart = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSPT04_PutRevenueGroup_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            TestJSPT04_RevenueGroup = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSPT05_PutMissingMinutes_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            TestJSPT05_PutMissingMinutes = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSPT05_PutMissingMinutes_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT04_PutRevenueGroup_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT01_PutStations_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT02_PutRevenue_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT03_PutAudienceReach_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT06_PutMusicMinutes_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            TestJSPT06_PutMusicMinutes = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSPT06_PutMusicMinutes_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT07_PutPublicReception_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            TestJSPT07_PutPublicReception = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSPT07_PutPublicReception_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT08_PutUDC_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            TestJSPT08_PutUDC = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSPT08_PutUDC_PosttestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT10_PutFPVCalculation_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSPT10_TestScalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // JSPT01_PutStations_TestAction
            // 
            JSPT01_PutStations_TestAction.Conditions.Add(TestJSPT01_PutStation);
            resources.ApplyResources(JSPT01_PutStations_TestAction, "JSPT01_PutStations_TestAction");
            // 
            // TestJSPT01_PutStation
            // 
            TestJSPT01_PutStation.ColumnNumber = 1;
            TestJSPT01_PutStation.Enabled = true;
            TestJSPT01_PutStation.ExpectedValue = "1";
            TestJSPT01_PutStation.Name = "TestJSPT01_PutStation";
            TestJSPT01_PutStation.NullExpected = false;
            TestJSPT01_PutStation.ResultSet = 2;
            TestJSPT01_PutStation.RowNumber = 1;
            // 
            // JSPT02_PutRevenue_TestAction
            // 
            JSPT02_PutRevenue_TestAction.Conditions.Add(TestJSP02_PutRevenue);
            resources.ApplyResources(JSPT02_PutRevenue_TestAction, "JSPT02_PutRevenue_TestAction");
            // 
            // TestJSP02_PutRevenue
            // 
            TestJSP02_PutRevenue.ColumnNumber = 1;
            TestJSP02_PutRevenue.Enabled = true;
            TestJSP02_PutRevenue.ExpectedValue = "1";
            TestJSP02_PutRevenue.Name = "TestJSP02_PutRevenue";
            TestJSP02_PutRevenue.NullExpected = false;
            TestJSP02_PutRevenue.ResultSet = 2;
            TestJSP02_PutRevenue.RowNumber = 1;
            // 
            // JSPT03_PutAudienceReach_TestAction
            // 
            JSPT03_PutAudienceReach_TestAction.Conditions.Add(TestJSP03_AudienceMart);
            resources.ApplyResources(JSPT03_PutAudienceReach_TestAction, "JSPT03_PutAudienceReach_TestAction");
            // 
            // TestJSP03_AudienceMart
            // 
            TestJSP03_AudienceMart.ColumnNumber = 1;
            TestJSP03_AudienceMart.Enabled = true;
            TestJSP03_AudienceMart.ExpectedValue = "1";
            TestJSP03_AudienceMart.Name = "TestJSP03_AudienceMart";
            TestJSP03_AudienceMart.NullExpected = false;
            TestJSP03_AudienceMart.ResultSet = 2;
            TestJSP03_AudienceMart.RowNumber = 1;
            // 
            // JSPT04_PutRevenueGroup_TestAction
            // 
            JSPT04_PutRevenueGroup_TestAction.Conditions.Add(TestJSPT04_RevenueGroup);
            resources.ApplyResources(JSPT04_PutRevenueGroup_TestAction, "JSPT04_PutRevenueGroup_TestAction");
            // 
            // TestJSPT04_RevenueGroup
            // 
            TestJSPT04_RevenueGroup.ColumnNumber = 1;
            TestJSPT04_RevenueGroup.Enabled = true;
            TestJSPT04_RevenueGroup.ExpectedValue = "1";
            TestJSPT04_RevenueGroup.Name = "TestJSPT04_RevenueGroup";
            TestJSPT04_RevenueGroup.NullExpected = false;
            TestJSPT04_RevenueGroup.ResultSet = 2;
            TestJSPT04_RevenueGroup.RowNumber = 1;
            // 
            // JSPT05_PutMissingMinutes_TestAction
            // 
            JSPT05_PutMissingMinutes_TestAction.Conditions.Add(TestJSPT05_PutMissingMinutes);
            resources.ApplyResources(JSPT05_PutMissingMinutes_TestAction, "JSPT05_PutMissingMinutes_TestAction");
            // 
            // TestJSPT05_PutMissingMinutes
            // 
            TestJSPT05_PutMissingMinutes.ColumnNumber = 1;
            TestJSPT05_PutMissingMinutes.Enabled = true;
            TestJSPT05_PutMissingMinutes.ExpectedValue = "1";
            TestJSPT05_PutMissingMinutes.Name = "TestJSPT05_PutMissingMinutes";
            TestJSPT05_PutMissingMinutes.NullExpected = false;
            TestJSPT05_PutMissingMinutes.ResultSet = 2;
            TestJSPT05_PutMissingMinutes.RowNumber = 1;
            // 
            // JSPT05_PutMissingMinutes_PosttestAction
            // 
            resources.ApplyResources(JSPT05_PutMissingMinutes_PosttestAction, "JSPT05_PutMissingMinutes_PosttestAction");
            // 
            // JSPT04_PutRevenueGroup_PosttestAction
            // 
            resources.ApplyResources(JSPT04_PutRevenueGroup_PosttestAction, "JSPT04_PutRevenueGroup_PosttestAction");
            // 
            // JSPT01_PutStations_PosttestAction
            // 
            resources.ApplyResources(JSPT01_PutStations_PosttestAction, "JSPT01_PutStations_PosttestAction");
            // 
            // JSPT02_PutRevenue_PosttestAction
            // 
            resources.ApplyResources(JSPT02_PutRevenue_PosttestAction, "JSPT02_PutRevenue_PosttestAction");
            // 
            // JSPT03_PutAudienceReach_PosttestAction
            // 
            resources.ApplyResources(JSPT03_PutAudienceReach_PosttestAction, "JSPT03_PutAudienceReach_PosttestAction");
            // 
            // JSPT06_PutMusicMinutes_TestAction
            // 
            JSPT06_PutMusicMinutes_TestAction.Conditions.Add(TestJSPT06_PutMusicMinutes);
            resources.ApplyResources(JSPT06_PutMusicMinutes_TestAction, "JSPT06_PutMusicMinutes_TestAction");
            // 
            // TestJSPT06_PutMusicMinutes
            // 
            TestJSPT06_PutMusicMinutes.ColumnNumber = 1;
            TestJSPT06_PutMusicMinutes.Enabled = true;
            TestJSPT06_PutMusicMinutes.ExpectedValue = "1";
            TestJSPT06_PutMusicMinutes.Name = "TestJSPT06_PutMusicMinutes";
            TestJSPT06_PutMusicMinutes.NullExpected = false;
            TestJSPT06_PutMusicMinutes.ResultSet = 2;
            TestJSPT06_PutMusicMinutes.RowNumber = 1;
            // 
            // JSPT06_PutMusicMinutes_PosttestAction
            // 
            resources.ApplyResources(JSPT06_PutMusicMinutes_PosttestAction, "JSPT06_PutMusicMinutes_PosttestAction");
            // 
            // JSPT07_PutPublicReception_TestAction
            // 
            JSPT07_PutPublicReception_TestAction.Conditions.Add(TestJSPT07_PutPublicReception);
            resources.ApplyResources(JSPT07_PutPublicReception_TestAction, "JSPT07_PutPublicReception_TestAction");
            // 
            // TestJSPT07_PutPublicReception
            // 
            TestJSPT07_PutPublicReception.ColumnNumber = 1;
            TestJSPT07_PutPublicReception.Enabled = true;
            TestJSPT07_PutPublicReception.ExpectedValue = "1";
            TestJSPT07_PutPublicReception.Name = "TestJSPT07_PutPublicReception";
            TestJSPT07_PutPublicReception.NullExpected = false;
            TestJSPT07_PutPublicReception.ResultSet = 2;
            TestJSPT07_PutPublicReception.RowNumber = 1;
            // 
            // JSPT07_PutPublicReception_PosttestAction
            // 
            resources.ApplyResources(JSPT07_PutPublicReception_PosttestAction, "JSPT07_PutPublicReception_PosttestAction");
            // 
            // JSPT08_PutUDC_TestAction
            // 
            JSPT08_PutUDC_TestAction.Conditions.Add(TestJSPT08_PutUDC);
            resources.ApplyResources(JSPT08_PutUDC_TestAction, "JSPT08_PutUDC_TestAction");
            // 
            // TestJSPT08_PutUDC
            // 
            TestJSPT08_PutUDC.ColumnNumber = 1;
            TestJSPT08_PutUDC.Enabled = true;
            TestJSPT08_PutUDC.ExpectedValue = "1";
            TestJSPT08_PutUDC.Name = "TestJSPT08_PutUDC";
            TestJSPT08_PutUDC.NullExpected = false;
            TestJSPT08_PutUDC.ResultSet = 2;
            TestJSPT08_PutUDC.RowNumber = 1;
            // 
            // JSPT08_PutUDC_PosttestAction
            // 
            resources.ApplyResources(JSPT08_PutUDC_PosttestAction, "JSPT08_PutUDC_PosttestAction");
            // 
            // JSPT10_PutFPVCalculation_TestAction
            // 
            JSPT10_PutFPVCalculation_TestAction.Conditions.Add(JSPT10_TestScalar);
            resources.ApplyResources(JSPT10_PutFPVCalculation_TestAction, "JSPT10_PutFPVCalculation_TestAction");
            // 
            // JSPT10_TestScalar
            // 
            JSPT10_TestScalar.ColumnNumber = 1;
            JSPT10_TestScalar.Enabled = true;
            JSPT10_TestScalar.ExpectedValue = "1";
            JSPT10_TestScalar.Name = "JSPT10_TestScalar";
            JSPT10_TestScalar.NullExpected = false;
            JSPT10_TestScalar.ResultSet = 2;
            JSPT10_TestScalar.RowNumber = 1;
            // 
            // JSPT01_PutStationsData
            // 
            this.JSPT01_PutStationsData.PosttestAction = JSPT01_PutStations_PosttestAction;
            this.JSPT01_PutStationsData.PretestAction = null;
            this.JSPT01_PutStationsData.TestAction = JSPT01_PutStations_TestAction;
            // 
            // JSPT02_PutRevenueData
            // 
            this.JSPT02_PutRevenueData.PosttestAction = JSPT02_PutRevenue_PosttestAction;
            this.JSPT02_PutRevenueData.PretestAction = null;
            this.JSPT02_PutRevenueData.TestAction = JSPT02_PutRevenue_TestAction;
            // 
            // JSPT03_PutAudienceReachData
            // 
            this.JSPT03_PutAudienceReachData.PosttestAction = JSPT03_PutAudienceReach_PosttestAction;
            this.JSPT03_PutAudienceReachData.PretestAction = null;
            this.JSPT03_PutAudienceReachData.TestAction = JSPT03_PutAudienceReach_TestAction;
            // 
            // JSPT04_PutRevenueGroupData
            // 
            this.JSPT04_PutRevenueGroupData.PosttestAction = JSPT04_PutRevenueGroup_PosttestAction;
            this.JSPT04_PutRevenueGroupData.PretestAction = null;
            this.JSPT04_PutRevenueGroupData.TestAction = JSPT04_PutRevenueGroup_TestAction;
            // 
            // JSPT05_PutMissingMinutesData
            // 
            this.JSPT05_PutMissingMinutesData.PosttestAction = JSPT05_PutMissingMinutes_PosttestAction;
            this.JSPT05_PutMissingMinutesData.PretestAction = null;
            this.JSPT05_PutMissingMinutesData.TestAction = JSPT05_PutMissingMinutes_TestAction;
            // 
            // JSPT06_PutMusicMinutesData
            // 
            this.JSPT06_PutMusicMinutesData.PosttestAction = JSPT06_PutMusicMinutes_PosttestAction;
            this.JSPT06_PutMusicMinutesData.PretestAction = null;
            this.JSPT06_PutMusicMinutesData.TestAction = JSPT06_PutMusicMinutes_TestAction;
            // 
            // JSPT07_PutPublicReceptionData
            // 
            this.JSPT07_PutPublicReceptionData.PosttestAction = JSPT07_PutPublicReception_PosttestAction;
            this.JSPT07_PutPublicReceptionData.PretestAction = null;
            this.JSPT07_PutPublicReceptionData.TestAction = JSPT07_PutPublicReception_TestAction;
            // 
            // JSPT08_PutUDCData
            // 
            this.JSPT08_PutUDCData.PosttestAction = JSPT08_PutUDC_PosttestAction;
            this.JSPT08_PutUDCData.PretestAction = null;
            this.JSPT08_PutUDCData.TestAction = JSPT08_PutUDC_TestAction;
            // 
            // JSPT10_PutFPVCalculationData
            // 
            this.JSPT10_PutFPVCalculationData.PosttestAction = null;
            this.JSPT10_PutFPVCalculationData.PretestAction = null;
            this.JSPT10_PutFPVCalculationData.TestAction = JSPT10_PutFPVCalculation_TestAction;
        }

        #endregion


        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        #endregion




        [TestMethod()]
        public void JSPT01_PutStations()
        {
            SqlDatabaseTestActions testActions = this.JSPT01_PutStationsData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void JSPT02_PutRevenue()
        {
            SqlDatabaseTestActions testActions = this.JSPT02_PutRevenueData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void JSPT03_PutAudienceReach()
        {
            SqlDatabaseTestActions testActions = this.JSPT03_PutAudienceReachData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void JSPT04_PutRevenueGroup()
        {
            SqlDatabaseTestActions testActions = this.JSPT04_PutRevenueGroupData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
            public void JSPT05_PutMissingMinutes()
        {
            SqlDatabaseTestActions testActions = this.JSPT05_PutMissingMinutesData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void JSPT06_PutMusicMinutes()
        {
            SqlDatabaseTestActions testActions = this.JSPT06_PutMusicMinutesData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void JSPT07_PutPublicReception()
        {
            SqlDatabaseTestActions testActions = this.JSPT07_PutPublicReceptionData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void JSPT08_PutUDC()
        {
            SqlDatabaseTestActions testActions = this.JSPT08_PutUDCData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }
        [TestMethod()]
        public void JSPT10_PutFPVCalculation()
        {
            SqlDatabaseTestActions testActions = this.JSPT10_PutFPVCalculationData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }









        private SqlDatabaseTestActions JSPT01_PutStationsData;
        private SqlDatabaseTestActions JSPT02_PutRevenueData;
        private SqlDatabaseTestActions JSPT03_PutAudienceReachData;
        private SqlDatabaseTestActions JSPT04_PutRevenueGroupData;
        private SqlDatabaseTestActions JSPT05_PutMissingMinutesData;
        private SqlDatabaseTestActions JSPT06_PutMusicMinutesData;
        private SqlDatabaseTestActions JSPT07_PutPublicReceptionData;
        private SqlDatabaseTestActions JSPT08_PutUDCData;
        private SqlDatabaseTestActions JSPT10_PutFPVCalculationData;
    }
}
