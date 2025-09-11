This test Terraform upgrades in pkgsrc and goes from Terraform 0.12 to
latest supported OpenTofu.

First we check that we have all needed Terraform versions...

We set CHECKPOINT_DISABLE variable because otherwise Terraform phone
home and check if there are new versions available via
hashicorp/go-checkpoint:

  $ export CHECKPOINT_DISABLE=yes

We check all Terraform versions:

  $ terraform012 version
  Terraform v0.12.* (glob)
  $ terraform013 version
  Terraform v0.13.* (glob)
  $ terraform014 version
  Terraform v0.14.* (glob)
  $ terraform15 version
  Terraform v1.5.* (glob)
  on * (glob)

In pkgsrc-wip we have also packaged other intermediate versions.
Maybe we should test them too.

We also check that we have OpenTofu installed:

  $ tofu version
  OpenTofu v1.* (glob)
  on * (glob)
