# Init

This stage initializes the pipeline run and prepares further execution.

It will check out your repository and perform some steps to initialize your pipeline run.

## Stage Content

This stage comprises following steps which are activated depending on your use-case/configuration:

| step | step description |
| ---- | ---------------- |


## Stage Activation

This stage will be active if any one of the following conditions is met:

* Stage configuration in [config.yml file](../configuration.md) contains entries for this stage.
* Any of the conditions are met which are explained in the section [Step Activation](#step-activation).

## Step Activation

For this stage no conditions are assigned to steps.

## Additional Stage Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `buildTool` | yes |  | `docker`, `kaniko`, `maven`, `mta, ``npm` |
| `productiveBranch` | no | `master` |  |
| `script` | yes |  |  |
| `stashSettings` | no |  |  |
| `verbose` | no |  | `true`, `false` |

* `buildTool` - Defines the build tool used.
* `productiveBranch` - Defines the main branch for your pipeline. **Typically this is the `master` branch, which does not need to be set explicitly.** Only change this in exceptional cases
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `stashSettings` - Defines the library resource containing the stash settings to be performed before and after each stage. **Caution: changing the default will break the standard behavior of the pipeline - thus only relevant when including `Init` stage into custom pipelines!**
* `verbose` - Whether verbose output should be produced.

## Configuration of Additional Stage Parameters

The stage parameters need to be defined in the section `stages` of [config.yml file](../configuration.md).
