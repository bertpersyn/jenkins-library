# containerPushToRegistry

## Description

This step allows you to push a Docker image into a dedicated Container registry.

By default an image available via the local Docker daemon will be pushed.

In case you want to pull an existing image from a remote container registry, a source image and source registry needs to be specified.<br />
This makes it possible to move an image from one registry to another.

## Prerequisites

You need to have a valid user with write permissions in the target docker registry.

Credentials for the target docker registry have been configured in Jenkins with a dedicated Id.

You can create the credentials in your Jenkins<br />
via _Jenkins_ -> _Credentials_ -> _System_ -> _Global credentials (unrestricted)_ -> _Add Credentials_ ->

* Kind: _Username with Password_
* ID: specify id which you then use for the configuration of `dockerCredentialsId` (see below)

## Example

Usage of pipeline step:

**OPTION A:** To pull a Docker image from an existing docker registry and push to a different docker registry:

```groovy
containerPushToRegistry script: this,
                        dockerCredentialsId: 'myTargetRegistryCredentials',
                        sourceRegistryUrl: 'https://mysourceRegistry.url',
                        sourceImage: 'path/to/mySourceImageWith:tag',
                        dockerRegistryUrl: 'https://my.target.docker.registry:50000'
```

**OPTION B:** To push a locally build docker image into the target registry (only possible when a Docker deamon is available on your Jenkins node):

```groovy
containerPushToRegistry script: this,
                        dockerCredentialsId: 'myTargetRegistryCredentials',
                        dockerImage: 'path/to/myImageWith:tag',
                        dockerRegistryUrl: 'https://my.target.docker.registry:50000'
```

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `dockerArchive` | no |  |  |
| `dockerBuildImage` | no |  |  |
| `dockerCredentialsId` | yes |  |  |
| `dockerImage` | no |  |  |
| `dockerRegistryUrl` | yes |  |  |
| `script` | yes |  |  |
| `skopeoImage` | no |  |  |
| `sourceImage` | no |  |  |
| `sourceRegistryUrl` | no |  |  |
| `tagLatest` | no |  |  |

* `dockerArchive` - Not supported yet - Docker archive to be pushed to registry
* `dockerBuildImage` - For images built locally on the Docker Deamon, reference to the image object resulting from `docker.build` execution
* `dockerCredentialsId` - Defines the id of the Jenkins username/password credentials containing the credentials for the target Docker registry.
* `dockerImage` - Defines the name (incl. tag) of the target image
* `dockerRegistryUrl` - Defines the registry url where the image should be pushed to, incl. the protocol like `https://my.registry.com`
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `skopeoImage` - Only if no Docker daemon available on your Jenkins image: Docker image to be used for [Skopeo](https://github.com/containers/skopeo) calls Unfortunately no proper image known to be available. Simple custom Dockerfile could look as follows: <br> ``` FROM fedora:29 RUN dnf install -y skopeo ```
* `sourceImage` - Defines the name (incl. tag) of the source image to be pushed to a new image defined in `dockerImage`.<br> This is helpful for moving images from one location to another.
* `sourceRegistryUrl` - Defines a registry url from where the image should optionally be pulled from, incl. the protocol like `https://my.registry.com`
* `tagLatest` - Defines if the image should be tagged as `latest`

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `dockerArchive` |  | X |
| `dockerBuildImage` |  | X |
| `dockerCredentialsId` | X | X |
| `dockerImage` |  | X |
| `dockerRegistryUrl` | X | X |
| `script` |  |  |
| `skopeoImage` |  | X |
| `sourceImage` |  | X |
| `sourceRegistryUrl` |  | X |
| `tagLatest` |  | X |

## Dependencies

The step depends on the following Jenkins plugins

* [credentials-binding](https://plugins.jenkins.io/credentials-binding)
* [docker](https://plugins.jenkins.io/docker)
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

