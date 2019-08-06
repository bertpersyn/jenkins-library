# kanikoExecute

## Description

Executes a [Kaniko](https://github.com/GoogleContainerTools/kaniko) build for creating a Docker container.

## Prerequsites

When pushing to a container registry, you need to maintain the respective credentials in your Jenkins credentials store:

Kaniko expects a Docker `config.json` file containing the credential information for registries.
You can create it like explained in the Docker Success Center in the articale about [How to generate a new auth in the config.json file](https://success.docker.com/article/generate-new-auth-in-config-json-file).

Please copy this file and upload it to your Jenkins for example<br />
via _Jenkins_ -> _Credentials_ -> _System_ -> _Global credentials (unrestricted)_ -> _Add Credentials_ ->

* Kind: _Secret file_
* File: upload your `config.json` file
* ID: specify id which you then use for the configuration of `dockerConfigJsonCredentialsId` (see below)

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


## Example

```groovy
kanikoExecute script:this
```

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `containerBuildOptions` | no | `--skip-tls-verify-pull` |  |
| `containerCommand` | no | `/busybox/tail -f /dev/null` |  |
| `containerImageNameAndTag` | no |  |  |
| `containerPreparationCommand` | no | `rm /kaniko/.docker/config.json` |  |
| `containerShell` | no | `/busybox/sh` |  |
| `customTlsCertificateLinks` | no | `[]` |  |
| `dockerConfigJsonCredentialsId` | no |  |  |
| `dockerEnvVars` | no |  |  |
| `dockerImage` | no | `gcr.io/kaniko-project/executor:debug` |  |
| `dockerOptions` | no | `-u 0 --entrypoint=''` |  |
| `dockerfile` | no | `Dockerfile` |  |
| `script` | yes |  |  |

* `containerBuildOptions` - Defines the build options for the [kaniko](https://github.com/GoogleContainerTools/kaniko) build.
* `containerCommand` - Kubernetes only: Allows to specify start command for container created with dockerImage parameter to overwrite Piper default (`/usr/bin/tail -f /dev/null`).
* `containerImageNameAndTag` - Defines the full name of the Docker image to be created including registry, image name and tag like `my.docker.registry/path/myImageName:myTag`.
* `containerPreparationCommand` - Defines the command to prepare the Kaniko container. By default the contained credentials are removed in order to allow anonymous access to container registries.
* `containerShell` - Kubernetes only: Allows to specify the shell to be used for execution of commands.
* `customTlsCertificateLinks` - List containing download links of custom TLS certificates. This is required to ensure trusted connections to registries with custom certificates.
* `dockerConfigJsonCredentialsId` - Defines the id of the file credentials in your Jenkins credentials store which contain the file `.docker/config.json`. You can find more details about the Docker credentials in the [Docker documentation](https://docs.docker.com/engine/reference/commandline/login/).
* `dockerEnvVars` - Environment variables to set in the container, e.g. [http_proxy: 'proxy:8080'].
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used and the command is executed directly on the Jenkins system.
* `dockerOptions` - Docker options to be set when starting the container (List or String).
* `dockerfile` - Defines the location of the Dockerfile relative to the Jenkins workspace.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `containerBuildOptions` |  | X |
| `containerCommand` |  | X |
| `containerImageNameAndTag` |  | X |
| `containerPreparationCommand` |  | X |
| `containerShell` |  | X |
| `customTlsCertificateLinks` |  | X |
| `dockerConfigJsonCredentialsId` |  | X |
| `dockerEnvVars` |  | X |
| `dockerImage` |  | X |
| `dockerOptions` |  | X |
| `dockerfile` |  | X |
| `script` |  |  |
