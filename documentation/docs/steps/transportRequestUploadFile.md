# transportRequestUploadFile

## Description

Uploads a file to a Transport Request. 

## Prerequisites

* **[Change Management Client 2.0.0 or compatible version](http://central.maven.org/maven2/com/sap/devops/cmclient/dist.cli/)** - available for download on Maven Central.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `abapPackage` | yes |  |  |
| `acceptUnixStyleLineEndings` | no | `true` |  |
| `applicationDescription` | yes |  |  |
| `applicationId` | yes |  |  |
| `applicationName` | yes |  |  |
| `applicationUrl` | yes |  |  |
| `changeDocumentId` | yes |  |  |
| `changeManagement/changeDocumentLabel` | no | `ChangeDocument\s?:` | regex pattern |
| `changeManagement/changeManagement/transportRequestLabel` | no |  |  |
| `changeManagement/clientOpts` | no | `` |  |
| `changeManagement/credentialsId` | no | `CM` |  |
| `changeManagement/endpoint` | yes |  |  |
| `changeManagement/git/format` | no | `%b` | see `git log --help` |
| `changeManagement/git/from` | no | `origin/master` |  |
| `changeManagement/git/to` | no | `HEAD` |  |
| `changeManagement/rfc/developmentClient` | yes |  |  |
| `changeManagement/rfc/developmentInstance` | yes |  |  |
| `changeManagement/rfc/docker/envVars` | no | `[:]` |  |
| `changeManagement/rfc/docker/image` | no | `rfc` |  |
| `changeManagement/rfc/docker/options` | no | `[]` |  |
| `changeManagement/rfc/docker/pullImage` | no | `true` |  |
| `changeManagement/type` | no | `NONE` | `SOLMAN`, `CTS`, `RFC` |
| `codePage` | no | `UTF-8` |  |
| `failOnWarning` | no | `true` |  |
| `filePath` | yes |  |  |
| `script` | yes |  |  |
| `transportRequestId` | yes |  |  |
| `verbose` | no | `false` |  |

* `abapPackage` - The ABAP package name of your application.
* `acceptUnixStyleLineEndings` - 
* `applicationDescription` - 
* `applicationId` - The id of the application. Only for `SOLMAN`.
* `applicationName` - 
* `applicationUrl` - The URL where to find the UI5 package to upload to the transport request.  Only for `RFC`.
* `changeDocumentId` - The id of the change document to that the transport request is bound to. Typically this value is provided via commit message in the commit history. Only for `SOLMAN`.
* `changeManagement/changeDocumentLabel` - A pattern used for identifying lines holding the change document id.
* `changeManagement/changeManagement/transportRequestLabel` - A pattern used for identifying lines holding the transport request id.
* `changeManagement/clientOpts` - Additional options for cm command line client, e.g. JAVA_OPTS.
* `changeManagement/credentialsId` - The id of the credentials to connect to the Solution Manager. The credentials needs to be maintained on Jenkins.
* `changeManagement/endpoint` - The service endpoint, e.g. Solution Manager, ABAP System.
* `changeManagement/git/format` - Specifies what part of the commit is scanned. By default the body of the commit message is scanned.
* `changeManagement/git/from` - The starting point for retrieving the change document id.
* `changeManagement/git/to` - The end point for retrieving the change document id.
* `changeManagement/rfc/developmentClient` - AS ABAP client number. Only for `RFC`.
* `changeManagement/rfc/developmentInstance` - AS ABAP instance number. Only for `RFC`.
* `changeManagement/rfc/docker/envVars` - 
* `changeManagement/rfc/docker/image` - 
* `changeManagement/rfc/docker/options` - 
* `changeManagement/rfc/docker/pullImage` - 
* `changeManagement/type` - Defines where the transport request is created, e.g. SAP Solution Manager, ABAP System.
* `codePage` - The code page of your ABAP system. E.g. UTF-8.
* `failOnWarning` - 
* `filePath` - The path of the file to upload.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `transportRequestId` - The id of the transport request to upload the file.
* `verbose` - Provides additional details. Only for `RFC`.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `abapPackage` |  | X |
| `acceptUnixStyleLineEndings` |  | X |
| `applicationDescription` |  | X |
| `applicationId` |  | X |
| `applicationName` |  | X |
| `applicationUrl` |  | X |
| `changeDocumentId` |  |  |
| `changeManagement/changeDocumentLabel` | X | X |
| `changeManagement/changeManagement/transportRequestLabel` | X | X |
| `changeManagement/clientOpts` | X | X |
| `changeManagement/credentialsId` | X | X |
| `changeManagement/endpoint` | X | X |
| `changeManagement/git/format` | X | X |
| `changeManagement/git/from` | X | X |
| `changeManagement/git/to` | X | X |
| `changeManagement/rfc/developmentClient` | X | X |
| `changeManagement/rfc/developmentInstance` | X | X |
| `changeManagement/rfc/docker/envVars` | X | X |
| `changeManagement/rfc/docker/image` | X | X |
| `changeManagement/rfc/docker/options` | X | X |
| `changeManagement/rfc/docker/pullImage` | X | X |
| `changeManagement/type` | X | X |
| `codePage` |  | X |
| `failOnWarning` |  |  |
| `filePath` |  | X |
| `script` |  |  |
| `transportRequestId` |  |  |
| `verbose` |  | X |

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
    transportRequestUploadFile:
      applicationId: 'FOO'
      changeManagement:
        type: 'SOLMAN'
        endpoint: 'https://example.org/cm'
        [...]
```

The parameters can also be provided when the step is invoked. For examples see below.

## Exceptions

* `IllegalArgumentException`:
  * If the change id is not provided (`SOLMAN` only).
  * If the transport request id is not provided.
  * If the application id is not provided (`SOLMAN` only).
  * If the file path is not provided.
* `AbortException`:
  * If the upload fails.

## Example

```groovy
// SOLMAN
transportRequestUploadFile(
  script: this,
  changeDocumentId: '001',   // typically provided via git commit history
  transportRequestId: '001', // typically provided via git commit history
  applicationId: '001',
  filePath: '/path',
  changeManagement: [
    type: 'SOLMAN'
    endpoint: 'https://example.org/cm'
  ]
)
// CTS
transportRequestUploadFile(
  script: this,
  transportRequestId: '001', // typically provided via git commit history
  filePath: '/path',
  changeManagement: [
    type: 'CTS'
    endpoint: 'https://example.org/cm'
  ]
)
```
