
# npmExecute

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `defaultNpmRegistry` | no |  |  |
| `dockerImage` | no | `node:8-stretch` |  |
| `dockerOptions` | no |  |  |
| `npmCommand` | no |  |  |
| `script` | yes |  |  |

* `defaultNpmRegistry` - URL of default NPM registry
* `dockerImage` - Name of the docker image that should be used, in which node should be installed and configured. Default value is 'node:8-stretch'.
* `dockerOptions` - Docker options to be set when starting the container.
* `npmCommand` - Which NPM command should be executed.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `defaultNpmRegistry` |  | X |
| `dockerImage` |  | X |
| `dockerOptions` |  |  |
| `npmCommand` |  | X |
| `script` |  |  |

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


## Exceptions

None

## Examples

```groovy
npmExecute script: this, dockerImage: 'node:8-stretch', npmCommand: 'run build'
```
