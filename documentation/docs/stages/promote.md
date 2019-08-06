# Promote

This stage is responsible to promote build artifacts to an artifact repository / container registry where they can be used from in production deployments.<br />

## Stage Content

This stage comprises following steps which are activated depending on your use-case/configuration:

| step | step description |
| ---- | ---------------- |
| [containerPushToRegistry](../steps/containerPushToRegistry.md) | For Docker builds: pushes the Docker image to a container registry. |


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
