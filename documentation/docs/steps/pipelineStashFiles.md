# pipelineStashFiles

## Description

This step stashes files that are needed in other build steps (on other nodes).

## Prerequsites

none

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `script` | yes |  |  |
| `stashExcludes` | no |  |  |
| `stashIncludes` | no |  |  |

* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `stashExcludes` - Can be used to overwrite the default behavior of existing stashes as well as to define additional stashes. This parameter handles the _excludes_ and can be defined as a map of stash name and exclude patterns. Exclude pattern has to be a string with comma separated patterns as per [Pipeline basic step `stash`](https://jenkins.io/doc/pipeline/steps/workflow-basic-steps/#stash-stash-some-files-to-be-used-later-in-the-build)
* `stashIncludes` - Can be used to overwrite the default behavior of existing stashes as well as to define additional stashes. This parameter handles the _includes_ and can be defined as a map of stash name and include patterns. Include pattern has to be a string with comma separated patterns as per [Pipeline basic step `stash`](https://jenkins.io/doc/pipeline/steps/workflow-basic-steps/#stash-stash-some-files-to-be-used-later-in-the-build)

Details:

The step is stashing files before and after the build. This is due to the fact, that some of the code that needs to be stashed, is generated during the build (TypeScript for NPM).

| stash name | mandatory | prerequisite | pattern |
|---|---|---|---|
|buildDescriptor|no| |includes: `**/pom.xml, **/.mvn/**, **/assembly.xml, **/.swagger-codegen-ignore, **/package.json, **/requirements.txt, **/setup.py, **/whitesource_config.py, **/mta*.y*ml, **/.npmrc, **/whitesource.*.json, **/whitesource-fs-agent.config, Dockerfile, **/VERSION, **/version.txt, **/Gopkg.*, **/dub.json, **/dub.sdl, **/build.sbt, **/sbtDescriptor.json, **/project/*`<br /> excludes: `**/node_modules/**/package.json`|
|checkmarx|no|Checkmarx is enabled|includes: `**/*.js, **/*.scala, **/*.go, **/*.d, **/*.di`<br /> excludes: `**/*.mockserver.js, node_modules/**/*.js`|
|classFiles|no| |includes: `**/target/classes/**/*.class, **/target/test-classes/**/*.class` <br />excludes: `''`|
|deployDescriptor|no| |includes: `**/manifest*.y*ml, **/*.mtaext.y*ml, **/*.mtaext, **/xs-app.json, helm/**, *.y*ml`<br />exclude: `''`|
|git|no| |includes: `**/gitmetadata/**`<br />exludes: `''`|
|opa5|no|OPA5 is enabled|includes: `**/*.*`<br />excludes: `''`|
|opensourceConfiguration|no| |includes: `**/srcclr.yml, **/vulas-custom.properties, **/.nsprc, **/.retireignore, **/.retireignore.json, **/.snyk`<br />excludes: `''`|
|pipelineConfigAndTests|no| |includes: `.pipeline/*.*`<br />excludes: `''`|
|securityDescriptor|no| |includes: `**/xs-security.json`<br />exludes: `''`|
|sonar|no| |includes: `**/jacoco*.exec, **/sonar-project.properties`<br />exludes: `''`|
|tests|no| |includes: `**/pom.xml, **/*.json, **/*.xml, **/src/**, **/node_modules/**, **/specs/**, **/env/**, **/*.js`<br />excludes: `''`|

!!! note "Overwriting default stashing behavior"
    It is possible to overwrite the default behavior of the stashes using the parameters `stashIncludes` and `stashExcludes` , e.g.

    * `stashIncludes: [buildDescriptor: '**/mybuild.yml]`
    * `stashExcludes: [tests: '**/NOTRELEVANT.*]`

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `script` |  |  |
| `stashExcludes` |  |  |
| `stashIncludes` |  |  |

## Dependencies

The step depends on the following Jenkins plugins

* &lt;none&gt;

Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.


## Explanation of pipeline step

Usage of pipeline step:

```groovy
pipelineStashFiles script: this {
  mavenExecute script: this, ...
}
```
