#uses Azure CLI
az storage blob set-tier  --account-name oafdatabasebackups --container-name bkp-datawarehouse  --name "DSS-Storage/OAF-Soil-Lab-Folder/sample-report-2.docx" --tier Hot  --rehydrate-priority Standard --auth-mode login
