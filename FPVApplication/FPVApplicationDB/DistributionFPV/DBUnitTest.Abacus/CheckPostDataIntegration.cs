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
    public class CheckPostDataIntegration : SqlDatabaseTestClass
    {

        public CheckPostDataIntegration()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPSP_T20_Distribution_ProcTest_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CheckPostDataIntegration));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPSP_T20_Distribution_CountRows;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T01_StagingAudienceReachBARB_AudienceMart_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T01_StagingAudienceReachBARB_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T02_StagingAudienceReachRAJAR_AudienceMart_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T02_StagingAudienceReachRAJAR_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T03_StagingDistributionMissingMinutes_DDI_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T03_StagingDistributionMissingMinutes_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T04_StagingDistributionMusicMinutes_DDI_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T04_StagingDistributionMusicMinutes_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T05_StagingDistributionPlanningRevenue_FDM_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T05_StagingDistributionPlanningRevenue_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T06_StagingDistributionPublicReception_DDI_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T06_StagingDistributionPublicReception_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T07_StagingLicenceGroup_MDS_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T07_StagingLicenceGroup_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T08_StagingLicencePeriodScenarios_MDS_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T08_StagingLicencePeriodScenarios_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T09_StagingMasterDistributionGroup_MDS_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T09_StagingMasterDistributionGroup_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T10_StagingMasterDistributionPeriod_MDS_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T10_StagingMasterDistributionPeriod_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T11_StagingMasterPlanningScenario_FDM_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T11_StagingMasterPlanningScenario_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T12_StagingMasterStation_MDS_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T12_StagingMasterStation_Scalar;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction CPDI_T13_StagingStationUDCMapping_MDS_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition CPDI_T13_StagingStationUDCMapping_Scalar;
            this.CPSP_T20_Distribution_ProcTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T01_StagingAudienceReachBARB_AudienceMartData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T02_StagingAudienceReachRAJAR_AudienceMartData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T03_StagingDistributionMissingMinutes_DDIData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T04_StagingDistributionMusicMinutes_DDIData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T05_StagingDistributionPlanningRevenue_FDMData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T06_StagingDistributionPublicReception_DDIData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T07_StagingLicenceGroup_MDSData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T08_StagingLicencePeriodScenarios_MDSData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T09_StagingMasterDistributionGroup_MDSData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T10_StagingMasterDistributionPeriod_MDSData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T11_StagingMasterPlanningScenario_FDMData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T12_StagingMasterStation_MDSData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.CPDI_T13_StagingStationUDCMapping_MDSData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            CPSP_T20_Distribution_ProcTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPSP_T20_Distribution_CountRows = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T01_StagingAudienceReachBARB_AudienceMart_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T01_StagingAudienceReachBARB_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T02_StagingAudienceReachRAJAR_AudienceMart_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T02_StagingAudienceReachRAJAR_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T03_StagingDistributionMissingMinutes_DDI_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T03_StagingDistributionMissingMinutes_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T04_StagingDistributionMusicMinutes_DDI_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T04_StagingDistributionMusicMinutes_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T05_StagingDistributionPlanningRevenue_FDM_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T05_StagingDistributionPlanningRevenue_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T06_StagingDistributionPublicReception_DDI_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T06_StagingDistributionPublicReception_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T07_StagingLicenceGroup_MDS_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T07_StagingLicenceGroup_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T08_StagingLicencePeriodScenarios_MDS_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T08_StagingLicencePeriodScenarios_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T09_StagingMasterDistributionGroup_MDS_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T09_StagingMasterDistributionGroup_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T10_StagingMasterDistributionPeriod_MDS_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T10_StagingMasterDistributionPeriod_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T11_StagingMasterPlanningScenario_FDM_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T11_StagingMasterPlanningScenario_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T12_StagingMasterStation_MDS_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T12_StagingMasterStation_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            CPDI_T13_StagingStationUDCMapping_MDS_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            CPDI_T13_StagingStationUDCMapping_Scalar = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ScalarValueCondition();
            // 
            // CPSP_T20_Distribution_ProcTest_TestAction
            // 
            CPSP_T20_Distribution_ProcTest_TestAction.Conditions.Add(CPSP_T20_Distribution_CountRows);
            resources.ApplyResources(CPSP_T20_Distribution_ProcTest_TestAction, "CPSP_T20_Distribution_ProcTest_TestAction");
            // 
            // CPSP_T20_Distribution_CountRows
            // 
            CPSP_T20_Distribution_CountRows.ColumnNumber = 2;
            CPSP_T20_Distribution_CountRows.Enabled = true;
            CPSP_T20_Distribution_CountRows.ExpectedValue = "24";
            CPSP_T20_Distribution_CountRows.Name = "CPSP_T20_Distribution_CountRows";
            CPSP_T20_Distribution_CountRows.NullExpected = false;
            CPSP_T20_Distribution_CountRows.ResultSet = 1;
            CPSP_T20_Distribution_CountRows.RowNumber = 1;
            // 
            // CPSP_T20_Distribution_ProcTestData
            // 
            this.CPSP_T20_Distribution_ProcTestData.PosttestAction = null;
            this.CPSP_T20_Distribution_ProcTestData.PretestAction = null;
            this.CPSP_T20_Distribution_ProcTestData.TestAction = CPSP_T20_Distribution_ProcTest_TestAction;
            // 
            // CPDI_T01_StagingAudienceReachBARB_AudienceMartData
            // 
            this.CPDI_T01_StagingAudienceReachBARB_AudienceMartData.PosttestAction = null;
            this.CPDI_T01_StagingAudienceReachBARB_AudienceMartData.PretestAction = null;
            this.CPDI_T01_StagingAudienceReachBARB_AudienceMartData.TestAction = CPDI_T01_StagingAudienceReachBARB_AudienceMart_TestAction;
            // 
            // CPDI_T01_StagingAudienceReachBARB_AudienceMart_TestAction
            // 
            CPDI_T01_StagingAudienceReachBARB_AudienceMart_TestAction.Conditions.Add(CPDI_T01_StagingAudienceReachBARB_Scalar);
            resources.ApplyResources(CPDI_T01_StagingAudienceReachBARB_AudienceMart_TestAction, "CPDI_T01_StagingAudienceReachBARB_AudienceMart_TestAction");
            // 
            // CPDI_T01_StagingAudienceReachBARB_Scalar
            // 
            CPDI_T01_StagingAudienceReachBARB_Scalar.ColumnNumber = 1;
            CPDI_T01_StagingAudienceReachBARB_Scalar.Enabled = true;
            CPDI_T01_StagingAudienceReachBARB_Scalar.ExpectedValue = "1";
            CPDI_T01_StagingAudienceReachBARB_Scalar.Name = "CPDI_T01_StagingAudienceReachBARB_Scalar";
            CPDI_T01_StagingAudienceReachBARB_Scalar.NullExpected = false;
            CPDI_T01_StagingAudienceReachBARB_Scalar.ResultSet = 1;
            CPDI_T01_StagingAudienceReachBARB_Scalar.RowNumber = 1;
            // 
            // CPDI_T02_StagingAudienceReachRAJAR_AudienceMartData
            // 
            this.CPDI_T02_StagingAudienceReachRAJAR_AudienceMartData.PosttestAction = null;
            this.CPDI_T02_StagingAudienceReachRAJAR_AudienceMartData.PretestAction = null;
            this.CPDI_T02_StagingAudienceReachRAJAR_AudienceMartData.TestAction = CPDI_T02_StagingAudienceReachRAJAR_AudienceMart_TestAction;
            // 
            // CPDI_T02_StagingAudienceReachRAJAR_AudienceMart_TestAction
            // 
            CPDI_T02_StagingAudienceReachRAJAR_AudienceMart_TestAction.Conditions.Add(CPDI_T02_StagingAudienceReachRAJAR_Scalar);
            resources.ApplyResources(CPDI_T02_StagingAudienceReachRAJAR_AudienceMart_TestAction, "CPDI_T02_StagingAudienceReachRAJAR_AudienceMart_TestAction");
            // 
            // CPDI_T02_StagingAudienceReachRAJAR_Scalar
            // 
            CPDI_T02_StagingAudienceReachRAJAR_Scalar.ColumnNumber = 1;
            CPDI_T02_StagingAudienceReachRAJAR_Scalar.Enabled = true;
            CPDI_T02_StagingAudienceReachRAJAR_Scalar.ExpectedValue = "1";
            CPDI_T02_StagingAudienceReachRAJAR_Scalar.Name = "CPDI_T02_StagingAudienceReachRAJAR_Scalar";
            CPDI_T02_StagingAudienceReachRAJAR_Scalar.NullExpected = false;
            CPDI_T02_StagingAudienceReachRAJAR_Scalar.ResultSet = 1;
            CPDI_T02_StagingAudienceReachRAJAR_Scalar.RowNumber = 1;
            // 
            // CPDI_T03_StagingDistributionMissingMinutes_DDIData
            // 
            this.CPDI_T03_StagingDistributionMissingMinutes_DDIData.PosttestAction = null;
            this.CPDI_T03_StagingDistributionMissingMinutes_DDIData.PretestAction = null;
            this.CPDI_T03_StagingDistributionMissingMinutes_DDIData.TestAction = CPDI_T03_StagingDistributionMissingMinutes_DDI_TestAction;
            // 
            // CPDI_T03_StagingDistributionMissingMinutes_DDI_TestAction
            // 
            CPDI_T03_StagingDistributionMissingMinutes_DDI_TestAction.Conditions.Add(CPDI_T03_StagingDistributionMissingMinutes_Scalar);
            resources.ApplyResources(CPDI_T03_StagingDistributionMissingMinutes_DDI_TestAction, "CPDI_T03_StagingDistributionMissingMinutes_DDI_TestAction");
            // 
            // CPDI_T03_StagingDistributionMissingMinutes_Scalar
            // 
            CPDI_T03_StagingDistributionMissingMinutes_Scalar.ColumnNumber = 1;
            CPDI_T03_StagingDistributionMissingMinutes_Scalar.Enabled = true;
            CPDI_T03_StagingDistributionMissingMinutes_Scalar.ExpectedValue = null;
            CPDI_T03_StagingDistributionMissingMinutes_Scalar.Name = "CPDI_T03_StagingDistributionMissingMinutes_Scalar";
            CPDI_T03_StagingDistributionMissingMinutes_Scalar.NullExpected = true;
            CPDI_T03_StagingDistributionMissingMinutes_Scalar.ResultSet = 1;
            CPDI_T03_StagingDistributionMissingMinutes_Scalar.RowNumber = 1;
            // 
            // CPDI_T04_StagingDistributionMusicMinutes_DDIData
            // 
            this.CPDI_T04_StagingDistributionMusicMinutes_DDIData.PosttestAction = null;
            this.CPDI_T04_StagingDistributionMusicMinutes_DDIData.PretestAction = null;
            this.CPDI_T04_StagingDistributionMusicMinutes_DDIData.TestAction = CPDI_T04_StagingDistributionMusicMinutes_DDI_TestAction;
            // 
            // CPDI_T04_StagingDistributionMusicMinutes_DDI_TestAction
            // 
            CPDI_T04_StagingDistributionMusicMinutes_DDI_TestAction.Conditions.Add(CPDI_T04_StagingDistributionMusicMinutes_Scalar);
            resources.ApplyResources(CPDI_T04_StagingDistributionMusicMinutes_DDI_TestAction, "CPDI_T04_StagingDistributionMusicMinutes_DDI_TestAction");
            // 
            // CPDI_T04_StagingDistributionMusicMinutes_Scalar
            // 
            CPDI_T04_StagingDistributionMusicMinutes_Scalar.ColumnNumber = 1;
            CPDI_T04_StagingDistributionMusicMinutes_Scalar.Enabled = true;
            CPDI_T04_StagingDistributionMusicMinutes_Scalar.ExpectedValue = "1";
            CPDI_T04_StagingDistributionMusicMinutes_Scalar.Name = "CPDI_T04_StagingDistributionMusicMinutes_Scalar";
            CPDI_T04_StagingDistributionMusicMinutes_Scalar.NullExpected = false;
            CPDI_T04_StagingDistributionMusicMinutes_Scalar.ResultSet = 1;
            CPDI_T04_StagingDistributionMusicMinutes_Scalar.RowNumber = 1;
            // 
            // CPDI_T05_StagingDistributionPlanningRevenue_FDMData
            // 
            this.CPDI_T05_StagingDistributionPlanningRevenue_FDMData.PosttestAction = null;
            this.CPDI_T05_StagingDistributionPlanningRevenue_FDMData.PretestAction = null;
            this.CPDI_T05_StagingDistributionPlanningRevenue_FDMData.TestAction = CPDI_T05_StagingDistributionPlanningRevenue_FDM_TestAction;
            // 
            // CPDI_T05_StagingDistributionPlanningRevenue_FDM_TestAction
            // 
            CPDI_T05_StagingDistributionPlanningRevenue_FDM_TestAction.Conditions.Add(CPDI_T05_StagingDistributionPlanningRevenue_Scalar);
            resources.ApplyResources(CPDI_T05_StagingDistributionPlanningRevenue_FDM_TestAction, "CPDI_T05_StagingDistributionPlanningRevenue_FDM_TestAction");
            // 
            // CPDI_T05_StagingDistributionPlanningRevenue_Scalar
            // 
            CPDI_T05_StagingDistributionPlanningRevenue_Scalar.ColumnNumber = 1;
            CPDI_T05_StagingDistributionPlanningRevenue_Scalar.Enabled = true;
            CPDI_T05_StagingDistributionPlanningRevenue_Scalar.ExpectedValue = "1";
            CPDI_T05_StagingDistributionPlanningRevenue_Scalar.Name = "CPDI_T05_StagingDistributionPlanningRevenue_Scalar";
            CPDI_T05_StagingDistributionPlanningRevenue_Scalar.NullExpected = false;
            CPDI_T05_StagingDistributionPlanningRevenue_Scalar.ResultSet = 1;
            CPDI_T05_StagingDistributionPlanningRevenue_Scalar.RowNumber = 1;
            // 
            // CPDI_T06_StagingDistributionPublicReception_DDIData
            // 
            this.CPDI_T06_StagingDistributionPublicReception_DDIData.PosttestAction = null;
            this.CPDI_T06_StagingDistributionPublicReception_DDIData.PretestAction = null;
            this.CPDI_T06_StagingDistributionPublicReception_DDIData.TestAction = CPDI_T06_StagingDistributionPublicReception_DDI_TestAction;
            // 
            // CPDI_T06_StagingDistributionPublicReception_DDI_TestAction
            // 
            CPDI_T06_StagingDistributionPublicReception_DDI_TestAction.Conditions.Add(CPDI_T06_StagingDistributionPublicReception_Scalar);
            resources.ApplyResources(CPDI_T06_StagingDistributionPublicReception_DDI_TestAction, "CPDI_T06_StagingDistributionPublicReception_DDI_TestAction");
            // 
            // CPDI_T06_StagingDistributionPublicReception_Scalar
            // 
            CPDI_T06_StagingDistributionPublicReception_Scalar.ColumnNumber = 1;
            CPDI_T06_StagingDistributionPublicReception_Scalar.Enabled = true;
            CPDI_T06_StagingDistributionPublicReception_Scalar.ExpectedValue = "1";
            CPDI_T06_StagingDistributionPublicReception_Scalar.Name = "CPDI_T06_StagingDistributionPublicReception_Scalar";
            CPDI_T06_StagingDistributionPublicReception_Scalar.NullExpected = false;
            CPDI_T06_StagingDistributionPublicReception_Scalar.ResultSet = 1;
            CPDI_T06_StagingDistributionPublicReception_Scalar.RowNumber = 1;
            // 
            // CPDI_T07_StagingLicenceGroup_MDSData
            // 
            this.CPDI_T07_StagingLicenceGroup_MDSData.PosttestAction = null;
            this.CPDI_T07_StagingLicenceGroup_MDSData.PretestAction = null;
            this.CPDI_T07_StagingLicenceGroup_MDSData.TestAction = CPDI_T07_StagingLicenceGroup_MDS_TestAction;
            // 
            // CPDI_T07_StagingLicenceGroup_MDS_TestAction
            // 
            CPDI_T07_StagingLicenceGroup_MDS_TestAction.Conditions.Add(CPDI_T07_StagingLicenceGroup_Scalar);
            resources.ApplyResources(CPDI_T07_StagingLicenceGroup_MDS_TestAction, "CPDI_T07_StagingLicenceGroup_MDS_TestAction");
            // 
            // CPDI_T07_StagingLicenceGroup_Scalar
            // 
            CPDI_T07_StagingLicenceGroup_Scalar.ColumnNumber = 1;
            CPDI_T07_StagingLicenceGroup_Scalar.Enabled = true;
            CPDI_T07_StagingLicenceGroup_Scalar.ExpectedValue = "1";
            CPDI_T07_StagingLicenceGroup_Scalar.Name = "CPDI_T07_StagingLicenceGroup_Scalar";
            CPDI_T07_StagingLicenceGroup_Scalar.NullExpected = false;
            CPDI_T07_StagingLicenceGroup_Scalar.ResultSet = 1;
            CPDI_T07_StagingLicenceGroup_Scalar.RowNumber = 1;
            // 
            // CPDI_T08_StagingLicencePeriodScenarios_MDSData
            // 
            this.CPDI_T08_StagingLicencePeriodScenarios_MDSData.PosttestAction = null;
            this.CPDI_T08_StagingLicencePeriodScenarios_MDSData.PretestAction = null;
            this.CPDI_T08_StagingLicencePeriodScenarios_MDSData.TestAction = CPDI_T08_StagingLicencePeriodScenarios_MDS_TestAction;
            // 
            // CPDI_T08_StagingLicencePeriodScenarios_MDS_TestAction
            // 
            CPDI_T08_StagingLicencePeriodScenarios_MDS_TestAction.Conditions.Add(CPDI_T08_StagingLicencePeriodScenarios_Scalar);
            resources.ApplyResources(CPDI_T08_StagingLicencePeriodScenarios_MDS_TestAction, "CPDI_T08_StagingLicencePeriodScenarios_MDS_TestAction");
            // 
            // CPDI_T08_StagingLicencePeriodScenarios_Scalar
            // 
            CPDI_T08_StagingLicencePeriodScenarios_Scalar.ColumnNumber = 1;
            CPDI_T08_StagingLicencePeriodScenarios_Scalar.Enabled = true;
            CPDI_T08_StagingLicencePeriodScenarios_Scalar.ExpectedValue = "1";
            CPDI_T08_StagingLicencePeriodScenarios_Scalar.Name = "CPDI_T08_StagingLicencePeriodScenarios_Scalar";
            CPDI_T08_StagingLicencePeriodScenarios_Scalar.NullExpected = false;
            CPDI_T08_StagingLicencePeriodScenarios_Scalar.ResultSet = 1;
            CPDI_T08_StagingLicencePeriodScenarios_Scalar.RowNumber = 1;
            // 
            // CPDI_T09_StagingMasterDistributionGroup_MDSData
            // 
            this.CPDI_T09_StagingMasterDistributionGroup_MDSData.PosttestAction = null;
            this.CPDI_T09_StagingMasterDistributionGroup_MDSData.PretestAction = null;
            this.CPDI_T09_StagingMasterDistributionGroup_MDSData.TestAction = CPDI_T09_StagingMasterDistributionGroup_MDS_TestAction;
            // 
            // CPDI_T09_StagingMasterDistributionGroup_MDS_TestAction
            // 
            CPDI_T09_StagingMasterDistributionGroup_MDS_TestAction.Conditions.Add(CPDI_T09_StagingMasterDistributionGroup_Scalar);
            resources.ApplyResources(CPDI_T09_StagingMasterDistributionGroup_MDS_TestAction, "CPDI_T09_StagingMasterDistributionGroup_MDS_TestAction");
            // 
            // CPDI_T09_StagingMasterDistributionGroup_Scalar
            // 
            CPDI_T09_StagingMasterDistributionGroup_Scalar.ColumnNumber = 1;
            CPDI_T09_StagingMasterDistributionGroup_Scalar.Enabled = true;
            CPDI_T09_StagingMasterDistributionGroup_Scalar.ExpectedValue = "1";
            CPDI_T09_StagingMasterDistributionGroup_Scalar.Name = "CPDI_T09_StagingMasterDistributionGroup_Scalar";
            CPDI_T09_StagingMasterDistributionGroup_Scalar.NullExpected = false;
            CPDI_T09_StagingMasterDistributionGroup_Scalar.ResultSet = 1;
            CPDI_T09_StagingMasterDistributionGroup_Scalar.RowNumber = 1;
            // 
            // CPDI_T10_StagingMasterDistributionPeriod_MDSData
            // 
            this.CPDI_T10_StagingMasterDistributionPeriod_MDSData.PosttestAction = null;
            this.CPDI_T10_StagingMasterDistributionPeriod_MDSData.PretestAction = null;
            this.CPDI_T10_StagingMasterDistributionPeriod_MDSData.TestAction = CPDI_T10_StagingMasterDistributionPeriod_MDS_TestAction;
            // 
            // CPDI_T10_StagingMasterDistributionPeriod_MDS_TestAction
            // 
            CPDI_T10_StagingMasterDistributionPeriod_MDS_TestAction.Conditions.Add(CPDI_T10_StagingMasterDistributionPeriod_Scalar);
            resources.ApplyResources(CPDI_T10_StagingMasterDistributionPeriod_MDS_TestAction, "CPDI_T10_StagingMasterDistributionPeriod_MDS_TestAction");
            // 
            // CPDI_T10_StagingMasterDistributionPeriod_Scalar
            // 
            CPDI_T10_StagingMasterDistributionPeriod_Scalar.ColumnNumber = 1;
            CPDI_T10_StagingMasterDistributionPeriod_Scalar.Enabled = true;
            CPDI_T10_StagingMasterDistributionPeriod_Scalar.ExpectedValue = "1";
            CPDI_T10_StagingMasterDistributionPeriod_Scalar.Name = "CPDI_T10_StagingMasterDistributionPeriod_Scalar";
            CPDI_T10_StagingMasterDistributionPeriod_Scalar.NullExpected = false;
            CPDI_T10_StagingMasterDistributionPeriod_Scalar.ResultSet = 1;
            CPDI_T10_StagingMasterDistributionPeriod_Scalar.RowNumber = 1;
            // 
            // CPDI_T11_StagingMasterPlanningScenario_FDMData
            // 
            this.CPDI_T11_StagingMasterPlanningScenario_FDMData.PosttestAction = null;
            this.CPDI_T11_StagingMasterPlanningScenario_FDMData.PretestAction = null;
            this.CPDI_T11_StagingMasterPlanningScenario_FDMData.TestAction = CPDI_T11_StagingMasterPlanningScenario_FDM_TestAction;
            // 
            // CPDI_T11_StagingMasterPlanningScenario_FDM_TestAction
            // 
            CPDI_T11_StagingMasterPlanningScenario_FDM_TestAction.Conditions.Add(CPDI_T11_StagingMasterPlanningScenario_Scalar);
            resources.ApplyResources(CPDI_T11_StagingMasterPlanningScenario_FDM_TestAction, "CPDI_T11_StagingMasterPlanningScenario_FDM_TestAction");
            // 
            // CPDI_T11_StagingMasterPlanningScenario_Scalar
            // 
            CPDI_T11_StagingMasterPlanningScenario_Scalar.ColumnNumber = 1;
            CPDI_T11_StagingMasterPlanningScenario_Scalar.Enabled = true;
            CPDI_T11_StagingMasterPlanningScenario_Scalar.ExpectedValue = "1";
            CPDI_T11_StagingMasterPlanningScenario_Scalar.Name = "CPDI_T11_StagingMasterPlanningScenario_Scalar";
            CPDI_T11_StagingMasterPlanningScenario_Scalar.NullExpected = false;
            CPDI_T11_StagingMasterPlanningScenario_Scalar.ResultSet = 1;
            CPDI_T11_StagingMasterPlanningScenario_Scalar.RowNumber = 1;
            // 
            // CPDI_T12_StagingMasterStation_MDSData
            // 
            this.CPDI_T12_StagingMasterStation_MDSData.PosttestAction = null;
            this.CPDI_T12_StagingMasterStation_MDSData.PretestAction = null;
            this.CPDI_T12_StagingMasterStation_MDSData.TestAction = CPDI_T12_StagingMasterStation_MDS_TestAction;
            // 
            // CPDI_T12_StagingMasterStation_MDS_TestAction
            // 
            CPDI_T12_StagingMasterStation_MDS_TestAction.Conditions.Add(CPDI_T12_StagingMasterStation_Scalar);
            resources.ApplyResources(CPDI_T12_StagingMasterStation_MDS_TestAction, "CPDI_T12_StagingMasterStation_MDS_TestAction");
            // 
            // CPDI_T12_StagingMasterStation_Scalar
            // 
            CPDI_T12_StagingMasterStation_Scalar.ColumnNumber = 1;
            CPDI_T12_StagingMasterStation_Scalar.Enabled = true;
            CPDI_T12_StagingMasterStation_Scalar.ExpectedValue = "1";
            CPDI_T12_StagingMasterStation_Scalar.Name = "CPDI_T12_StagingMasterStation_Scalar";
            CPDI_T12_StagingMasterStation_Scalar.NullExpected = false;
            CPDI_T12_StagingMasterStation_Scalar.ResultSet = 1;
            CPDI_T12_StagingMasterStation_Scalar.RowNumber = 1;
            // 
            // CPDI_T13_StagingStationUDCMapping_MDSData
            // 
            this.CPDI_T13_StagingStationUDCMapping_MDSData.PosttestAction = null;
            this.CPDI_T13_StagingStationUDCMapping_MDSData.PretestAction = null;
            this.CPDI_T13_StagingStationUDCMapping_MDSData.TestAction = CPDI_T13_StagingStationUDCMapping_MDS_TestAction;
            // 
            // CPDI_T13_StagingStationUDCMapping_MDS_TestAction
            // 
            CPDI_T13_StagingStationUDCMapping_MDS_TestAction.Conditions.Add(CPDI_T13_StagingStationUDCMapping_Scalar);
            resources.ApplyResources(CPDI_T13_StagingStationUDCMapping_MDS_TestAction, "CPDI_T13_StagingStationUDCMapping_MDS_TestAction");
            // 
            // CPDI_T13_StagingStationUDCMapping_Scalar
            // 
            CPDI_T13_StagingStationUDCMapping_Scalar.ColumnNumber = 1;
            CPDI_T13_StagingStationUDCMapping_Scalar.Enabled = true;
            CPDI_T13_StagingStationUDCMapping_Scalar.ExpectedValue = "1";
            CPDI_T13_StagingStationUDCMapping_Scalar.Name = "CPDI_T13_StagingStationUDCMapping_Scalar";
            CPDI_T13_StagingStationUDCMapping_Scalar.NullExpected = false;
            CPDI_T13_StagingStationUDCMapping_Scalar.ResultSet = 1;
            CPDI_T13_StagingStationUDCMapping_Scalar.RowNumber = 1;
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

         
        public void CPSP_T20_Distribution_ProcTest()
        {
            SqlDatabaseTestActions testActions = this.CPSP_T20_Distribution_ProcTestData;
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
        public void CPDI_T01_StagingAudienceReachBARB_AudienceMart()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T01_StagingAudienceReachBARB_AudienceMartData;
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
        public void CPDI_T02_StagingAudienceReachRAJAR_AudienceMart()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T02_StagingAudienceReachRAJAR_AudienceMartData;
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
        public void CPDI_T03_StagingDistributionMissingMinutes_DDI()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T03_StagingDistributionMissingMinutes_DDIData;
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
        public void CPDI_T04_StagingDistributionMusicMinutes_DDI()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T04_StagingDistributionMusicMinutes_DDIData;
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
        public void CPDI_T05_StagingDistributionPlanningRevenue_FDM()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T05_StagingDistributionPlanningRevenue_FDMData;
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
        public void CPDI_T06_StagingDistributionPublicReception_DDI()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T06_StagingDistributionPublicReception_DDIData;
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
        public void CPDI_T07_StagingLicenceGroup_MDS()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T07_StagingLicenceGroup_MDSData;
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
        public void CPDI_T08_StagingLicencePeriodScenarios_MDS()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T08_StagingLicencePeriodScenarios_MDSData;
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
        public void CPDI_T09_StagingMasterDistributionGroup_MDS()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T09_StagingMasterDistributionGroup_MDSData;
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
        public void CPDI_T10_StagingMasterDistributionPeriod_MDS()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T10_StagingMasterDistributionPeriod_MDSData;
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
        public void CPDI_T11_StagingMasterPlanningScenario_FDM()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T11_StagingMasterPlanningScenario_FDMData;
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
        public void CPDI_T12_StagingMasterStation_MDS()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T12_StagingMasterStation_MDSData;
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
        public void CPDI_T13_StagingStationUDCMapping_MDS()
        {
            SqlDatabaseTestActions testActions = this.CPDI_T13_StagingStationUDCMapping_MDSData;
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













        private SqlDatabaseTestActions CPSP_T20_Distribution_ProcTestData;
        private SqlDatabaseTestActions CPDI_T01_StagingAudienceReachBARB_AudienceMartData;
        private SqlDatabaseTestActions CPDI_T02_StagingAudienceReachRAJAR_AudienceMartData;
        private SqlDatabaseTestActions CPDI_T03_StagingDistributionMissingMinutes_DDIData;
        private SqlDatabaseTestActions CPDI_T04_StagingDistributionMusicMinutes_DDIData;
        private SqlDatabaseTestActions CPDI_T05_StagingDistributionPlanningRevenue_FDMData;
        private SqlDatabaseTestActions CPDI_T06_StagingDistributionPublicReception_DDIData;
        private SqlDatabaseTestActions CPDI_T07_StagingLicenceGroup_MDSData;
        private SqlDatabaseTestActions CPDI_T08_StagingLicencePeriodScenarios_MDSData;
        private SqlDatabaseTestActions CPDI_T09_StagingMasterDistributionGroup_MDSData;
        private SqlDatabaseTestActions CPDI_T10_StagingMasterDistributionPeriod_MDSData;
        private SqlDatabaseTestActions CPDI_T11_StagingMasterPlanningScenario_FDMData;
        private SqlDatabaseTestActions CPDI_T12_StagingMasterStation_MDSData;
        private SqlDatabaseTestActions CPDI_T13_StagingStationUDCMapping_MDSData;
    }
}
