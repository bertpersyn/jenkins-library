# hadolintExecute

## Description

Executes the Haskell Dockerfile Linter which is a smarter Dockerfile linter that helps you build [best practice](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) Docker images.
The linter is parsing the Dockerfile into an abstract syntax tree (AST) and performs rules on top of the AST.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `configurationFile` | no | `.hadolint.yaml` |  |
| `configurationUrl` | no | `` |  |
| `dockerFile` | no | `./Dockerfile` |  |
| `dockerImage` | no | `hadolint/hadolint:latest-debian` |  |
| `dockerOptions` | no |  |  |
| `qualityGates` | no | `[[threshold:1, type:TOTAL_ERROR, unstable:false]]` |  |
| `reportFile` | no | `hadolint.xml` |  |
| `script` | yes |  |  |

* `configurationFile` - Name of the configuration file used locally within the step. If a file with this name is detected as part of your repo downloading the central configuration via `configurationUrl` will be skipped. If you change the file's name make sure your stashing configuration also reflects this.
* `configurationUrl` - URL pointing to the .hadolint.yaml exclude configuration to be used for linting. Also have a look at `configurationFile` which could avoid central configuration download in case the file is part of your repository.
* `dockerFile` - Dockerfile to be used for the assessment.
* `dockerImage` - Name of the docker image that should be used, in which node should be installed and configured. Default value is 'hadolint/hadolint:latest-debian'.
* `dockerOptions` - Docker options to be set when starting the container.
* `qualityGates` - Quality Gates to fail the build, see [warnings-ng plugin documentation](https://github.com/jenkinsci/warnings-plugin/blob/master/doc/Documentation.md#quality-gate-configuration).
* `reportFile` - Name of the result file used locally within the step.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `configurationFile` |  | X |
| `configurationUrl` |  | X |
| `dockerFile` | X | X |
| `dockerImage` | X | X |
| `dockerOptions` |  | X |
| `qualityGates` |  | X |
| `reportFile` |  | X |
| `script` |  |  |

## Exceptions

None

## Examples

```groovy
hadolintExecute script: this
```
