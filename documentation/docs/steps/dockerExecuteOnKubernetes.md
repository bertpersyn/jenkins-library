# dockerExecuteOnKubernetes

## Description

Executes a closure inside a container in a kubernetes pod.
Proxy environment variables defined on the Jenkins machine are also available in the container.

By default jnlp agent defined for kubernetes-plugin will be used (see https://github.com/jenkinsci/kubernetes-plugin#pipeline-support).

It is possible to define a custom jnlp agent image by

1. Defining the jnlp image via environment variable JENKINS_JNLP_IMAGE in the Kubernetes landscape
2. Defining the image via config (`jenkinsKubernetes.jnlpAgent`)

Option 1 will take precedence over option 2.

## Prerequisites

* The Jenkins should be running on kubernetes.
* An environment variable `ON_K8S` should be created on Jenkins and initialized to `true`. This could for example be done via _Jenkins_ - _Manage Jenkins_ - _Configure System_ - _Global properties_ - _Environment variables_

![Jenkins environment variable configuration](../images/k8s_env.png)

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `containerCommand` | no |  |  |
| `containerCommands` | no |  |  |
| `containerEnvVars` | no |  |  |
| `containerMap` | no |  |  |
| `containerName` | no |  |  |
| `containerPortMappings` | no |  |  |
| `containerPullImageFlags` | no |  |  |
| `containerShell` | no |  |  |
| `containerWorkspaces` | no |  |  |
| `dockerEnvVars` | no |  |  |
| `dockerImage` | yes |  |  |
| `dockerPullImage` | no | `true` |  |
| `dockerWorkspace` | no |  |  |
| `jenkinsKubernetes` | no | `[:]` |  |
| `nodeSelector` | no |  |  |
| `script` | yes |  |  |
| `securityContext` | no |  |  |
| `stashContent` | no | `[]` |  |
| `stashExcludes` | no | `[workspace:nohup.out]` |  |
| `stashIncludes` | no | `[workspace:**/*]` |  |
| `verbose` | no |  | `true`, `false` |

* `containerCommand` - Allows to specify start command for container created with dockerImage parameter to overwrite Piper default (`/usr/bin/tail -f /dev/null`).
* `containerCommands` - Specifies start command for containers to overwrite Piper default (`/usr/bin/tail -f /dev/null`). If container's defaultstart command should be used provide empty string like: `['selenium/standalone-chrome': '']`.
* `containerEnvVars` - Specifies environment variables per container. If not provided `dockerEnvVars` will be used.
* `containerMap` - A map of docker image to the name of the container. The pod will be created with all the images from this map and they are labled based on the value field of each map entry. Example: `['maven:3.5-jdk-8-alpine': 'mavenExecute', 'selenium/standalone-chrome': 'selenium', 'famiko/jmeter-base': 'checkJMeter', 's4sdk/docker-cf-cli': 'cloudfoundry']`
* `containerName` - Optional configuration in combination with containerMap to define the container where the commands should be executed in.
* `containerPortMappings` - Map which defines per docker image the port mappings, e.g. `containerPortMappings: ['selenium/standalone-chrome': [[name: 'selPort', containerPort: 4444, hostPort: 4444]]]`.
* `containerPullImageFlags` - Specifies the pullImage flag per container.
* `containerShell` - Allows to specify the shell to be executed for container with containerName.
* `containerWorkspaces` - Specifies a dedicated user home directory per container which will be passed as value for environment variable `HOME`. If not provided `dockerWorkspace` will be used.
* `dockerEnvVars` - Environment variables to set in the container, e.g. [http_proxy:'proxy:8080'].
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used.
* `dockerPullImage` - Set this to 'false' to bypass a docker image pull. Usefull during development process. Allows testing of images which are available in the local registry only.
* `dockerWorkspace` - Specifies a dedicated user home directory for the container which will be passed as value for environment variable `HOME`.
* `jenkinsKubernetes` - 
* `nodeSelector` - Defines the Kubernetes nodeSelector as per [https://github.com/jenkinsci/kubernetes-plugin](https://github.com/jenkinsci/kubernetes-plugin).
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `securityContext` - Kubernetes Security Context used for the pod. Can be used to specify uid and fsGroup. See: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
* `stashContent` - Specific stashes that should be considered for the step execution.
* `stashExcludes` - 
* `stashIncludes` - 
* `verbose` - Print more detailed information into the log.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `containerCommand` |  | X |
| `containerCommands` |  | X |
| `containerEnvVars` |  | X |
| `containerMap` |  | X |
| `containerName` |  | X |
| `containerPortMappings` |  | X |
| `containerPullImageFlags` |  | X |
| `containerShell` |  | X |
| `containerWorkspaces` |  | X |
| `dockerEnvVars` |  | X |
| `dockerImage` |  | X |
| `dockerPullImage` |  | X |
| `dockerWorkspace` |  | X |
| `jenkinsKubernetes` | X | X |
| `nodeSelector` |  | X |
| `script` |  |  |
| `securityContext` |  | X |
| `stashContent` |  | X |
| `stashExcludes` |  | X |
| `stashIncludes` |  | X |
| `verbose` | X | X |

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

## Example 1: Run a closure in a single container pod

```sh
# set environment variable
export ON_K8S=true"
```

```groovy
dockerExecuteOnKubernetes(script: script, dockerImage: 'maven:3.5-jdk-7'){
    sh "mvn clean install"
}
```

In the above example, a pod will be created with a docker container of image `maven:3.5-jdk-7`. The closure will be then executed inside the container.

## Example 2: Run a closure in a multi-container pod

```sh
# set environment variable
export ON_K8S=true"
```

```groovy
dockerExecuteOnKubernetes(script: script, containerMap: ['maven:3.5-jdk-8-alpine': 'maven', 's4sdk/docker-cf-cli': 'cfcli']){
    container('maven'){
        sh "mvn clean install"
    }
    container('cfcli'){
        sh "cf plugins"
    }
}
```

In the above example, a pod will be created with multiple Docker containers that are passed as a `containerMap`. The containers can be chosen for executing by referring their labels as shown in the example.

## Example 3: Running a closure in a dedicated container of a multi-container pod

```sh
# set environment variable
export ON_K8S=true"
```

```groovy
dockerExecuteOnKubernetes(
  script: script,
  containerCommands: ['selenium/standalone-chrome': ''],
  containerMap: ['maven:3.5-jdk-8-alpine': 'maven', 'selenium/standalone-chrome': 'selenium'],
  containerName: 'maven',
  containerPortMappings: ['selenium/standalone-chrome': [containerPort: 4444, hostPort: 4444]]
  containerWorkspaces: ['selenium/standalone-chrome': '']
){
  echo "Executing inside a Kubernetes Pod inside 'maven' container to run Selenium tests"
  sh "mvn clean install"
}
```
