#Set executionPolicy to RemoteSigned
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Install the Az PowerShell Module in Windows PowerShell
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

#Set the default subscriptionID used by the Connect-AzAccount command that follows 
Update-AzConfig -DefaultSubscriptionForLogin 08ad88d6-3943-4db4-bff0-05b76389669f

#login, ##Follow prompts on the browser window opened. Account should have Storage Blob Contributor role
Connect-AzAccount   

#Set variable for the storage account
$acc = Get-AzStorageAccount -Name "oafdatabasebackups" -ResourceGroupName "rg-storageaccounts-prod"

#set variable for all blobs to be rehydrated
$blobs = Get-AzStorageBlob -Prefix "DSS-Storage/OAF-Soil-Lab-Folder" -Container "bkp-datawarehouse" -Context $acc.Context | Where-Object{$_.ICloudBlob.Properties.StandardBlobTier -eq "Archive"} #get all of your archived blobs under a virtual folder,including blobs in sub virtual folders 

#iterate through each of the blobs in the variable $blobs and mark them HOT from Archive tier
foreach($blob in $blobs){ $blob.ICloudBlob.SetStandardBlobTier("Hot");}
