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
    public class TestJSONGet : SqlDatabaseTestClass
    {

        public TestJSONGet()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT01_GetRevenue_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(TestJSONGet));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT01_CheckRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT02_GetStations_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT02_CheckRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT03_GetAudienceReach_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT03_CheckRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT04_GetCalculationGroup_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT04_CheckRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT05_GetFPVCalculations_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT05_CheckRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT06_GetMissingMinutes_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT06_RowCounts;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT07_GetMusicMinutes_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT07_CheckRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT08_GetPublicReception_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT08_CheckRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT09_GetRevenueGroups_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT09_CheckRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction JSGT10_GetUDC_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition JSGT10_CheckRows;
            this.JSGT01_GetRevenueData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT02_GetStationsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT03_GetAudienceReachData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT04_GetCalculationGroupData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT05_GetFPVCalculationsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT06_GetMissingMinutesData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT07_GetMusicMinutesData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT08_GetPublicReceptionData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT09_GetRevenueGroupsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.JSGT10_GetUDCData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            JSGT01_GetRevenue_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT01_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT02_GetStations_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT02_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT03_GetAudienceReach_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT03_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT04_GetCalculationGroup_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT04_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT05_GetFPVCalculations_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT05_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT06_GetMissingMinutes_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT06_RowCounts = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT07_GetMusicMinutes_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT07_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT08_GetPublicReception_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT08_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT09_GetRevenueGroups_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT09_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            JSGT10_GetUDC_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            JSGT10_CheckRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // JSGT01_GetRevenue_TestAction
            // 
            JSGT01_GetRevenue_TestAction.Conditions.Add(JSGT01_CheckRows);
            resources.ApplyResources(JSGT01_GetRevenue_TestAction, "JSGT01_GetRevenue_TestAction");
            // 
            // JSGT01_CheckRows
            // 
            JSGT01_CheckRows.ColumnNumber = 1;
            JSGT01_CheckRows.Enabled = true;
            JSGT01_CheckRows.ExpectedValue = "1";
            JSGT01_CheckRows.Name = "JSGT01_CheckRows";
            JSGT01_CheckRows.NullExpected = false;
            JSGT01_CheckRows.ResultSet = 2;
            JSGT01_CheckRows.RowNumber = 1;
            // 
            // JSGT02_GetStations_TestAction
            // 
            JSGT02_GetStations_TestAction.Conditions.Add(JSGT02_CheckRows);
            resources.ApplyResources(JSGT02_GetStations_TestAction, "JSGT02_GetStations_TestAction");
            // 
            // JSGT02_CheckRows
            // 
            JSGT02_CheckRows.ColumnNumber = 1;
            JSGT02_CheckRows.Enabled = true;
            JSGT02_CheckRows.ExpectedValue = "1";
            JSGT02_CheckRows.Name = "JSGT02_CheckRows";
            JSGT02_CheckRows.NullExpected = false;
            JSGT02_CheckRows.ResultSet = 2;
            JSGT02_CheckRows.RowNumber = 1;
            // 
            // JSGT03_GetAudienceReach_TestAction
            // 
            JSGT03_GetAudienceReach_TestAction.Conditions.Add(JSGT03_CheckRows);
            resources.ApplyResources(JSGT03_GetAudienceReach_TestAction, "JSGT03_GetAudienceReach_TestAction");
            // 
            // JSGT03_CheckRows
            // 
            JSGT03_CheckRows.ColumnNumber = 1;
            JSGT03_CheckRows.Enabled = true;
            JSGT03_CheckRows.ExpectedValue = "1";
            JSGT03_CheckRows.Name = "JSGT03_CheckRows";
            JSGT03_CheckRows.NullExpected = false;
            JSGT03_CheckRows.ResultSet = 2;
            JSGT03_CheckRows.RowNumber = 1;
            // 
            // JSGT04_GetCalculationGroup_TestAction
            // 
            JSGT04_GetCalculationGroup_TestAction.Conditions.Add(JSGT04_CheckRows);
            resources.ApplyResources(JSGT04_GetCalculationGroup_TestAction, "JSGT04_GetCalculationGroup_TestAction");
            // 
            // JSGT04_CheckRows
            // 
            JSGT04_CheckRows.ColumnNumber = 1;
            JSGT04_CheckRows.Enabled = true;
            JSGT04_CheckRows.ExpectedValue = "1";
            JSGT04_CheckRows.Name = "JSGT04_CheckRows";
            JSGT04_CheckRows.NullExpected = false;
            JSGT04_CheckRows.ResultSet = 2;
            JSGT04_CheckRows.RowNumber = 1;
            // 
            // JSGT05_GetFPVCalculations_TestAction
            // 
            JSGT05_GetFPVCalculations_TestAction.Conditions.Add(JSGT05_CheckRows);
            resources.ApplyResources(JSGT05_GetFPVCalculations_TestAction, "JSGT05_GetFPVCalculations_TestAction");
            // 
            // JSGT05_CheckRows
            // 
            JSGT05_CheckRows.ColumnNumber = 1;
            JSGT05_CheckRows.Enabled = true;
            JSGT05_CheckRows.ExpectedValue = "1";
            JSGT05_CheckRows.Name = "JSGT05_CheckRows";
            JSGT05_CheckRows.NullExpected = false;
            JSGT05_CheckRows.ResultSet = 2;
            JSGT05_CheckRows.RowNumber = 1;
            // 
            // JSGT06_GetMissingMinutes_TestAction
            // 
            JSGT06_GetMissingMinutes_TestAction.Conditions.Add(JSGT06_RowCounts);
            resources.ApplyResources(JSGT06_GetMissingMinutes_TestAction, "JSGT06_GetMissingMinutes_TestAction");
            // 
            // JSGT06_RowCounts
            // 
            JSGT06_RowCounts.ColumnNumber = 1;
            JSGT06_RowCounts.Enabled = true;
            JSGT06_RowCounts.ExpectedValue = "1";
            JSGT06_RowCounts.Name = "JSGT06_RowCounts";
            JSGT06_RowCounts.NullExpected = false;
            JSGT06_RowCounts.ResultSet = 2;
            JSGT06_RowCounts.RowNumber = 1;
            // 
            // JSGT07_GetMusicMinutes_TestAction
            // 
            JSGT07_GetMusicMinutes_TestAction.Conditions.Add(JSGT07_CheckRows);
            resources.ApplyResources(JSGT07_GetMusicMinutes_TestAction, "JSGT07_GetMusicMinutes_TestAction");
            // 
            // JSGT07_CheckRows
            // 
            JSGT07_CheckRows.ColumnNumber = 1;
            JSGT07_CheckRows.Enabled = true;
            JSGT07_CheckRows.ExpectedValue = "1";
            JSGT07_CheckRows.Name = "JSGT07_CheckRows";
            JSGT07_CheckRows.NullExpected = false;
            JSGT07_CheckRows.ResultSet = 2;
            JSGT07_CheckRows.RowNumber = 1;
            // 
            // JSGT08_GetPublicReception_TestAction
            // 
            JSGT08_GetPublicReception_TestAction.Conditions.Add(JSGT08_CheckRows);
            resources.ApplyResources(JSGT08_GetPublicReception_TestAction, "JSGT08_GetPublicReception_TestAction");
            // 
            // JSGT08_CheckRows
            // 
            JSGT08_CheckRows.ColumnNumber = 1;
            JSGT08_CheckRows.Enabled = true;
            JSGT08_CheckRows.ExpectedValue = "1";
            JSGT08_CheckRows.Name = "JSGT08_CheckRows";
            JSGT08_CheckRows.NullExpected = false;
            JSGT08_CheckRows.ResultSet = 2;
            JSGT08_CheckRows.RowNumber = 1;
            // 
            // JSGT09_GetRevenueGroups_TestAction
            // 
            JSGT09_GetRevenueGroups_TestAction.Conditions.Add(JSGT09_CheckRows);
            resources.ApplyResources(JSGT09_GetRevenueGroups_TestAction, "JSGT09_GetRevenueGroups_TestAction");
            // 
            // JSGT09_CheckRows
            // 
            JSGT09_CheckRows.ColumnNumber = 1;
            JSGT09_CheckRows.Enabled = true;
            JSGT09_CheckRows.ExpectedValue = "1";
            JSGT09_CheckRows.Name = "JSGT09_CheckRows";
            JSGT09_CheckRows.NullExpected = false;
            JSGT09_CheckRows.ResultSet = 2;
            JSGT09_CheckRows.RowNumber = 1;
            // 
            // JSGT10_GetUDC_TestAction
            // 
            JSGT10_GetUDC_TestAction.Conditions.Add(JSGT10_CheckRows);
            resources.ApplyResources(JSGT10_GetUDC_TestAction, "JSGT10_GetUDC_TestAction");
            // 
            // JSGT10_CheckRows
            // 
            JSGT10_CheckRows.ColumnNumber = 1;
            JSGT10_CheckRows.Enabled = true;
            JSGT10_CheckRows.ExpectedValue = "1";
            JSGT10_CheckRows.Name = "JSGT10_CheckRows";
            JSGT10_CheckRows.NullExpected = false;
            JSGT10_CheckRows.ResultSet = 2;
            JSGT10_CheckRows.RowNumber = 1;
            // 
            // JSGT01_GetRevenueData
            // 
            this.JSGT01_GetRevenueData.PosttestAction = null;
            this.JSGT01_GetRevenueData.PretestAction = null;
            this.JSGT01_GetRevenueData.TestAction = JSGT01_GetRevenue_TestAction;
            // 
            // JSGT02_GetStationsData
            // 
            this.JSGT02_GetStationsData.PosttestAction = null;
            this.JSGT02_GetStationsData.PretestAction = null;
            this.JSGT02_GetStationsData.TestAction = JSGT02_GetStations_TestAction;
            // 
            // JSGT03_GetAudienceReachData
            // 
            this.JSGT03_GetAudienceReachData.PosttestAction = null;
            this.JSGT03_GetAudienceReachData.PretestAction = null;
            this.JSGT03_GetAudienceReachData.TestAction = JSGT03_GetAudienceReach_TestAction;
            // 
            // JSGT04_GetCalculationGroupData
            // 
            this.JSGT04_GetCalculationGroupData.PosttestAction = null;
            this.JSGT04_GetCalculationGroupData.PretestAction = null;
            this.JSGT04_GetCalculationGroupData.TestAction = JSGT04_GetCalculationGroup_TestAction;
            // 
            // JSGT05_GetFPVCalculationsData
            // 
            this.JSGT05_GetFPVCalculationsData.PosttestAction = null;
            this.JSGT05_GetFPVCalculationsData.PretestAction = null;
            this.JSGT05_GetFPVCalculationsData.TestAction = JSGT05_GetFPVCalculations_TestAction;
            // 
            // JSGT06_GetMissingMinutesData
            // 
            this.JSGT06_GetMissingMinutesData.PosttestAction = null;
            this.JSGT06_GetMissingMinutesData.PretestAction = null;
            this.JSGT06_GetMissingMinutesData.TestAction = JSGT06_GetMissingMinutes_TestAction;
            // 
            // JSGT07_GetMusicMinutesData
            // 
            this.JSGT07_GetMusicMinutesData.PosttestAction = null;
            this.JSGT07_GetMusicMinutesData.PretestAction = null;
            this.JSGT07_GetMusicMinutesData.TestAction = JSGT07_GetMusicMinutes_TestAction;
            // 
            // JSGT08_GetPublicReceptionData
            // 
            this.JSGT08_GetPublicReceptionData.PosttestAction = null;
            this.JSGT08_GetPublicReceptionData.PretestAction = null;
            this.JSGT08_GetPublicReceptionData.TestAction = JSGT08_GetPublicReception_TestAction;
            // 
            // JSGT09_GetRevenueGroupsData
            // 
            this.JSGT09_GetRevenueGroupsData.PosttestAction = null;
            this.JSGT09_GetRevenueGroupsData.PretestAction = null;
            this.JSGT09_GetRevenueGroupsData.TestAction = JSGT09_GetRevenueGroups_TestAction;
            // 
            // JSGT10_GetUDCData
            // 
            this.JSGT10_GetUDCData.PosttestAction = null;
            this.JSGT10_GetUDCData.PretestAction = null;
            this.JSGT10_GetUDCData.TestAction = JSGT10_GetUDC_TestAction;
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
        public void JSGT01_GetRevenue()
        {
            SqlDatabaseTestActions testActions = this.JSGT01_GetRevenueData;
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
        public void JSGT02_GetStations()
        {
            SqlDatabaseTestActions testActions = this.JSGT02_GetStationsData;
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
        public void JSGT03_GetAudienceReach()
        {
            SqlDatabaseTestActions testActions = this.JSGT03_GetAudienceReachData;
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
        public void JSGT04_GetCalculationGroup()
        {
            SqlDatabaseTestActions testActions = this.JSGT04_GetCalculationGroupData;
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
        public void JSGT05_GetFPVCalculations()
        {
            SqlDatabaseTestActions testActions = this.JSGT05_GetFPVCalculationsData;
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
        public void JSGT06_GetMissingMinutes()
        {
            SqlDatabaseTestActions testActions = this.JSGT06_GetMissingMinutesData;
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
        public void JSGT07_GetMusicMinutes()
        {
            SqlDatabaseTestActions testActions = this.JSGT07_GetMusicMinutesData;
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
        public void JSGT08_GetPublicReception()
        {
            SqlDatabaseTestActions testActions = this.JSGT08_GetPublicReceptionData;
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
        public void JSGT09_GetRevenueGroups()
        {
            SqlDatabaseTestActions testActions = this.JSGT09_GetRevenueGroupsData;
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
        public void JSGT10_GetUDC()
        {
            SqlDatabaseTestActions testActions = this.JSGT10_GetUDCData;
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









        private SqlDatabaseTestActions JSGT01_GetRevenueData;
        private SqlDatabaseTestActions JSGT02_GetStationsData;
        private SqlDatabaseTestActions JSGT03_GetAudienceReachData;
        private SqlDatabaseTestActions JSGT04_GetCalculationGroupData;
        private SqlDatabaseTestActions JSGT05_GetFPVCalculationsData;
        private SqlDatabaseTestActions JSGT06_GetMissingMinutesData;
        private SqlDatabaseTestActions JSGT07_GetMusicMinutesData;
        private SqlDatabaseTestActions JSGT08_GetPublicReceptionData;
        private SqlDatabaseTestActions JSGT09_GetRevenueGroupsData;
        private SqlDatabaseTestActions JSGT10_GetUDCData;
    }
}
