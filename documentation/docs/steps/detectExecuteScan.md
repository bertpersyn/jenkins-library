# detectExecuteScan

## Description

This step executes [Synopsis Detect](https://synopsys.atlassian.net/wiki/spaces/INTDOCS/pages/62423113/Synopsys+Detect) scans.

## Prerequsites

You need to store the API token for the Detect service as _'Secret text'_ credential in your Jenkins system.

!!! note "minimum plugin requirement"
    This step requires [synopsys-detect-plugin](https://github.com/jenkinsci/synopsys-detect-plugin) with at least version `2.0.0`.

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
detectExecuteScan script: this, scanProperties: ['--logging.level.com.synopsys.integration=TRACE']
```

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `buildTool` | no |  | `golang`, any other build tool |
| `detect/apiTokenCredentialsId` | yes |  |  |
| `detect/projectName` | yes |  |  |
| `detect/projectVersion` | no | `1` |  |
| `detect/scanPaths` | no | `[.]` |  |
| `detect/scanProperties` | no | `[--blackduck.signature.scanner.memory=4096, --blackduck.timeout=6000, --blackduck.trust.cert=true, --detect.policy.check.fail.on.severities=BLOCKER,CRITICAL,MAJOR, --detect.report.timeout=4800, --logging.level.com.synopsys.integration=DEBUG]` |  |
| `detect/scanners` | no | `[signature]` | `['signature']` |
| `detect/serverUrl` | no |  |  |
| `dockerImage` | no | buildTool=`golang`:`golang:1.12-stretch` |  |
| `dockerWorkspace` | no | buildTool=`golang`:`<empty>` |  |
| `script` | yes |  |  |
| `stashContent` | no | `[buildDescriptor, checkmarx]` |  |

* `buildTool` - Defines the tool which is used for building the artifact.<br /> Currently, it is possible to select two behaviors of the step: <br /> 1. Golang-specific behavior (`buildTool: golang`). Assumption here is that project uses the dependency management tool _dep_<br /> 2. Custom-specific behavior for all other values of `buildTool`
* `detect/apiTokenCredentialsId` - Jenkins 'Secret text' credentials ID containing the API token used to authenticate with the Synopsis Detect (formerly BlackDuck) Server.
* `detect/projectName` - Name of the Synopsis Detect (formerly BlackDuck) project.
* `detect/projectVersion` - Version of the Synopsis Detect (formerly BlackDuck) project.
* `detect/scanPaths` - List of paths which should be scanned by the Synopsis Detect (formerly BlackDuck) scan.
* `detect/scanProperties` - Properties passed to the Synopsis Detect (formerly BlackDuck) scan. You can find details in the [Synopsis Detect documentation](https://synopsys.atlassian.net/wiki/spaces/INTDOCS/pages/622846/Using+Synopsys+Detect+Properties)
* `detect/scanners` - List of scanners to be used for Synopsis Detect (formerly BlackDuck) scan.
* `detect/serverUrl` - Server url to the Synopsis Detect (formerly BlackDuck) Server.
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used and the command is executed directly on the Jenkins system.
* `dockerWorkspace` - Kubernetes only: Specifies a dedicated user home directory for the container which will be passed as value for environment variable `HOME`.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `stashContent` - If specific stashes should be considered for the scan, their names need to be passed via the parameter `stashContent`.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `buildTool` | X | X |
| `detect/apiTokenCredentialsId` | X | X |
| `detect/projectName` | X | X |
| `detect/projectVersion` | X | X |
| `detect/scanPaths` | X | X |
| `detect/scanProperties` | X | X |
| `detect/scanners` | X | X |
| `detect/serverUrl` | X | X |
| `dockerImage` |  | X |
| `dockerWorkspace` |  | X |
| `script` |  |  |
| `stashContent` |  | X |
