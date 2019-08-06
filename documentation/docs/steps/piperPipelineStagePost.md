# piperPipelineStagePost

## Description

In this stage reporting actions like mail notification or telemetry reporting are executed.

This stage contains following steps:
- [influxWriteData](./influxWriteData.md)
- [mailSendNotification](./mailSendNotification.md)

!!! note
    This stage is meant to be used in a [post](https://jenkins.io/doc/book/pipeline/syntax/#post) section of a pipeline.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `script` | yes |  |  |

* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `script` |  |  |

## Dependencies

The step depends on the following Jenkins plugins

* [email-ext](https://plugins.jenkins.io/email-ext)
* [lockable-resources](https://plugins.jenkins.io/lockable-resources)
* [pipeline-milestone-step](https://plugins.jenkins.io/pipeline-milestone-step)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [ssh-agent](https://plugins.jenkins.io/ssh-agent)
* [warnings-ng](https://plugins.jenkins.io/warnings-ng)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps](https://plugins.jenkins.io/workflow-cps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)
* [workflow-durable-task-step](https://plugins.jenkins.io/workflow-durable-task-step)

Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.

