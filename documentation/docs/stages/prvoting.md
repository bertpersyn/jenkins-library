# Pull-Request Voting

This stage is executed for every pull-request.<br />
For non-Docker builds it will execute the respective build (including unit tests, static checks, ...).

!!! note "Build Tool not in the list?"

    For build tools which are currently not in the list a custom `dockerImage` can be used with a custom `dockerCommand` as per step [buildExecute](../steps/buildExecute.md)

For `buildTool: docker` a local Docker build will be executed in case a Docker deamon is available, if not `buildTool: 'kaniko'` will be used instead.

## Advanced Pull-Request Voting

It is possible to trigger dedicated tests/checks

* pull request comments
* pull request labels

Following steps are currently supported

| step name | comment | pull-request label |
| --------- | ------- | ------------------ |
| karmaExecuteTests | `/piper karma` | `pr_karma`
| whitesourceExecuteScan | `/piper whitesource` | `pr_whitesource`

## Stage Content

This stage comprises following steps which are activated depending on your use-case/configuration:

| step | step description |
| ---- | ---------------- |
| [buildExecute](../steps/buildExecute.md) | Triggers the build execution. |
| [checksPublishResults](../steps/checksPublishResults.md) | Publishes check results to Jenkins. It will always be active. |
| [karmaExecuteTests](../steps/karmaExecuteTests.md) | Executes karma tests. For example suitable for OPA5 testing as well as QUnit testing of SAP UI5 apps.<br /> This step is not active by default. It can be activated by:  * using pull request comments or pull request lables (see [Advanced Pull-Request Voting](#advanced-pull-request-voting). * explicit activation via stage configuration. |
| [testsPublishResults](../steps/testsPublishResults.md) | Publishes test results to Jenkins. It will always be active. |
| [whitesourceExecuteScan](../steps/whitesourceExecuteScan.md) | Executes a WhiteSource scan This step is not active by default. It can be activated by:  * using pull request comments or pull request lables (see [Advanced Pull-Request Voting](#advanced-pull-request-voting). * explicit activation via stage configuration. |


## Stage Activation

This stage will be active if any one of the following conditions is met:

* Stage configuration in [config.yml file](../configuration.md) contains entries for this stage.
* Any of the conditions are met which are explained in the section [Step Activation](#step-activation).

## Step Activation

For this stage no conditions are assigned to steps.

## Additional Stage Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `buildTool` | no |  | `docker`, `kaniko`, `maven`, `mta`, `npm` |
| `script` | yes |  |  |

* `buildTool` - Defines the build tool used.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Configuration of Additional Stage Parameters

The stage parameters need to be defined in the section `stages` of [config.yml file](../configuration.md).
