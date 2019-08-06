# snykExecute

## Description

This step performs an open source vulnerability scan on a *Node project* or *Node module inside an MTA project* through snyk.io.

## Prerequisites

* **Snyk account** - have an account on snyk.io
* **Snyk token** - have a Snyk user token

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `buildDescriptorFile` | no | `./package.json` |  |
| `dockerImage` | no | `node:8-stretch` |  |
| `exclude` | no | `[]` |  |
| `monitor` | no | `true` |  |
| `scanType` | no | `npm` | `npm`, `mta` |
| `script` | yes |  |  |
| `snykCredentialsId` | yes |  | Jenkins credentials id |
| `snykOrg` | no |  |  |
| `toHtml` | no | `false` |  |
| `toJson` | no | `false` |  |

* `buildDescriptorFile` - The path to the build descriptor file, e.g. `./package.json`.
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used and the command is executed directly on the Jenkins system.
* `exclude` - Only scanType 'mta': Exclude modules from MTA projects.
* `monitor` - Monitor the application's dependencies for new vulnerabilities.
* `scanType` - The type of project that should be scanned.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `snykCredentialsId` - Credentials for accessing the Snyk API.
* `snykOrg` - Only needed for `monitor: true`: The organisation ID to determine the organisation to report to.
* `toHtml` - Generate and archive a HTML report.
* `toJson` - Generate and archive a JSON report.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `buildDescriptorFile` |  | X |
| `dockerImage` |  | X |
| `exclude` |  | X |
| `monitor` |  | X |
| `scanType` |  | X |
| `script` |  |  |
| `snykCredentialsId` | X | X |
| `snykOrg` |  | X |
| `toHtml` |  | X |
| `toJson` |  | X |

## Dependencies

The step depends on the following Jenkins plugins

* [credentials-binding](https://plugins.jenkins.io/credentials-binding)
* [docker](https://plugins.jenkins.io/docker)
* [kubernetes](https://plugins.jenkins.io/kubernetes)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps](https://plugins.jenkins.io/workflow-cps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)
* [workflow-durable-task-step](https://plugins.jenkins.io/workflow-durable-task-step)

The kubernetes plugin is only used if running in a kubernetes environment.
Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.


## Side effects

Step uses `dockerExecute` inside.

## Exceptions

none

## Example

```groovy
snykExecute script: this, snykCredentialsId: 'mySnykToken'
```
