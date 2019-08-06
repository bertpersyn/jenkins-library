# pipelineStashFilesBeforeBuild

## Description

This step stashes files that are needed in other build steps (on other nodes).

## Prerequsites

none

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `noDefaultExludes` | no | `[git]` |  |
| `script` | yes |  |  |
| `stashExcludes` | no | `[buildDescriptor:**/node_modules/**/package.json, deployDescriptor:, git:, opa5:, opensourceConfiguration:, pipelineConfigAndTests:, securityDescriptor:, tests:]` |  |
| `stashIncludes` | no | `[buildDescriptor:**/pom.xml, **/.mvn/**, **/assembly.xml, **/.swagger-codegen-ignore, **/package.json, **/requirements.txt, **/setup.py, **/mta*.y*ml, **/.npmrc, Dockerfile, .hadolint.yaml, **/VERSION, **/version.txt, **/Gopkg.*, **/dub.json, **/dub.sdl, **/build.sbt, **/sbtDescriptor.json, **/project/*, deployDescriptor:**/manifest*.y*ml, **/*.mtaext.y*ml, **/*.mtaext, **/xs-app.json, helm/**, *.y*ml, git:.git/**, opa5:**/*.*, opensourceConfiguration:**/srcclr.yml, **/vulas-custom.properties, **/.nsprc, **/.retireignore, **/.retireignore.json, **/.snyk, **/wss-unified-agent.config, **/vendor/**/*, pipelineConfigAndTests:.pipeline/**, securityDescriptor:**/xs-security.json, tests:**/pom.xml, **/*.json, **/*.xml, **/src/**, **/node_modules/**, **/specs/**, **/env/**, **/*.js, **/tests/**]` |  |

* `noDefaultExludes` - By default certain files are excluded from stashing (e.g. `.git` folder). Details can be found as per [Pipeline basic step `stash](https://jenkins.io/doc/pipeline/steps/workflow-basic-steps/#stash-stash-some-files-to-be-used-later-in-the-build). This parameter allows to provide a list of stash names for which the standard exclude behavior should be switched off. This will allow you to also stash directories like `.git`.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `stashExcludes` - Can be used to overwrite the default behavior of existing stashes as well as to define additional stashes. This parameter handles the _excludes_ and can be defined as a map of stash name and exclude patterns. Exclude pattern has to be a string with comma separated patterns as per [Pipeline basic step `stash`](https://jenkins.io/doc/pipeline/steps/workflow-basic-steps/#stash-stash-some-files-to-be-used-later-in-the-build)
* `stashIncludes` - Can be used to overwrite the default behavior of existing stashes as well as to define additional stashes. This parameter handles the _includes_ and can be defined as a map of stash name and include patterns. Include pattern has to be a string with comma separated patterns as per [Pipeline basic step `stash`](https://jenkins.io/doc/pipeline/steps/workflow-basic-steps/#stash-stash-some-files-to-be-used-later-in-the-build)

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `noDefaultExludes` |  | X |
| `script` |  |  |
| `stashExcludes` |  | X |
| `stashIncludes` |  | X |

## Dependencies

The step depends on the following Jenkins plugins

* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)

Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.

