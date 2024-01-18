# WAP IAM Role module

Use to generate roles in a compliant manner

## Usage

| Module Input | Required | Type | Description |
|---|---|---|---|
| name | **Y** | string | Name of the role |
| path | N | string | Path of the role. Defaults to `/wap/` |
| assume_role_policy | N | string | JSON of role custom assumption policy for service roles. Ignored if `create_deploy_role` flag variable is set to `true` . <br/>Typically use `data.aws_iam_policy_document.<name>.json` to generate the string |
| managed_policy_arns | N | list(string) | list of managed policy ARNs to attach |
| inline_policies | N | list(string) | list of inline JSONs of policies to attach. Each item generates a new inline policy <br/>Typically use `data.aws_iam_policy_document.<name>.json` to generate the string |
| create_deploy_role  | N | bool | Flag to create a deploy role instead of a service role. A deploy role will allow assumption from Github Actions. <br/>Defaults to `false` |
| used_by_repo | **Y** | string | Denotes the repo that uses this role. Gets added to `tags["used_by_repo"]`. <br/>If used for a deploy role (`create_deploy_role=true`), sets trust principal for the deploy role |
| tags | N | map(string:string) | By default, module already includes `Name`, `repo` and `used_by_repo` tags. Use this to specify additional tags to include |

