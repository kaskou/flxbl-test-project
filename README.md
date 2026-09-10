# flxbl-test-project

A sample Salesforce DX project structured as a flxbl-style mono-repo, built to
try out the [flxbl.io](https://www.flxbl.io/) / coDev platform tooling
(build, package, deploy, dependency management across packages).

## Package structure

| Package            | Path                | Purpose                                                        |
|---------------------|---------------------|-----------------------------------------------------------------|
| `core-crm`          | `core-crm/`         | Shared data model — the `Project__c` custom object              |
| `frameworks`        | `frameworks/`       | Shared utilities — trigger handler base class, logging service  |
| `sales`             | `sales/`            | Domain business logic — `ProjectService` (depends on the above) |
| `src-access-mgmt`   | `src-access-mgmt/`  | Permission sets granting access to the above                    |
| `src-env-specific`  | `src-env-specific/` | Placeholder for per-environment metadata (named credentials, etc.) |
| `src-temp`          | `src-temp/`         | Default landing folder for new/unclassified metadata            |

Dependencies flow: `core-crm` → `frameworks` → `sales` → `src-access-mgmt`,
as declared in `sfdx-project.json`. This lets you exercise flxbl/sfp's
dependency resolution and build-order features rather than testing against
a single flat `force-app` directory.

## What's included

- **Custom object**: `Project__c` with `Status__c` (picklist), `Description__c`
  (long text), and `Budget__c` (currency) fields, plus an `All` list view.
- **Apex classes**:
  - `TriggerHandler` — a minimal trigger-handler-pattern base class (frameworks)
  - `LoggerService` — a small logging utility (frameworks)
  - `ProjectService` — business logic on `Project__c`, depends on `LoggerService` (sales)
- **Test classes** for all Apex classes above (`LoggerServiceTest`,
  `ProjectServiceTest`), so builds that require code coverage will pass.
- **Permission set**: `Flxbl_Test_Project_Access`, granting CRUD + field access
  on `Project__c` and access to the two Apex classes.
- **Scratch org definition**: `config/project-scratch-def.json`.

## Getting started locally (once you have the Salesforce CLI)

```bash
# Authenticate to your Dev Hub
sf org login web --alias mydevhub --set-default-dev-hub

# Create a scratch org for manual testing
sf org create scratch --definition-file config/project-scratch-def.json --alias flxbl-test --set-default

# Push all source to the scratch org
sf project deploy start --source-dir core-crm --source-dir frameworks --source-dir sales --source-dir src-access-mgmt

# Assign the permission set to yourself
sf org assign permset --name Flxbl_Test_Project_Access

# Run the Apex tests
sf apex run test --code-coverage --result-format human
```

## Using with coDev

Once this repo is pushed to GitHub, register it as a project in coDev along
with your Dev Hub and target org(s), then use coDev to build artifacts from
each package directory and deploy them in dependency order.
