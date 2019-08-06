# githubPublishRelease

## Prerequisites

You need to create a personal access token within GitHub and add this to the Jenkins credentials store.

Please see [GitHub documentation for details about creating the personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/).

## Dependencies

The step depends on the following Jenkins plugins

* [credentials-binding](https://plugins.jenkins.io/credentials-binding)
* [http_request](https://plugins.jenkins.io/http_request)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)

Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.


## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `addClosedIssues` | no | `false` | `true`, `false` |
| `addDeltaToLastRelease` | no | `false` | `true`, `false` |
| `customFilterExtension` | no | `` |  |
| `excludeLabels` | no | `[duplicate, invalid, question, wontfix]` |  |
| `githubApiUrl` | no | `https://api.github.com` |  |
| `githubOrg` | yes |  |  |
| `githubRepo` | yes |  |  |
| `githubServerUrl` | no | `https://github.com` |  |
| `githubTokenCredentialsId` | yes |  | Jenkins credential id |
| `releaseBodyHeader` | no |  |  |
| `script` | yes |  |  |
| `version` | yes |  |  |

* `addClosedIssues` - If it is set to `true`, a list of all closed issues and merged pull-requests since the last release will added below the `releaseBodyHeader`.
* `addDeltaToLastRelease` - If you set `addDeltaToLastRelease` to `true`, a link will be added to the relese information that brings up all commits since the last release.
* `customFilterExtension` - Allows to pass additional filter criteria for retrieving closed issues since the last release. Additional criteria could be for example specific `label`, or `filter` according to [GitHub API documentation](https://developer.github.com/v3/issues/).
* `excludeLabels` - Allows to exclude issues with dedicated labels. Usage is like `excludeLabels: ['label1', 'label2']`.
* `githubApiUrl` - Allows to overwrite the GitHub API url.
* `githubOrg` - Allows to overwrite the GitHub organitation.
* `githubRepo` - Allows to overwrite the GitHub repository.
* `githubServerUrl` - Allows to overwrite the GitHub url.
* `githubTokenCredentialsId` - Allows to overwrite the GitHub token credentials id.
* `releaseBodyHeader` - Allows to specify the content which will appear for the release.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `version` - Defines the version number which will be written as tag as well as release name.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `addClosedIssues` |  | X |
| `addDeltaToLastRelease` |  | X |
| `customFilterExtension` |  | X |
| `excludeLabels` |  | X |
| `githubApiUrl` | X | X |
| `githubOrg` |  | X |
| `githubRepo` |  | X |
| `githubServerUrl` | X | X |
| `githubTokenCredentialsId` | X | X |
| `releaseBodyHeader` |  | X |
| `script` |  |  |
| `version` |  | X |

## Description

This step creates a tag in your GitHub repository together with a release.

The release can be filled with text plus additional information like:

* Closed pull request since last release
* Closed issues since last release
* link to delta information showing all commits since last release

The result looks like

![Example release](../images/githubRelease.png)

## Example

Usage of pipeline step:

```groovy
githubPublishRelease script: this, releaseBodyHeader: "**This is the latest success!**<br />"
```
