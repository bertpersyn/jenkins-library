# mtaBuild

## Description

Executes the SAP Multitarget Application Archive Builder to create an mtar archive of the application.

## Prerequisites

While using a custom docker file, ensure that the following tools are installed:

* **SAP MTA Archive Builder 1.0.6 or compatible version** - can be downloaded from [SAP Development Tools](https://tools.hana.ondemand.com/#cloud).
* **Java 8 or compatible version** - necessary to run the *MTA Archive Builder* itself and to build Java modules.
* **NodeJS installed** - the MTA Builder uses `npm` to download node module dependencies such as `grunt`.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `applicationName` | no |  |  |
| `buildTarget` | no | `NEO` | 'CF', 'NEO', 'XSA' |
| `defaultNpmRegistry` | no |  |  |
| `dockerImage` | no | `ppiper/mta-archive-builder` |  |
| `dockerOptions` | no |  |  |
| `extension` | no |  |  |
| `globalSettingsFile` | no |  |  |
| `mtaJarLocation` | no | `/opt/sap/mta/lib/mta.jar` |  |
| `projectSettingsFile` | no |  |  |
| `script` | yes |  |  |

* `applicationName` - The name of the application which is being built. If the parameter has been provided and no `mta.yaml` exists, the `mta.yaml` will be automatically generated using this parameter and the information (`name` and `version`) from `package.json` before the actual build starts.
* `buildTarget` - The target platform to which the mtar can be deployed.
* `defaultNpmRegistry` - Url to the npm registry that should be used for installing npm dependencies.
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used and the command is executed directly on the Jenkins system.
* `dockerOptions` - Docker options to be set when starting the container (List or String).
* `extension` - The path to the extension descriptor file.
* `globalSettingsFile` - Path or url to the mvn settings file that should be used as global settings file.
* `mtaJarLocation` - The location of the SAP Multitarget Application Archive Builder jar file, including file name and extension. If it is not provided, the SAP Multitarget Application Archive Builder is expected on PATH.
* `projectSettingsFile` - Path or url to the mvn settings file that should be used as project settings file.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `applicationName` |  | X |
| `buildTarget` |  | X |
| `defaultNpmRegistry` |  |  |
| `dockerImage` |  | X |
| `dockerOptions` |  |  |
| `extension` |  | X |
| `globalSettingsFile` |  | X |
| `mtaJarLocation` |  | X |
| `projectSettingsFile` |  | X |
| `script` |  |  |

## Dependencies

The step depends on the following Jenkins plugins

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


## Side effects

1. The file name of the resulting archive is written to the `commonPipelineEnvironment` with variable name `mtarFileName`.

## Exceptions

* `AbortException`:
  * If there is an invalid `buildTarget`.
  * If there is no key `ID` inside the `mta.yaml` file.

## Example

```groovy
dir('/path/to/FioriApp'){
  mtaBuild script:this, buildTarget: 'NEO'
}
def mtarFilePath = commonPipelineEnvironment.getMtarFilePath()
```
