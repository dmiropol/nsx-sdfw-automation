#!/bin/bash

echo "Stopping idps-reporting-service..."
service idps-reporting-service stop

java -cp /usr/share/corfu/lib/corfudb-tools-3.1.20201022192550.7817.1-shaded.jar org.corfudb.browser.CorfuStoreBrowserMain --host=10.114.209.149 --port=9040 --namespace=security_data_service --tablename=ids_event_data --operation=dropTable --tlsEnabled=true --keystore=/config/cluster-manager/corfu/private/keystore.jks --ks_password=/config/cluster-manager/corfu/private/keystore.password --truststore=/config/cluster-manager/corfu/public/truststore.jks --truststore_password=/config/cluster-manager/corfu/public/truststore.password

curl -X PUT -H "Content-Type: application/json" "localhost:9200/security_data_service_metadata/_doc/security_data_service?pretty" -d' {"clusterId" : "-1"}'

echo "Starting idps-reporting-service..."
service idps-reporting-service start
echo "idps is cleared"
