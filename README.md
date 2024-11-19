# wap-iam-accounts
wap-iam-accounts

Creates supported WAP IAM resources. 

Github Actions assumes the `IAMSeedRole` in target dev/prd accounts to create the IAM resources, and only this repository is whitelisted to assume the role.

Use the module `/modules/wap-role/` and examples in `role_dummy.tf.example`
