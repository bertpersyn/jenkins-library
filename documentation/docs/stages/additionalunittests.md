# Additional Unit Tests

In this stage unit tests, which can not or should not be executed in the central build environment, are executed.<br />
These are for example Karma(OPA5 & QUnit) tests.

## Stage Content

This stage comprises following steps which are activated depending on your use-case/configuration:

| step | step description |
| ---- | ---------------- |
| [batsExecuteTests](../steps/batsExecuteTests.md) | Executes bats tests which are for example suitable for testing Docker images via a shell. |
| [karmaExecuteTests](../steps/karmaExecuteTests.md) | Executes karma tests which are for example suitable for OPA5 testing as well as QUnit testing of SAP UI5 apps. |
| [testsPublishResults](../steps/testsPublishResults.md) | Publishes test results to Jenkins. It will automatically be active in cases tests are executed. |


## Stage Activation

This stage will be active if any one of the following conditions is met:

* Stage configuration in [config.yml file](../configuration.md) contains entries for this stage.
* Any of the conditions are met which are explained in the section [Step Activation](#step-activation).

## Step Activation

For this stage no conditions are assigned to steps.

## Additional Stage Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `script` | yes |  |  |

* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Configuration of Additional Stage Parameters

The stage parameters need to be defined in the section `stages` of [config.yml file](../configuration.md).
