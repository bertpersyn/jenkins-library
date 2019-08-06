# Acceptance

In this stage the application/service is typically deployed and automated acceptance tests are executed.<br />
This is to make sure that

* new functionality is tested end-to-end
* there is no end-to-end regression in existing functionality

## Stage Content

This stage comprises following steps which are activated depending on your use-case/configuration:

| step | step description |
| ---- | ---------------- |
| [cloudFoundryDeploy](../steps/cloudFoundryDeploy.md) | For Cloud Foundry use-cases: Performs deployment to Cloud Foundry space/org. |
| [gaugeExecuteTests](../steps/gaugeExecuteTests.md) | Performs behavior-driven tests using Gauge test framework against the deployed application/service. |
| [healthExecuteCheck](../steps/healthExecuteCheck.md) | Performs health check in order to prove one aspect of operational readiness. In order to be able to respond to health checks from infrastructure components (like load balancers) it is important to provide one unprotected application endpoint which allows a judgement about the health of your application. |
| [neoDeploy](../steps/neoDeploy.md) | For Neo use-cases: Performs deployment to Neo landscape. |
| [newmanExecute](../steps/newmanExecute.md) | Performs API testing using Newman against the deployed application/service. |
| [testsPublishResults](../steps/testsPublishResults.md) | Publishes test results to Jenkins. It will automatically be active in cases tests are executed. |
| [uiVeri5ExecuteTests](../steps/uiVeri5ExecuteTests.md) | Performs end-to-end UI testing using UIVeri5 test framework against the deployed application/service. |


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
