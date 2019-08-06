# buildExecute

## Description

This step serves as generic entry point in pipelines for building artifacts.

You can use pre-defined `buildTool`s.

Alternatively you can define a command via `dockerCommand` which should be executed in `dockerImage`.<br />
This allows you to trigger any build tool using a defined Docker container which provides the required build infrastructure.

When using `buildTool: docker` or `buildTool: kaniko` the created container image is uploaded to a container registry.<br />
You need to make sure that the required credentials are provided to the step.

For all other `buildTool`s the artifact will just be stored in the workspace and could then be `stash`ed for later use.

## Prerequsites

When performing a Docker build you need to maintain the respective credentials in your Jenkins credentials store.<br />
Further details

* for builds when a Docker deamon: see step [containerPushToRegistry](containerPushToRegistry.md)
* for builds using Kaniko: see step [kanikoExecute](kanikoExecute.md)

## Example

```groovy
buildExecute script:this, buildTool: 'maven'
```

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `buildTool` | no |  | `docker`, `kaniko`, `maven`, `mta`, `npm` |
| `containerBuildOptions` | no |  |  |
| `dockerCommand` | no |  |  |
| `dockerImage` | no |  |  |
| `dockerImageName` | yes |  |  |
| `dockerImageTag` | yes |  |  |
| `dockerRegistryUrl` | no |  |  |
| `script` | yes |  |  |

* `buildTool` - Defines the tool used for the build.
* `containerBuildOptions` - Only for Docker builds on the local deamon: Defines the build options for the build.
* `dockerCommand` - For custom build types: Defines the command to be executed within the `dockerImage` in order to execute the build.
* `dockerImage` - For custom build types: Image to be used for builds in case they should run inside a custom Docker container
* `dockerImageName` - For Docker builds only (mandatory): name of the image to be built.
* `dockerImageTag` - For Docker builds only (mandatory): tag of the image to be built.
* `dockerRegistryUrl` - For Docker builds only: Defines the registry url where the image should be pushed to, incl. the protocol like `https://my.registry.com`. If it is not defined, image will not be pushed to a registry.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `buildTool` | X | X |
| `containerBuildOptions` |  | X |
| `dockerCommand` |  | X |
| `dockerImage` |  | X |
| `dockerImageName` | X | X |
| `dockerImageTag` |  | X |
| `dockerRegistryUrl` | X | X |
| `script` |  |  |

## Dependencies

The step depends on the following Jenkins plugins

* [credentials-binding](https://plugins.jenkins.io/credentials-binding)
* [docker](https://plugins.jenkins.io/docker)
* [http_request](https://plugins.jenkins.io/http_request)
* [kubernetes](https://plugins.jenkins.io/kubernetes)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)
* [workflow-durable-task-step](https://plugins.jenkins.io/workflow-durable-task-step)

The kubernetes plugin is only used if running in a kubernetes environment.
Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.

