# Build

In this stage a build is executed which typically also executes tests and code checks.

They type of build is defined using the configuration `buildTool`, see also step [buildExecute](../steps/buildExecute.md)

## Stage Content

This stage comprises following steps which are activated depending on your use-case/configuration:

| step | step description |
| ---- | ---------------- |
| [buildExecute](../steps/buildExecute.md) | Starts build execution. This is always being executed. |
| [checksPublishResults](../steps/checksPublishResults.md) | Publishes check results to Jenkins. It will always be active. |
| [pipelineStashFilesAfterBuild](../steps/pipelineStashFilesAfterBuild.md) | Executes stashing of files after build execution.<br / Build results are stashed with stash name `buildResult`.  **Note: Please make sure that your build artifacts are contained here since this stash is the foundation for subsequent tests and checks, e.g. deployment to a test landscape.** |
| [testsPublishResults](../steps/testsPublishResults.md) | Publishes test results to Jenkins. It will always be active. |


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
