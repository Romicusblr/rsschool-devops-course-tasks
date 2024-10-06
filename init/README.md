# RSSchool DevOps Course Tasks

This folder contains essential resources that should be preserved throughout the entire course. Below is a description of these resources and the commands available in the Makefile.

## Resources

- **aws_iam_openid_connect_provider**: Creates an OIDC provider for GitHub Actions.
- **aws_iam_role**: Creates an IAM role (GithubActionsRole) for GitHub Actions with an assume role policy.
- **aws_s3_bucket**: Creates an S3 bucket.
**aws_s3_bucket_server_side_encryption_con- figuration**: Configures server-side encryption for the S3 bucket.
- **aws_s3_bucket_versioning**: Enables versioning for the S3 bucket.

## Makefile Commands

- **init**: Initializes Terraform configuration.
- **plan**: Previews changes without applying them.
- **apply**: Applies the changes to reach the desired state.
- **destroy**: Destroys the managed infrastructure.
