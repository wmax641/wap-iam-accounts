# WAP IAM Role module

## Usage

| Module Input | Required | Description |
|---|---|---|
| name | **Y** | Name of the role |
| path | N | Path of the role. Defaults to `/wap/` |
| assume_role_policy | **Y** | JSON of role assumption policy |
| managed_policy_arns | N | list of managed policy ARNs to attach |
| inline_policies | N | list of inline JSONs of policies to attach. Each item generates a new inline policy |
| tags | N | By default, module already includes `Name` and `repo` tags. Use this to specify additional tags to include |
