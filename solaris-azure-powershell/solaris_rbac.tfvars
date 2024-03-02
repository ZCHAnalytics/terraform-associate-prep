az account show --query id --output tsv
azure subscription id: 9e04f9bb-d4fa-4d92-93e7-e27b01bf3cfd
az account set --subscription "9e04f9bb-d4fa-4d92-93e7-e27b01bf3cfd"

in PowerShell:

`az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/9e04f9bb-d4fa-4d92-93e7-e27b01bf3cfd"`
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "0cefecbe-da96-43e6-bb68-a685472aa20a",
  "displayName": "azure-cli-2024-03-01-23-22-00",
  "password": "Fcf8Q~pzDagXc0S5A9i7mxcI~TatqnbsESdmacxt",
  "tenant": "85cee771-5508-4a67-b739-2e3a849e55fa"
}

# Set the environment variables using Service Principal output values
$Env:ARM_CLIENT_ID = "0cefecbe-da96-43e6-bb68-a685472aa20a"
$Env:ARM_CLIENT_SECRET = "Fcf8Q~pzDagXc0S5A9i7mxcI~TatqnbsESdmacxt"
$Env:ARM_SUBSCRIPTION_ID = "9e04f9bb-d4fa-4d92-93e7-e27b01bf3cfd"
$Env:ARM_TENANT_ID = "85cee771-5508-4a67-b739-2e3a849e55fa"

solaris azure powershell token: nBmAzfvYsHK0MA.atlasv1.vNl3qV9laXWMyLBx9ihkEHoA9HNq8gKXCRh2iGjirXiq4vz38KSFB1o1qrXayAAbEKc