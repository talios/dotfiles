function psql-smx
    set baseapp $argv[1]
    set shorthost $argv[2]

    switch $baseapp-$shorthost

        case ident-xms
            set DBHOST psql-smx3idnt-ae-stg-spe.postgres.database.azure.com
            set DBNAME postgres

        case smx-aud
            set DBHOST aud-portal-pgsf.postgres.database.azure.com
            set DBNAME aud-portal-smx3
        case smx-aus
            set DBHOST aus-portal-pgsf.postgres.database.azure.com
            set DBNAME aus-portal-smx3
        case smx-aut
            set DBHOST aut-portal-pgsf.postgres.database.azure.com
            set DBNAME aut-portal-smx3
        case smx-au3
            set DBHOST au3-portal-pgsf.postgres.database.azure.com
            set DBNAME au3-portal-smx3

        case stats-aud
            set DBHOST smx-ase-dev-statsparser-pgsf.postgres.database.azure.com
            set DBNAME aud-smx3_mailreport
        case stats-aus
            set DBHOST smx-ase-stage-statsparser-pgsf.postgres.database.azure.com
            set DBNAME aus-smx3_mailreport
        case stats-aut
            set DBHOST smx-ase-test-statsparser-pgsf.postgres.database.azure.com
            set DBNAME aut-smx3_mailreport
        case stats-au3
            set DBHOST smx-ase-prod-statsparser-pgsf.postgres.database.azure.com
            set DBNAME au3-smx3_mailreport

        case stix-aus
            set DBHOST smx-ase-stage-stixparser-pgsf.postgres.database.azure.com
            set DBNAME smx-ase-stage-stixdb

        case drm-xms
            set DBHOST xm-ae-stage-hst-drmgr-pgsf.postgres.database.azure.com
            set DBNAME disaster-recovery
        case drm-xm1
            set DBHOST xm-ae-prod-hst-drmgr-pgsf.postgres.database.azure.com
            set DBNAME disaster-recovery
        case drm-sp1
            set DBHOST psql-drmgmt-nzn-prd-dr.postgres.database.azure.com
            set DBNAME disaster-recovery

        case mr-xmd
            set DBHOST xm-ae-dev-hst-remediationmgr-pgsf.postgres.database.azure.com
            set DBNAME msgremediation
        case mr-xms
            set DBHOST xm-ae-stage-hst-remediationmgr-pgsf.postgres.database.azure.com
            set DBNAME msgremediation
        case mr-xm1
            set DBHOST xm-ae-prod-hst-remediationmgr-pgsf.postgres.database.azure.com
            set DBNAME msgremediation

        case '*'
            echo "ERR: No Matching app/platform"
            return
    end

    switch $shorthost
        case aud aus aut au3 xms xm1
            echo "Looking up credentials from Azure"
            set -x PGPASSWORD (az account get-access-token --resource-type oss-rdbms --query "[accessToken]" -o tsv)
            set PGURL host=$DBHOST user=Developers dbname=$DBNAME sslmode=require
        case sp1
            echo "Looking up prod credentials from Azure"
            # pgsql:drmanager@psql-drmgmt-nzn-prd-dr
            set -x PGPASSWORD (az account get-access-token --resource-type oss-rdbms --query "[accessToken]" -o tsv)
            # set -x PGPASSWORD (op item get "pgsql:drmanager@psql-drmgmt-nzn-prd-dr" --fields=password)
            # echo $PGPASSWORD
            set PGURL host=$DBHOST user=Usergroup-Developers dbname=$DBNAME sslmode=require
        case '*'
            set PGURL host=localhost user=smx dbname=smx3
    end
    echo "Connecting to $PGURL"
    psql-17 --set AUTOCOMMIT=off "$PGURL"
end
