resource "mongodbatlas_cloud_backup_schedule" "cloud_backup_schedules" {
  for_each = var.cloud_backup_schedules

  cluster_name                             = each.value.cluster_name
  project_id                               = each.value.project_id
  auto_export_enabled                      = each.value.auto_export_enabled
  copy_policy_items_enabled                = each.value.copy_policy_items_enabled
  delete_copy_snapshots                    = each.value.delete_copy_snapshots
  reference_hour_of_day                    = each.value.reference_hour_of_day
  reference_minute_of_hour                 = each.value.reference_minute_of_hour
  restore_window_days                      = each.value.restore_window_days
  skip_destroy                             = each.value.skip_destroy
  update_copy_snapshots                    = each.value.update_copy_snapshots
  update_snapshots                         = each.value.update_snapshots
  use_org_and_group_names_in_export_prefix = each.value.use_org_and_group_names_in_export_prefix

  dynamic "copy_settings" {
    for_each = each.value.copy_settings != null ? each.value.copy_settings : []
    content {
      cloud_provider = copy_settings.value.cloud_provider
      dynamic "copy_policy_items" {
        for_each = copy_settings.value.copy_policy_items != null ? copy_settings.value.copy_policy_items : []
        content {
          frequency_type  = copy_policy_items.value.frequency_type
          retention_unit  = copy_policy_items.value.retention_unit
          retention_value = copy_policy_items.value.retention_value
        }
      }
      frequencies              = copy_settings.value.frequencies
      last_number_of_snapshots = copy_settings.value.last_number_of_snapshots
      region_name              = copy_settings.value.region_name
      should_copy_oplogs       = copy_settings.value.should_copy_oplogs
      zone_id                  = copy_settings.value.zone_id
    }
  }

  dynamic "export" {
    for_each = each.value.export != null ? [each.value.export] : []
    content {
      export_bucket_id = export.value.export_bucket_id
      frequency_type   = export.value.frequency_type
    }
  }

  dynamic "policy_item_daily" {
    for_each = each.value.policy_item_daily != null ? [each.value.policy_item_daily] : []
    content {
      frequency_interval = policy_item_daily.value.frequency_interval
      retention_unit     = policy_item_daily.value.retention_unit
      retention_value    = policy_item_daily.value.retention_value
    }
  }

  dynamic "policy_item_hourly" {
    for_each = each.value.policy_item_hourly != null ? [each.value.policy_item_hourly] : []
    content {
      frequency_interval = policy_item_hourly.value.frequency_interval
      retention_unit     = policy_item_hourly.value.retention_unit
      retention_value    = policy_item_hourly.value.retention_value
    }
  }

  dynamic "policy_item_monthly" {
    for_each = each.value.policy_item_monthly != null ? each.value.policy_item_monthly : []
    content {
      frequency_interval = policy_item_monthly.value.frequency_interval
      retention_unit     = policy_item_monthly.value.retention_unit
      retention_value    = policy_item_monthly.value.retention_value
    }
  }

  dynamic "policy_item_weekly" {
    for_each = each.value.policy_item_weekly != null ? each.value.policy_item_weekly : []
    content {
      frequency_interval = policy_item_weekly.value.frequency_interval
      retention_unit     = policy_item_weekly.value.retention_unit
      retention_value    = policy_item_weekly.value.retention_value
    }
  }

  dynamic "policy_item_yearly" {
    for_each = each.value.policy_item_yearly != null ? each.value.policy_item_yearly : []
    content {
      frequency_interval = policy_item_yearly.value.frequency_interval
      retention_unit     = policy_item_yearly.value.retention_unit
      retention_value    = policy_item_yearly.value.retention_value
    }
  }
}

