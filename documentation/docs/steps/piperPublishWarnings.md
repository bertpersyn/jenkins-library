# piperPublishWarnings

## Description

This step scans the current build log for messages produces by the Piper library steps and publishes them on the Jenkins job run as *Piper warnings* via the warnings-ng plugin.

The default parser detects log entries with the following pattern: `[<SEVERITY>] <MESSAGE> (<LIBRARY>/<STEP>)`

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `parserId` | no | `piper` |  |
| `parserName` | no | `Piper` |  |
| `parserPattern` | no | `\[(INFO|WARNING|ERROR)\] (.*) \(([^) ]*)\/([^) ]*)\)` |  |
| `parserScript` | no | `return builder.guessSeverity(matcher.group(1)).setMessage(matcher.group(2)).setModuleName(matcher.group(3)).setType(matcher.group(4)).buildOptional()` |  |
| `recordIssuesSettings` | no | `[blameDisabled:true, enabledForFailure:true]` |  |
| `script` | yes |  |  |

* `parserId` - The id of the Groovy script parser. If the id is not present in the current Jenkins configuration it is created.
* `parserName` - The display name for the warnings parsed by the parser. Only considered if a new parser is created.
* `parserPattern` - The pattern used to parse the log file. Only considered if a new parser is created.
* `parserScript` - The script used to parse the matches produced by the pattern into issues. Only considered if a new parser is created. see https://github.com/jenkinsci/analysis-model/blob/master/src/main/java/edu/hm/hafner/analysis/IssueBuilder.java
* `recordIssuesSettings` - Settings that are passed to the recordIssues step of the warnings-ng plugin. see https://github.com/jenkinsci/warnings-ng-plugin/blob/master/doc/Documentation.md#configuration
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `parserId` |  | X |
| `parserName` |  | X |
| `parserPattern` |  | X |
| `parserScript` |  | X |
| `recordIssuesSettings` |  | X |
| `script` |  |  |

## Dependencies

The step depends on the following Jenkins plugins

* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [warnings-ng](https://plugins.jenkins.io/warnings-ng)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)

Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.

