nginx Cookbook CHANGELOG
========================
This file is used to list changes made in each version of the nginx cookbook.


v2.7.2 (2014-05-27)
-------------------

- [COOK-4658] - Nginx::socketproxy if the context is blank or nonexistant, the location in the config file has a double slash at the beginning
- [COOK-4644] - add support to nginx::repo for Amazon Linux
- Allow .kitchen.cloud.yml to use an environment variable for the EC2 Availability Zone


v2.7.0 (2014-05-15)
-------------------
- Improve the handling of unspecified configuration options in socketproxy apps
- Start using our own changelog
