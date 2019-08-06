# neoDeploy

## Description

Deploys an Application to SAP Cloud Platform (SAP CP) using the SAP Cloud Platform Console Client (Neo Java Web SDK).

## Prerequisites

* **SAP CP account** - the account to where the application is deployed.
* **SAP CP user for deployment** - a user with deployment permissions in the given account.
* **Jenkins credentials for deployment** - must be configured in Jenkins credentials with a dedicated Id.

![Jenkins credentials configuration](../images/neo_credentials.png)

* **Neo Java Web SDK 3.39.10 or compatible version** - can be downloaded from [Maven Central](http://central.maven.org/maven2/com/sap/cloud/neo-java-web-sdk/). This step is capable of triggering the neo deploy tool provided inside a docker image. We provide docker image `ppiper/neo-cli`. `neo.sh` needs to be contained in path, e.g by adding a symbolic link to `/usr/local/bin`.

* **Java 8 or compatible version** - needed by the *Neo-Java-Web-SDK*. Java environment needs to be properly configured (JAVA_HOME, java exectutable contained in path).

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `deployMode` | no | `mta` | 'mta', 'warParams', 'warPropertiesFile' |
| `dockerEnvVars` | no |  |  |
| `dockerImage` | no | `s4sdk/docker-neo-cli` |  |
| `dockerOptions` | no |  |  |
| `extensions` | no | `[]` |  |
| `neo/account` | for deployMode=warParams |  |  |
| `neo/application` | for deployMode=warParams |  |  |
| `neo/credentialsId` | no | `CI_CREDENTIALS_ID` |  |
| `neo/environment` | no |  |  |
| `neo/host` | for deployMode=warParams |  |  |
| `neo/propertiesFile` | for deployMode=warPropertiesFile |  |  |
| `neo/runtime` | for deployMode=warParams |  |  |
| `neo/runtimeVersion` | for deployMode=warParams |  |  |
| `neo/size` | no | `lite` |  |
| `neo/vmArguments` | no |  |  |
| `script` | yes |  |  |
| `source` | yes |  |  |
| `warAction` | no | `deploy` | 'deploy', 'rolling-update' |

* `deployMode` - The deployment mode which should be used. Available options are: *`'mta'` - default, *`'warParams'` - deploying WAR file and passing all the deployment parameters via the function call, *`'warPropertiesFile'` - deploying WAR file and putting all the deployment parameters in a .properties file.
* `dockerEnvVars` - Environment variables to set in the container, e.g. [http_proxy: 'proxy:8080'].
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used and the command is executed directly on the Jenkins system.
* `dockerOptions` - Docker options to be set when starting the container (List or String).
* `extensions` - Extension files. Provided to the neo command via parameter `--extensions` (`-e`). Only valid for deploy mode `mta`.
* `neo/account` - The SAP Cloud Platform account to deploy to.
* `neo/application` - Name of the application you want to manage, configure, or deploy.
* `neo/credentialsId` - The Jenkins credentials containing user and password used for SAP CP deployment.
* `neo/environment` - Map of environment variables in the form of KEY: VALUE.
* `neo/host` - The SAP Cloud Platform host to deploy to.
* `neo/propertiesFile` - The path to the .properties file in which all necessary deployment properties for the application are defined.
* `neo/runtime` - Name of SAP Cloud Platform application runtime.
* `neo/runtimeVersion` - Version of SAP Cloud Platform application runtime.
* `neo/size` - Compute unit (VM) size. Acceptable values: lite, pro, prem, prem-plus.
* `neo/vmArguments` - String of VM arguments passed to the JVM.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `source` - The path to the archive for deployment to SAP CP. If not provided `mtarFilePath` from commom pipeline environment is used instead.
* `warAction` - Action mode when using WAR file mode. Available options are `deploy` (default) and `rolling-update` which performs update of an application without downtime in one go.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `deployMode` |  |  |
| `dockerEnvVars` |  | X |
| `dockerImage` |  | X |
| `dockerOptions` |  | X |
| `extensions` |  | X |
| `neo/account` | X | X |
| `neo/application` | X | X |
| `neo/credentialsId` | X | X |
| `neo/environment` | X | X |
| `neo/host` | X | X |
| `neo/propertiesFile` | X | X |
| `neo/runtime` | X | X |
| `neo/runtimeVersion` | X | X |
| `neo/size` | X | X |
| `neo/vmArguments` | X | X |
| `script` |  |  |
| `source` |  | X |
| `warAction` |  |  |

## Dependencies

The step depends on the following Jenkins plugins

* [credentials-binding](https://plugins.jenkins.io/credentials-binding)
* [docker](https://plugins.jenkins.io/docker)
* [kubernetes](https://plugins.jenkins.io/kubernetes)
* [lockable-resources](https://plugins.jenkins.io/lockable-resources)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)
* [workflow-durable-task-step](https://plugins.jenkins.io/workflow-durable-task-step)

The kubernetes plugin is only used if running in a kubernetes environment.
Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.


## Side effects

none

## Exceptions

* `Exception`:
    * If `source` is not provided.
    * If `propertiesFile` is not provided (when using `'WAR_PROPERTIESFILE'` deployment mode).
    * If `application` is not provided (when using `'WAR_PARAMS'` deployment mode).
    * If `runtime` is not provided (when using `'WAR_PARAMS'` deployment mode).
    * If `runtimeVersion` is not provided (when using `'WAR_PARAMS'` deployment mode).
* `AbortException`:
    * If neo-java-web-sdk is not installed, or `neoHome`is wrong.
* `CredentialNotFoundException`:
    * If the credentials cannot be resolved.

## Example

```groovy
neoDeploy script: this, source: 'path/to/archiveFile.mtar', neo: [credentialsId: 'my-credentials-id', host: hana.example.org]
```

Example configuration:

```yaml
steps:
  <...>
  neoDeploy:
    deployMode: mta
    neo:
      account: <myDeployAccount>
      host: hana.example.org
```
