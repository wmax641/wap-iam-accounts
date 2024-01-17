# WAP IAM Role module

Use to generate roles in a compliant manner

## Usage

| Module Input | Required | Type | Description |
|---|---|---|---|
| name | **Y** | string | Name of the role |
| path | N | string | Path of the role. Defaults to `/wap/` |
| assume_role_policy | **Y** | string | JSON of role assumption policy. <br/>Typically use `data.aws_iam_policy_document.<name>.json` to generate the string |
| managed_policy_arns | N | list(string) | list of managed policy ARNs to attach |
| inline_policies | N | list(string) | list of inline JSONs of policies to attach. Each item generates a new inline policy <br/>Typically use `data.aws_iam_policy_document.<name>.json` to generate the string |
| tags | N | dict | By default, module already includes `Name` and `repo` tags. Use this to specify additional tags to include |

