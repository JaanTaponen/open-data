
provider "azurerm" {
}

module "defaults" {
    source = "../defaults"
}

module "secrets" {
    source = "../secrets"
}

resource "azurerm_resource_group" "scilResourceGroup" {
        name = "${module.defaults.resource_group}"
        location = "${module.defaults.location}"
}

resource "azurerm_storage_account" "scilStorageAccount" {
  name                     = "scilstorageaccount"
  resource_group_name      = "${module.defaults.resource_group}"
  location                 = "${module.defaults.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "incomeContainer" {
  name                  = "income"
  resource_group_name   = "${module.defaults.resource_group}"
  storage_account_name  = "${azurerm_storage_account.scilStorageAccount.name}"
  container_access_type = "private"
}
resource "azurerm_storage_container" "archiveContainer" {
  name                  = "archive"
  resource_group_name   = "${module.defaults.resource_group}"
  storage_account_name  = "${azurerm_storage_account.scilStorageAccount.name}"
  container_access_type = "private"
}

resource "azurerm_sql_server" "scilSqlServer" {
  name                         = "scilsqlserver"
  resource_group_name          = "${module.defaults.resource_group}"
  location                     = "${module.defaults.location}"
  version                      = "12.0"
  administrator_login          = "${module.secrets.sqlServerUsername}"
  administrator_login_password = "${module.secrets.sqlServerPassword}"
}

resource "azurerm_sql_database" "sqlDB" {
  name                = "scilDB"
  resource_group_name = "${module.defaults.resource_group}"
  location            = "${module.defaults.location}"
  server_name         = "${azurerm_sql_server.scilSqlServer.name}"

  tags = {
    environment = "dev"
  }
}