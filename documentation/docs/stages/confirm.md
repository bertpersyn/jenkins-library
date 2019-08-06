# Confirm

In this stage a manual confirmation is requested before processing subsequent stages like __Promote__ and __Release__.

This stage will be active in two scenarios:
- manual activation of this stage
- in case of an 'UNSTABLE' build (even when manual confirmation is inactive)

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
| `manualConfirmation` | no | `true` | `true`, `false` |
| `manualConfirmationMessage` | no | `Shall we proceed to Promote & Release?` |  |
| `manualConfirmationTimeout` | no | `720` |  |
| `script` | yes |  |  |

* `manualConfirmation` - Specifies if a manual confirmation is active before running the __Promote__ and __Release__ stages of the pipeline.
* `manualConfirmationMessage` - Defines message displayed as default manual confirmation. Please note: only used in case pipeline is in state __SUCCESSFUL__
* `manualConfirmationTimeout` - Defines how many hours a manual confirmation is possible for a dedicated pipeline.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Configuration of Additional Stage Parameters

The stage parameters need to be defined in the section `stages` of [config.yml file](../configuration.md).
