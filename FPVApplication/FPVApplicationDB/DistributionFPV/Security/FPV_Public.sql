CREATE SCHEMA [FPV_Public]
    AUTHORIZATION [dbo];


GO
GRANT SELECT
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_user];


GO
GRANT SELECT
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_reporting];


GO
GRANT SELECT
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_approver];


GO
GRANT SELECT
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_admin];


GO
GRANT INSERT
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_user];


GO
GRANT INSERT
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_reporting];


GO
GRANT INSERT
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_approver];


GO
GRANT INSERT
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_admin];


GO
GRANT EXECUTE
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_user];


GO
GRANT EXECUTE
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_reporting];


GO
GRANT EXECUTE
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_approver];


GO
GRANT EXECUTE
    ON SCHEMA::[FPV_Public] TO [prs_abacusapplication_admin];

