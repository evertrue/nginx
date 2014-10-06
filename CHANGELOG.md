et_nginx Cookbook CHANGELOG
========================
This file is used to list changes made in each version of the et_nginx cookbook.

v2.0.6 (2014-10-06)
-------------------
-- Add actual Serverspec tests
-- Clean up Gemfile
-- Add additional guard to removal of `/var/log/nginx` to avoid failures due to `et_rails_app::default` installing a symlink at that path

v2.0.5 (2014-10-01)
-------------------
-- Call up previously defined service resource to avoid cloning
-- Switch to release version of berkshelf
-- Remove /var/log/nginx directory during install
-- Notify existing apt-get update resource instead of defining a new one
-- Notify existing nginx start resource instead of defining a duplicate resource
-- s/nginx/et_nginx/g in test kitchen run lists
-- Add ServerSpec test suites

v2.0.4 (2014-08-11)
-------------------
-- Fix issue with path for root location for socketproxy config

v2.0.3 (2014-08-04)
-------------------
-- Fix socketproxy nginx config assets location

v2.0.2 (2014-06-30)
-------------------
-- Merge in [upstream v2.7.4](https://github.com/miketheman/nginx/releases/tag/v2.7.4)
-- Merge in RuboCop fixes

v2.0.1 (2014-05-29)
-------------------
-- [COOK-4688] - Make log level configurable through attributes (and stop debug logging)

v2.0.0 (2014-05-19)
-------------------
-- Improve the handling of unspecified configuration options in socketproxy apps
-- Start using our own changelog
