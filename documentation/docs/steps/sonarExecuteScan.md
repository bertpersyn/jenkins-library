# sonarExecuteScan

## Description

The step executes the [sonar-scanner](https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner) cli command to scan the defined sources and publish the results to a SonarQube instance.

## Prerequsites

- The project needs a `sonar-project.properties` file that describes the project and defines certain settings, see [here](https://docs.sonarqube.org/display/SCAN/Advanced+SonarQube+Scanner+Usages#AdvancedSonarQubeScannerUsages-Multi-moduleProjectStructure).
- A SonarQube instance needs to be defined in the Jenkins.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `disableInlineComments` | no |  | `true`, `false` |
| `dockerImage` | no | `maven:3.5-jdk-8` |  |
| `githubApiUrl` | no | `https://api.github.com` |  |
| `githubOrg` | yes |  |  |
| `githubRepo` | yes |  |  |
| `githubTokenCredentialsId` | yes |  | Jenkins credential id |
| `instance` | no | `SonarCloud` |  |
| `legacyPRHandling` | no |  | `true`, `false` |
| `options` | no | `[]` |  |
| `organization` | no |  |  |
| `projectVersion` | no |  |  |
| `script` | yes |  |  |
| `sonarTokenCredentialsId` | no |  | Jenkins credential id |

* `disableInlineComments` - Pull-Request voting only: Disables the pull-request decoration with inline comments. deprecated: only supported in LTS / < 7.2
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used and the command is executed directly on the Jenkins system. see dockerExecute
* `githubApiUrl` - Pull-Request voting only: The URL to the Github API. see https://docs.sonarqube.org/display/PLUG/GitHub+Plugin#GitHubPlugin-Usage deprecated: only supported in LTS / < 7.2
* `githubOrg` - Pull-Request voting only: The Github organization. @default: `commonPipelineEnvironment.getGithubOrg()`
* `githubRepo` - Pull-Request voting only: The Github repository. @default: `commonPipelineEnvironment.getGithubRepo()`
* `githubTokenCredentialsId` - Pull-Request voting only: The Jenkins credentialId for a Github token. It is needed to report findings back to the pull-request. deprecated: only supported in LTS / < 7.2
* `instance` - The name of the SonarQube instance defined in the Jenkins settings.
* `legacyPRHandling` - Pull-Request voting only: Activates the pull-request handling using the [GitHub Plugin](https://docs.sonarqube.org/display/PLUG/GitHub+Plugin) (deprecated). deprecated: only supported in LTS / < 7.2
* `options` - A list of options which are passed to the `sonar-scanner`.
* `organization` - Organization that the project will be assigned to in SonarCloud.io.
* `projectVersion` - The project version that is reported to SonarQube. @default: major number of `commonPipelineEnvironment.getArtifactVersion()`
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `sonarTokenCredentialsId` - The Jenkins credentialsId for a SonarQube token. It is needed for non-anonymous analysis runs. see https://sonarcloud.io/account/security

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `disableInlineComments` |  | X |
| `dockerImage` |  | X |
| `githubApiUrl` | X | X |
| `githubOrg` | X | X |
| `githubRepo` | X | X |
| `githubTokenCredentialsId` | X | X |
| `instance` |  | X |
| `legacyPRHandling` |  | X |
| `options` |  | X |
| `organization` |  | X |
| `projectVersion` |  | X |
| `script` |  |  |
| `sonarTokenCredentialsId` | X | X |

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


## Exceptions

none

## Examples
