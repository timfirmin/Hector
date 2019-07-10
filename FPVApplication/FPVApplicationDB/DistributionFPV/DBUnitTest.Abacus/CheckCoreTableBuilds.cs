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
    public class CheckCoreTableBuilds : SqlDatabaseTestClass
    {

        public CheckCoreTableBuilds()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CCTB_T02_ConfigIntegrationControl_CountRows_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CheckCoreTableBuilds));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CCBT_T02_IntegrationProcess_ScalarCheck;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CCBT_T03_FPVReferenceDate_CountRows_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CCBT_T03_ReferenceDate_ScalarCheck;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CCBT_T04_RequestDef_CountRows_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CCBT_T04_RequestDef_ScalarCheck;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CCBT_T05_FPVSociety_CountRows_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CCBT_T05_Society_ScalarCheck;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CCBT_T06_FPVCalculationDef_CountRows_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CCBT_T06_FPVCalculationDef_ScalarCheck;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CCBT_T07_StagingBroadcasterTimeBandMap_CountRows_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CCBT_T07_BroadcasterTimeBandMap_ScalarCheck;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CCTB_T01_ConfigValidationRules_CountRows_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CCTB_T01_ConfigValidationRules_ScalarValue;
            this.CCTB_T02_ConfigIntegrationControl_CountRowsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CCBT_T03_FPVReferenceDate_CountRowsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CCBT_T04_RequestDef_CountRowsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CCBT_T05_FPVSociety_CountRowsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CCBT_T06_FPVCalculationDef_CountRowsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CCBT_T07_StagingBroadcasterTimeBandMap_CountRowsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CCTB_T01_ConfigValidationRules_CountRowsData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            CCTB_T02_ConfigIntegrationControl_CountRows_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CCBT_T02_IntegrationProcess_ScalarCheck = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CCBT_T03_FPVReferenceDate_CountRows_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CCBT_T03_ReferenceDate_ScalarCheck = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CCBT_T04_RequestDef_CountRows_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CCBT_T04_RequestDef_ScalarCheck = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CCBT_T05_FPVSociety_CountRows_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CCBT_T05_Society_ScalarCheck = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CCBT_T06_FPVCalculationDef_CountRows_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CCBT_T06_FPVCalculationDef_ScalarCheck = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CCBT_T07_StagingBroadcasterTimeBandMap_CountRows_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CCBT_T07_BroadcasterTimeBandMap_ScalarCheck = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CCTB_T01_ConfigValidationRules_CountRows_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CCTB_T01_ConfigValidationRules_ScalarValue = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // CCTB_T02_ConfigIntegrationControl_CountRows_TestAction
            // 
            CCTB_T02_ConfigIntegrationControl_CountRows_TestAction.Conditions.Add(CCBT_T02_IntegrationProcess_ScalarCheck);
            resources.ApplyResources(CCTB_T02_ConfigIntegrationControl_CountRows_TestAction, "CCTB_T02_ConfigIntegrationControl_CountRows_TestAction");
            // 
            // CCBT_T02_IntegrationProcess_ScalarCheck
            // 
            CCBT_T02_IntegrationProcess_ScalarCheck.ColumnNumber = 1;
            CCBT_T02_IntegrationProcess_ScalarCheck.Enabled = true;
            CCBT_T02_IntegrationProcess_ScalarCheck.ExpectedValue = "9";
            CCBT_T02_IntegrationProcess_ScalarCheck.Name = "CCBT_T02_IntegrationProcess_ScalarCheck";
            CCBT_T02_IntegrationProcess_ScalarCheck.NullExpected = false;
            CCBT_T02_IntegrationProcess_ScalarCheck.ResultSet = 1;
            CCBT_T02_IntegrationProcess_ScalarCheck.RowNumber = 1;
            // 
            // CCBT_T03_FPVReferenceDate_CountRows_TestAction
            // 
            CCBT_T03_FPVReferenceDate_CountRows_TestAction.Conditions.Add(CCBT_T03_ReferenceDate_ScalarCheck);
            resources.ApplyResources(CCBT_T03_FPVReferenceDate_CountRows_TestAction, "CCBT_T03_FPVReferenceDate_CountRows_TestAction");
            // 
            // CCBT_T03_ReferenceDate_ScalarCheck
            // 
            CCBT_T03_ReferenceDate_ScalarCheck.ColumnNumber = 1;
            CCBT_T03_ReferenceDate_ScalarCheck.Enabled = true;
            CCBT_T03_ReferenceDate_ScalarCheck.ExpectedValue = "7";
            CCBT_T03_ReferenceDate_ScalarCheck.Name = "CCBT_T03_ReferenceDate_ScalarCheck";
            CCBT_T03_ReferenceDate_ScalarCheck.NullExpected = false;
            CCBT_T03_ReferenceDate_ScalarCheck.ResultSet = 1;
            CCBT_T03_ReferenceDate_ScalarCheck.RowNumber = 1;
            // 
            // CCBT_T04_RequestDef_CountRows_TestAction
            // 
            CCBT_T04_RequestDef_CountRows_TestAction.Conditions.Add(CCBT_T04_RequestDef_ScalarCheck);
            resources.ApplyResources(CCBT_T04_RequestDef_CountRows_TestAction, "CCBT_T04_RequestDef_CountRows_TestAction");
            // 
            // CCBT_T04_RequestDef_ScalarCheck
            // 
            CCBT_T04_RequestDef_ScalarCheck.ColumnNumber = 1;
            CCBT_T04_RequestDef_ScalarCheck.Enabled = true;
            CCBT_T04_RequestDef_ScalarCheck.ExpectedValue = "25";
            CCBT_T04_RequestDef_ScalarCheck.Name = "CCBT_T04_RequestDef_ScalarCheck";
            CCBT_T04_RequestDef_ScalarCheck.NullExpected = false;
            CCBT_T04_RequestDef_ScalarCheck.ResultSet = 1;
            CCBT_T04_RequestDef_ScalarCheck.RowNumber = 1;
            // 
            // CCBT_T05_FPVSociety_CountRows_TestAction
            // 
            CCBT_T05_FPVSociety_CountRows_TestAction.Conditions.Add(CCBT_T05_Society_ScalarCheck);
            resources.ApplyResources(CCBT_T05_FPVSociety_CountRows_TestAction, "CCBT_T05_FPVSociety_CountRows_TestAction");
            // 
            // CCBT_T05_Society_ScalarCheck
            // 
            CCBT_T05_Society_ScalarCheck.ColumnNumber = 1;
            CCBT_T05_Society_ScalarCheck.Enabled = true;
            CCBT_T05_Society_ScalarCheck.ExpectedValue = "2";
            CCBT_T05_Society_ScalarCheck.Name = "CCBT_T05_Society_ScalarCheck";
            CCBT_T05_Society_ScalarCheck.NullExpected = false;
            CCBT_T05_Society_ScalarCheck.ResultSet = 1;
            CCBT_T05_Society_ScalarCheck.RowNumber = 1;
            // 
            // CCBT_T06_FPVCalculationDef_CountRows_TestAction
            // 
            CCBT_T06_FPVCalculationDef_CountRows_TestAction.Conditions.Add(CCBT_T06_FPVCalculationDef_ScalarCheck);
            resources.ApplyResources(CCBT_T06_FPVCalculationDef_CountRows_TestAction, "CCBT_T06_FPVCalculationDef_CountRows_TestAction");
            // 
            // CCBT_T06_FPVCalculationDef_ScalarCheck
            // 
            CCBT_T06_FPVCalculationDef_ScalarCheck.ColumnNumber = 1;
            CCBT_T06_FPVCalculationDef_ScalarCheck.Enabled = true;
            CCBT_T06_FPVCalculationDef_ScalarCheck.ExpectedValue = "9";
            CCBT_T06_FPVCalculationDef_ScalarCheck.Name = "CCBT_T06_FPVCalculationDef_ScalarCheck";
            CCBT_T06_FPVCalculationDef_ScalarCheck.NullExpected = false;
            CCBT_T06_FPVCalculationDef_ScalarCheck.ResultSet = 1;
            CCBT_T06_FPVCalculationDef_ScalarCheck.RowNumber = 1;
            // 
            // CCBT_T07_StagingBroadcasterTimeBandMap_CountRows_TestAction
            // 
            CCBT_T07_StagingBroadcasterTimeBandMap_CountRows_TestAction.Conditions.Add(CCBT_T07_BroadcasterTimeBandMap_ScalarCheck);
            resources.ApplyResources(CCBT_T07_StagingBroadcasterTimeBandMap_CountRows_TestAction, "CCBT_T07_StagingBroadcasterTimeBandMap_CountRows_TestAction");
            // 
            // CCBT_T07_BroadcasterTimeBandMap_ScalarCheck
            // 
            CCBT_T07_BroadcasterTimeBandMap_ScalarCheck.ColumnNumber = 1;
            CCBT_T07_BroadcasterTimeBandMap_ScalarCheck.Enabled = true;
            CCBT_T07_BroadcasterTimeBandMap_ScalarCheck.ExpectedValue = "7";
            CCBT_T07_BroadcasterTimeBandMap_ScalarCheck.Name = "CCBT_T07_BroadcasterTimeBandMap_ScalarCheck";
            CCBT_T07_BroadcasterTimeBandMap_ScalarCheck.NullExpected = false;
            CCBT_T07_BroadcasterTimeBandMap_ScalarCheck.ResultSet = 1;
            CCBT_T07_BroadcasterTimeBandMap_ScalarCheck.RowNumber = 1;
            // 
            // CCTB_T01_ConfigValidationRules_CountRows_TestAction
            // 
            CCTB_T01_ConfigValidationRules_CountRows_TestAction.Conditions.Add(CCTB_T01_ConfigValidationRules_ScalarValue);
            resources.ApplyResources(CCTB_T01_ConfigValidationRules_CountRows_TestAction, "CCTB_T01_ConfigValidationRules_CountRows_TestAction");
            // 
            // CCTB_T01_ConfigValidationRules_ScalarValue
            // 
            CCTB_T01_ConfigValidationRules_ScalarValue.ColumnNumber = 1;
            CCTB_T01_ConfigValidationRules_ScalarValue.Enabled = true;
            CCTB_T01_ConfigValidationRules_ScalarValue.ExpectedValue = "1";
            CCTB_T01_ConfigValidationRules_ScalarValue.Name = "CCTB_T01_ConfigValidationRules_ScalarValue";
            CCTB_T01_ConfigValidationRules_ScalarValue.NullExpected = false;
            CCTB_T01_ConfigValidationRules_ScalarValue.ResultSet = 1;
            CCTB_T01_ConfigValidationRules_ScalarValue.RowNumber = 1;
            // 
            // CCTB_T02_ConfigIntegrationControl_CountRowsData
            // 
            this.CCTB_T02_ConfigIntegrationControl_CountRowsData.PosttestAction = null;
            this.CCTB_T02_ConfigIntegrationControl_CountRowsData.PretestAction = null;
            this.CCTB_T02_ConfigIntegrationControl_CountRowsData.TestAction = CCTB_T02_ConfigIntegrationControl_CountRows_TestAction;
            // 
            // CCBT_T03_FPVReferenceDate_CountRowsData
            // 
            this.CCBT_T03_FPVReferenceDate_CountRowsData.PosttestAction = null;
            this.CCBT_T03_FPVReferenceDate_CountRowsData.PretestAction = null;
            this.CCBT_T03_FPVReferenceDate_CountRowsData.TestAction = CCBT_T03_FPVReferenceDate_CountRows_TestAction;
            // 
            // CCBT_T04_RequestDef_CountRowsData
            // 
            this.CCBT_T04_RequestDef_CountRowsData.PosttestAction = null;
            this.CCBT_T04_RequestDef_CountRowsData.PretestAction = null;
            this.CCBT_T04_RequestDef_CountRowsData.TestAction = CCBT_T04_RequestDef_CountRows_TestAction;
            // 
            // CCBT_T05_FPVSociety_CountRowsData
            // 
            this.CCBT_T05_FPVSociety_CountRowsData.PosttestAction = null;
            this.CCBT_T05_FPVSociety_CountRowsData.PretestAction = null;
            this.CCBT_T05_FPVSociety_CountRowsData.TestAction = CCBT_T05_FPVSociety_CountRows_TestAction;
            // 
            // CCBT_T06_FPVCalculationDef_CountRowsData
            // 
            this.CCBT_T06_FPVCalculationDef_CountRowsData.PosttestAction = null;
            this.CCBT_T06_FPVCalculationDef_CountRowsData.PretestAction = null;
            this.CCBT_T06_FPVCalculationDef_CountRowsData.TestAction = CCBT_T06_FPVCalculationDef_CountRows_TestAction;
            // 
            // CCBT_T07_StagingBroadcasterTimeBandMap_CountRowsData
            // 
            this.CCBT_T07_StagingBroadcasterTimeBandMap_CountRowsData.PosttestAction = null;
            this.CCBT_T07_StagingBroadcasterTimeBandMap_CountRowsData.PretestAction = null;
            this.CCBT_T07_StagingBroadcasterTimeBandMap_CountRowsData.TestAction = CCBT_T07_StagingBroadcasterTimeBandMap_CountRows_TestAction;
            // 
            // CCTB_T01_ConfigValidationRules_CountRowsData
            // 
            this.CCTB_T01_ConfigValidationRules_CountRowsData.PosttestAction = null;
            this.CCTB_T01_ConfigValidationRules_CountRowsData.PretestAction = null;
            this.CCTB_T01_ConfigValidationRules_CountRowsData.TestAction = CCTB_T01_ConfigValidationRules_CountRows_TestAction;
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
        public void CCTB_T02_ConfigIntegrationControl_CountRows()
        {
            SqlDatabaseTestActions testActions = this.CCTB_T02_ConfigIntegrationControl_CountRowsData;
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
        public void CCBT_T03_FPVReferenceDate_CountRows()
        {
            SqlDatabaseTestActions testActions = this.CCBT_T03_FPVReferenceDate_CountRowsData;
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
        public void CCBT_T04_RequestDef_CountRows()
        {
            SqlDatabaseTestActions testActions = this.CCBT_T04_RequestDef_CountRowsData;
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
        public void CCBT_T05_FPVSociety_CountRows()
        {
            SqlDatabaseTestActions testActions = this.CCBT_T05_FPVSociety_CountRowsData;
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
        public void CCBT_T06_FPVCalculationDef_CountRows()
        {
            SqlDatabaseTestActions testActions = this.CCBT_T06_FPVCalculationDef_CountRowsData;
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
        public void CCBT_T07_StagingBroadcasterTimeBandMap_CountRows()
        {
            SqlDatabaseTestActions testActions = this.CCBT_T07_StagingBroadcasterTimeBandMap_CountRowsData;
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
        public void CCTB_T01_ConfigValidationRules_CountRows()
        {
            SqlDatabaseTestActions testActions = this.CCTB_T01_ConfigValidationRules_CountRowsData;
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






        private SqlDatabaseTestActions CCTB_T02_ConfigIntegrationControl_CountRowsData;
        private SqlDatabaseTestActions CCBT_T03_FPVReferenceDate_CountRowsData;
        private SqlDatabaseTestActions CCBT_T04_RequestDef_CountRowsData;
        private SqlDatabaseTestActions CCBT_T05_FPVSociety_CountRowsData;
        private SqlDatabaseTestActions CCBT_T06_FPVCalculationDef_CountRowsData;
        private SqlDatabaseTestActions CCBT_T07_StagingBroadcasterTimeBandMap_CountRowsData;
        private SqlDatabaseTestActions CCTB_T01_ConfigValidationRules_CountRowsData;
    }
}
