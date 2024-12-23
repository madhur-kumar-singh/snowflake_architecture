# To initiate the terraform and install required plugin's for snowflake
terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
    }
  }
}

# A simple configuration of the provider with a default authentication.
provider "snowflake" {
  organization_name = "TYLUEXV"
  account_name      = "EFB27323"
  user              = "madhursingh"
  password          = "7088758000%Ma"
  role              = "terraform_user"
}

# Creating role for the snowflake to create the high level objects
resource "snowflake_account_role" "developer" {
  name = "DEVELOPER"
}

# Assigning securityadmin to DEVELOPER
resource "snowflake_grant_account_role" "g" {
  role_name        = snowflake_account_role.developer.name
  parent_role_name = "SECURITYADMIN"
}

# Assigning role to user
resource "snowflake_grant_account_role" "user" {
  role_name = snowflake_account_role.developer.name
  user_name = "MADHURSINGH"
}

# Creating warehouse for the snowflake for creating objects
resource "snowflake_warehouse" "warehouse" {
  name              = "DEV_WH"
  warehouse_type    = "STANDARD"
  warehouse_size    = "X-SMALL"
  max_cluster_count = 1
  min_cluster_count = 1
  scaling_policy    = "ECONOMY"
  auto_suspend      = 1200
  auto_resume       = true
}

# Creating Database for architecture
resource "snowflake_database" "primary" {
  name = "ELT_ENGINE"
}

# Creating schema for architecture tables
resource "snowflake_schema" "schema" {
  name     = "CONTROL"
  database = snowflake_database.primary.name
}

# granting operate permission to developer role on warehouse
resource "snowflake_grant_privileges_to_account_role" "permission_warehouse" {
  privileges        = ["OPERATE"]
  account_role_name = snowflake_account_role.developer.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.warehouse.name
  }
}

# granting all permission to developer role on database
resource "snowflake_grant_privileges_to_account_role" "permission_database" {
  all_privileges    = true
  with_grant_option = true
  account_role_name = snowflake_account_role.developer.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.primary.name
  }
}

# granting future permission to developer role on schema
resource "snowflake_grant_privileges_to_account_role" "permission_future_schemas" {
  all_privileges = true
  account_role_name = snowflake_account_role.developer.name
  on_schema {
    future_schemas_in_database = snowflake_database.primary.name
  }
}

# granting current permission to developer role on schema
resource "snowflake_grant_privileges_to_account_role" "permission_current_schemas" {
  all_privileges = true
  account_role_name = snowflake_account_role.developer.name
  on_schema {
    all_schemas_in_database = snowflake_database.primary.name
  }
}