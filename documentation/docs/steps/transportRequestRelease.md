# transportRequestRelease

## Description

Releases a Transport Request. 

## Prerequisites

* **[Change Management Client 2.0.0 or compatible version](http://central.maven.org/maven2/com/sap/devops/cmclient/dist.cli/)** - available for download on Maven Central.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `changeDocumentId` | yes |  |  |
| `changeManagement/clientOpts` | no | `` |  |
| `changeManagement/credentialsId` | no | `CM` |  |
| `changeManagement/endpoint` | yes |  |  |
| `changeManagement/git/format` | no | `%b` | see `git log --help` |
| `changeManagement/git/from` | no | `origin/master` |  |
| `changeManagement/git/to` | no | `HEAD` |  |
| `changeManagement/rfc/developmentClient` | yes |  |  |
| `changeManagement/rfc/developmentInstance` | yes |  |  |
| `script` | yes |  |  |
| `transportRequestId` | yes |  |  |
| `verbose` | no | `false` |  |

* `changeDocumentId` - The id of the change document to that the transport request is bound to. Typically this value is provided via commit message in the commit history. Only for `SOLMAN`.
* `changeManagement/clientOpts` - Additional options for cm command line client, e.g. JAVA_OPTS.
* `changeManagement/credentialsId` - The id of the credentials to connect to the Solution Manager. The credentials needs to be maintained on Jenkins.
* `changeManagement/endpoint` - The service endpoint, e.g. Solution Manager, ABAP System.
* `changeManagement/git/format` - Specifies what part of the commit is scanned. By default the body of the commit message is scanned.
* `changeManagement/git/from` - The starting point for retrieving the change document id.
* `changeManagement/git/to` - The end point for retrieving the change document id.
* `changeManagement/rfc/developmentClient` - AS ABAP client number. Only for `RFC`.
* `changeManagement/rfc/developmentInstance` - AS ABAP instance number. Only for `RFC`.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `transportRequestId` - The id of the transport request to release.
* `verbose` - Provides additional details. Only for `RFC`.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `changeDocumentId` |  |  |
| `changeManagement/clientOpts` |  | X |
| `changeManagement/credentialsId` |  | X |
| `changeManagement/endpoint` |  | X |
| `changeManagement/git/format` |  | X |
| `changeManagement/git/from` |  | X |
| `changeManagement/git/to` |  | X |
| `changeManagement/rfc/developmentClient` |  | X |
| `changeManagement/rfc/developmentInstance` |  | X |
| `script` |  |  |
| `transportRequestId` |  |  |
| `verbose` |  |  |

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


The step is configured using a customer configuration file provided as
resource in an custom shared library.

```groovy
@Library('piper-lib-os@master') _

// the shared lib containing the additional configuration
// needs to be configured in Jenkins
@Library('foo@master') __

// inside the shared lib denoted by 'foo' the additional configuration file
// needs to be located under 'resources' ('resoures/myConfig.yml')
prepareDefaultValues script: this,
                             customDefaults: 'myConfig.yml'
```

Example content of `'resources/myConfig.yml'` in branch `'master'` of the repository denoted by
`'foo'`:

```yaml
general:
  changeManagement:
    changeDocumentLabel: 'ChangeDocument\s?:'
    cmClientOpts: '-Djavax.net.ssl.trustStore=<path to truststore>'
    credentialsId: 'CM'
    type: 'SOLMAN'
    endpoint: 'https://example.org/cm'
    git:
      from: 'HEAD~1'
      to: 'HEAD'
      format: '%b'
```

The properties configured in section `'general/changeManagement'` are shared between all change managment related steps.

The properties can also be configured on a per-step basis:

```yaml
  [...]
  steps:
    transportRequestRelease:
      changeManagement:
        type: 'SOLMAN'
        endpoint: 'https://example.org/cm'
        [...]
```

The parameters can also be provided when the step is invoked. For examples see below.

## Exceptions

* `IllegalArgumentException`:
  * If the change id is not provided (`SOLMAN` only)
  * If the transport request id is not provided.
* `AbortException`:
  * If the release of the transport request fails.

## Example

```groovy
// SOLMAN
transportRequestRelease script:this,
                        changeDocumentId: '001',
                        transportRequestId: '001',
                        changeManagement: [
                          type: 'SOLMAN'
                          endpoint: 'https://example.org/cm'
                        ]
// CTS
transportRequestRelease script:this,
                        transportRequestId: '001',
                        changeManagement: [
                          type: 'CTS'
                          endpoint: 'https://example.org/cm'
                        ]
```
