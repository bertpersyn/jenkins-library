# artifactSetVersion

## Description

The continuous delivery process requires that each build is done with a unique version number.

The version generated using this step will contain:

* Version (major.minor.patch) from descriptor file in master repository is preserved. Developers should be able to autonomously decide on increasing either part of this version number.
* Timestamp
* CommitId (by default the long version of the hash)

Optionally, but enabled by default, the new version is pushed as a new tag into the source code repository (e.g. GitHub).
If this option is chosen, git credentials and the repository URL needs to be provided.
Since you might not want to configure the git credentials in Jenkins, committing and pushing can be disabled using the `commitVersion` parameter as described below.
If you require strict reproducibility of your builds, this should be used.

## Prerequsites

none

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `artifactType` | no |  | `appContainer` |
| `buildTool` | yes |  | `dub`, `docker`, `golang`, `maven`, `mta`, `npm`, `pip`, `sbt` |
| `commitVersion` | no | `true` | `true`, `false` |
| `dockerVersionSource` | no |  | FROM, (ENV name),appVersion |
| `filePath` | no | buildTool=`dub`:`dub.json`<br />buildTool=`docker`:`Dockerfile`<br />buildTool=`golang`:`VERSION`<br />buildTool=`maven`:`pom.xml`<br />buildTool=`mta`:`mta.yaml`<br />buildTool=`npm`:`package.json`<br />buildTool=`pip`:`version.txt`<br />buildTool=`sbt`:`sbtDescriptor.json` |  |
| `gitCommitId` | no |  |  |
| `gitSshKeyCredentialsId` | no | `` |  |
| `gitSshUrl` | yes |  |  |
| `gitUserEMail` | no |  |  |
| `gitUserName` | no |  |  |
| `script` | yes |  |  |
| `tagPrefix` | no | `build_` |  |
| `timestamp` | no |  |  |
| `timestampTemplate` | no | `%Y%m%d%H%M%S` |  |
| `versioningTemplate` | no | buildTool=`dub`:`${version}-${timestamp}${commitId?"+"+commitId:""}`<br />buildTool=`docker`:`${version}-${timestamp}${commitId?"_"+commitId:""}`<br />buildTool=`golang`:`${version}-${timestamp}${commitId?"+"+commitId:""}`<br />buildTool=`maven`:`${version}-${timestamp}${commitId?"_"+commitId:""}`<br />buildTool=`mta`:`${version}-${timestamp}${commitId?"+"+commitId:""}`<br />buildTool=`npm`:`${version}-${timestamp}${commitId?"+"+commitId:""}`<br />buildTool=`pip`:`${version}.${timestamp}${commitId?"."+commitId:""}`<br />buildTool=`sbt`:`${version}-${timestamp}${commitId?"+"+commitId:""}` |  |

* `artifactType` - Defines the type of the artifact.
* `buildTool` - Defines the tool which is used for building the artifact.
* `commitVersion` - Controls if the changed version is committed and pushed to the git repository. If this is enabled (which is the default), you need to provide `gitCredentialsId` and `gitSshUrl`.
* `dockerVersionSource` - Specifies the source to be used for the main version which is used for generating the automatic version. * This can either be the version of the base image - as retrieved from the `FROM` statement within the Dockerfile, e.g. `FROM jenkins:2.46.2` * Alternatively the name of an environment variable defined in the Docker image can be used which contains the version number, e.g. `ENV MY_VERSION 1.2.3` * The third option `appVersion` applies only to the artifactType `appContainer`. Here the version of the app which is packaged into the container will be used as version for the container itself.
* `filePath` - Defines a custom path to the descriptor file.
* `gitCommitId` - Defines the version prefix of the automatically generated version. By default it will take the long commitId hash. You could pass any other string (e.g. the short commitId hash) to be used. In case you don't want to have the gitCommitId added to the automatic versioning string you could set the value to an empty string: `''`.
* `gitSshKeyCredentialsId` - Defines the ssh git credentials to be used for writing the tag.
* `gitSshUrl` - Defines the git ssh url to the source code repository.
* `gitUserEMail` - Allows to overwrite the global git setting 'user.email' available on your Jenkins server.
* `gitUserName` - Allows to overwrite the global git setting 'user.name' available on your Jenkins server.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `tagPrefix` - Defines the prefix which is used for the git tag which is written during the versioning run.
* `timestamp` - Defines the timestamp to be used in the automatic version string. You could overwrite the default behavior by explicitly setting this string.
* `timestampTemplate` - Defines the template for the timestamp which will be part of the created version.
* `versioningTemplate` - Defines the template for the automatic version which will be created.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `artifactType` |  | X |
| `buildTool` |  | X |
| `commitVersion` |  | X |
| `dockerVersionSource` |  | X |
| `filePath` |  | X |
| `gitCommitId` |  |  |
| `gitSshKeyCredentialsId` |  | X |
| `gitSshUrl` |  | X |
| `gitUserEMail` |  | X |
| `gitUserName` |  | X |
| `script` |  |  |
| `tagPrefix` |  | X |
| `timestamp` |  | X |
| `timestampTemplate` |  | X |
| `versioningTemplate` |  | X |

## Dependencies

The step depends on the following Jenkins plugins

* [docker](https://plugins.jenkins.io/docker)
* [kubernetes](https://plugins.jenkins.io/kubernetes)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [ssh-agent](https://plugins.jenkins.io/ssh-agent)
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
artifactSetVersion script: this, buildTool: 'maven'
```
