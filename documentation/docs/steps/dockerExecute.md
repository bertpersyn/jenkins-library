# dockerExecute

## Description

Executes a closure inside a docker container with the specified docker image.
The workspace is mounted into the docker image.
Proxy environment variables defined on the Jenkins machine are also available in the Docker container.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `containerCommand` | no |  |  |
| `containerPortMappings` | no |  |  |
| `containerShell` | no |  |  |
| `dockerEnvVars` | no |  |  |
| `dockerImage` | no |  |  |
| `dockerName` | no |  |  |
| `dockerOptions` | no |  |  |
| `dockerPullImage` | no | `true` |  |
| `dockerVolumeBind` | no |  |  |
| `dockerWorkspace` | no |  |  |
| `jenkinsKubernetes` | no | `[:]` |  |
| `script` | yes |  |  |
| `sidecarEnvVars` | no |  |  |
| `sidecarImage` | no |  |  |
| `sidecarName` | no |  |  |
| `sidecarOptions` | no |  |  |
| `sidecarPullImage` | no | `true` |  |
| `sidecarReadyCommand` | no |  |  |
| `sidecarVolumeBind` | no |  |  |
| `sidecarWorkspace` | no |  |  |
| `stashContent` | no | `[]` |  |

* `containerCommand` - Kubernetes only: Allows to specify start command for container created with dockerImage parameter to overwrite Piper default (`/usr/bin/tail -f /dev/null`).
* `containerPortMappings` - Map which defines per docker image the port mappings, e.g. `containerPortMappings: ['selenium/standalone-chrome': [[name: 'selPort', containerPort: 4444, hostPort: 4444]]]`.
* `containerShell` - Kubernetes only: Allows to specify the shell to be used for execution of commands.
* `dockerEnvVars` - Environment variables to set in the container, e.g. [http_proxy: 'proxy:8080'].
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used and the command is executed directly on the Jenkins system.
* `dockerName` - Kubernetes only: Name of the container launching `dockerImage`. SideCar only: Name of the container in local network.
* `dockerOptions` - Docker options to be set when starting the container (List or String).
* `dockerPullImage` - Set this to 'false' to bypass a docker image pull. Usefull during development process. Allows testing of images which are available in the local registry only.
* `dockerVolumeBind` - Volumes that should be mounted into the container.
* `dockerWorkspace` - Kubernetes only: Specifies a dedicated user home directory for the container which will be passed as value for environment variable `HOME`.
* `jenkinsKubernetes` - 
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `sidecarEnvVars` - as `dockerEnvVars` for the sidecar container
* `sidecarImage` - as `dockerImage` for the sidecar container
* `sidecarName` - as `dockerName` for the sidecar container
* `sidecarOptions` - as `dockerOptions` for the sidecar container
* `sidecarPullImage` - Set this to 'false' to bypass a docker image pull. Usefull during development process. Allows testing of images which are available in the local registry only.
* `sidecarReadyCommand` - Command executed inside the container which returns exit code 0 when the container is ready to be used.
* `sidecarVolumeBind` - as `dockerVolumeBind` for the sidecar container
* `sidecarWorkspace` - as `dockerWorkspace` for the sidecar container
* `stashContent` - Specific stashes that should be considered for the step execution.

## Kubernetes support

If the Jenkins is setup on a Kubernetes cluster, then you can execute the closure inside a container of a pod by setting an environment variable `ON_K8S` to `true`. However, it will ignore `containerPortMappings`, `dockerOptions` and `dockerVolumeBind` values.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `containerCommand` |  | X |
| `containerPortMappings` |  | X |
| `containerShell` |  | X |
| `dockerEnvVars` |  | X |
| `dockerImage` |  | X |
| `dockerName` |  | X |
| `dockerOptions` |  | X |
| `dockerPullImage` |  | X |
| `dockerVolumeBind` |  | X |
| `dockerWorkspace` |  | X |
| `jenkinsKubernetes` | X | X |
| `script` |  |  |
| `sidecarEnvVars` |  | X |
| `sidecarImage` |  | X |
| `sidecarName` |  | X |
| `sidecarOptions` |  | X |
| `sidecarPullImage` |  | X |
| `sidecarReadyCommand` |  | X |
| `sidecarVolumeBind` |  | X |
| `sidecarWorkspace` |  | X |
| `stashContent` |  | X |

## Dependencies

The step depends on the following Jenkins plugins

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


## Side effects

none

## Exceptions

none

## Example 1: Run closure inside a docker container

```groovy
dockerExecute(dockerImage: 'maven:3.5-jdk-7'){
    sh "mvn clean install"
}
```

## Example 2: Run closure inside a container in a kubernetes pod

```sh
# set environment variable
export ON_K8S=true"
```

```groovy
dockerExecute(script: this, dockerImage: 'maven:3.5-jdk-7'){
    sh "mvn clean install"
}
```

In the above example, the `dockerEcecute` step will internally invoke [dockerExecuteOnKubernetes](dockerExecuteOnKubernetes.md) step and execute the closure inside a pod.

## Example 3: Run closure inside a container which is attached to a sidecar container (as for example used in [seleniumExecuteTests](seleniumExecuteTests.md)

```groovy
dockerExecute(
        script: script,
        containerPortMappings: [containerPortMappings:'selenium/standalone-chrome':[containerPort: 4444, hostPort: 4444]],
        dockerImage: 'node:8-stretch',
        dockerName: 'node',
        dockerWorkspace: '/home/node',
        sidecarImage: 'selenium/standalone-chrome',
        sidecarName: 'selenium',
) {
    git url: 'https://github.wdf.sap.corp/XXXXX/WebDriverIOTest.git'
    sh '''npm install
          node index.js
    '''
}
```
