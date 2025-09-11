This initialize and test the complete upgrade path from Terraform 0.12
to OpenTofu for aws-vpc module.
Requires that moto_server is running and listening to localhost:5000.

Copy the entire module to a temporary directory so we do not need to
worry and clean .terraform and terraform.tfstate files:

  $ cp -r "${TESTDIR}/aws-vpc" "${CRAMTMP}/aws-vpc"
  $ cd "${CRAMTMP}/aws-vpc"

Set CHECKPOINT_DISABLE environment variable so Terraform do not phone
home:

  $ export CHECKPOINT_DISABLE=yes


Initialize the project with Terraform 0.12.x and create the resources:

  $ terraform012 init >/dev/null
  $ terraform012 plan -detailed-exitcode >/dev/null
  [2]
  $ terraform012 apply -auto-approve >/dev/null


Upgrade to Terraform 0.13.x by following
<https://developer.hashicorp.com/terraform/language/v1.1.x/upgrade-guides/0-13>...

We ensure that there are no pending changes to do:

  $ terraform012 plan -detailed-exitcode >/dev/null

Run 0.13upgrade command so that provider requirements are rewritten to have
explicit source locations:

  $ terraform013 0.13upgrade -yes >/dev/null

Rewrite providers in the state too and re-init:

  $ terraform013 state replace-provider -auto-approve -- -/aws registry.terraform.io/hashicorp/aws >/dev/null
  $ terraform013 state replace-provider -auto-approve -- -/random registry.terraform.io/hashicorp/random >/dev/null
  $ terraform013 init >/dev/null

Run apply to complete the upgrade

  $ terraform013 apply -auto-approve >/dev/null


Upgrade to Terraform 0.14.x by following
<https://developer.hashicorp.com/terraform/language/v1.1.x/upgrade-guides/0-14>...

We ensure that there are no pending changes to do:

  $ terraform013 plan -detailed-exitcode >/dev/null

Rewrite providers in the state too and re-init:

  $ terraform014 init >/dev/null

Run apply to complete the upgrade

  $ terraform014 apply -auto-approve >/dev/null


Upgrade to Terraform 1.5 by following
<https://developer.hashicorp.com/terraform/language/v1.5/upgrade-guides/>...

We ensure that there are no pending changes to do:

  $ terraform014 plan -detailed-exitcode >/dev/null

Rewrite providers in the state too and re-init:

  $ terraform15 init >/dev/null

Run apply to complete the upgrade

  $ terraform15 apply -auto-approve >/dev/null


Upgrade to OpenTofu by following
<https://opentofu.org/docs/intro/migration/migration-guide/>...

We ensure that there are no pending changes to do:

  $ terraform15 plan -detailed-exitcode >/dev/null

Re-init:

  $ tofu init >/dev/null

Run apply to complete the upgrade:

  $ tofu apply -auto-approve >/dev/null
