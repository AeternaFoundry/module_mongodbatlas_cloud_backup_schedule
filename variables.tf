variable "cloud_backup_schedules" {
  description = <<EOT
Map of cloud_backup_schedules, attributes below
Required:
    - cluster_name
    - project_id
Optional:
    - auto_export_enabled
    - copy_policy_items_enabled
    - delete_copy_snapshots
    - reference_hour_of_day
    - reference_minute_of_hour
    - restore_window_days
    - skip_destroy
    - update_copy_snapshots
    - update_snapshots
    - use_org_and_group_names_in_export_prefix
    - copy_settings (block):
        - cloud_provider (optional)
        - copy_policy_items (optional, block):
            - frequency_type (required)
            - retention_unit (optional)
            - retention_value (optional)
        - frequencies (optional)
        - last_number_of_snapshots (optional)
        - region_name (optional)
        - should_copy_oplogs (optional)
        - zone_id (optional)
    - export (block):
        - export_bucket_id (optional)
        - frequency_type (optional)
    - policy_item_daily (block):
        - frequency_interval (required)
        - retention_unit (required)
        - retention_value (required)
    - policy_item_hourly (block):
        - frequency_interval (required)
        - retention_unit (required)
        - retention_value (required)
    - policy_item_monthly (block):
        - frequency_interval (required)
        - retention_unit (required)
        - retention_value (required)
    - policy_item_weekly (block):
        - frequency_interval (required)
        - retention_unit (required)
        - retention_value (required)
    - policy_item_yearly (block):
        - frequency_interval (required)
        - retention_unit (required)
        - retention_value (required)
EOT

  type = map(object({
    cluster_name                             = string
    project_id                               = string
    auto_export_enabled                      = optional(bool)
    copy_policy_items_enabled                = optional(bool)
    delete_copy_snapshots                    = optional(bool)
    reference_hour_of_day                    = optional(number)
    reference_minute_of_hour                 = optional(number)
    restore_window_days                      = optional(number)
    skip_destroy                             = optional(bool)
    update_copy_snapshots                    = optional(bool)
    update_snapshots                         = optional(bool)
    use_org_and_group_names_in_export_prefix = optional(bool)
    copy_settings = optional(list(object({
      cloud_provider = optional(string)
      copy_policy_items = optional(list(object({
        frequency_type  = string
        retention_unit  = optional(string)
        retention_value = optional(number)
      })))
      frequencies              = optional(set(string))
      last_number_of_snapshots = optional(number)
      region_name              = optional(string)
      should_copy_oplogs       = optional(bool)
      zone_id                  = optional(string)
    })))
    export = optional(object({
      export_bucket_id = optional(string)
      frequency_type   = optional(string)
    }))
    policy_item_daily = optional(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    }))
    policy_item_hourly = optional(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    }))
    policy_item_monthly = optional(list(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    })))
    policy_item_weekly = optional(list(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    })))
    policy_item_yearly = optional(list(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    })))
  }))
}

