# tmsUpload

## Description

This step allows you to upload an MTA file (multi-target application archive) into a TMS (SAP Cloud Platform Transport Management Service) landscape for further TMS-controlled distribution through a TMS-configured landscape.
TMS lets you manage transports between SAP Cloud Platform accounts in Neo and Cloud Foundry, such as from DEV to TEST and PROD accounts.
For more information, see [official documentation of Transport Management Service](https://help.sap.com/viewer/p/TRANSPORT_MANAGEMENT_SERVICE)

!!! note "Prerequisites"
    * You have subscribed to and set up TMS, as described in [Setup and Configuration of SAP Cloud Platform Transport Management](https://help.sap.com/viewer/7f7160ec0d8546c6b3eab72fb5ad6fd8/Cloud/en-US/66fd7283c62f48adb23c56fb48c84a60.html), which includes the configuration of a node to be used for uploading an MTA file.
    * A corresponding service key has been created, as described in [Set Up the Environment to Transport Content Archives directly in an Application](https://help.sap.com/viewer/7f7160ec0d8546c6b3eab72fb5ad6fd8/Cloud/en-US/8d9490792ed14f1bbf8a6ac08a6bca64.html). This service key (JSON) must be stored as a secret text within the Jenkins secure store.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `credentialsId` | yes |  |  |
| `customDescription` | no |  |  |
| `mtaPath` | yes |  |  |
| `nodeName` | yes |  |  |
| `script` | yes |  |  |
| `stashContent` | no | `[buildResult]` |  |
| `verbose` | no |  | `true`, `false` |

* `credentialsId` - Credentials to be used for the file and node uploads to the Transport Management Service.
* `customDescription` - Can be used as the description of a transport request. Will overwrite the default. (Default: Corresponding Git Commit-ID)
* `mtaPath` - Defines the path to *.mtar for the upload to the Transport Management Service.
* `nodeName` - Defines the name of the node to which the *.mtar file should be uploaded.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `stashContent` - If specific stashes should be considered, their names need to be passed via the parameter `stashContent`.
* `verbose` - Print more detailed information into the log.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `credentialsId` |  | X |
| `customDescription` |  | X |
| `mtaPath` |  | X |
| `nodeName` |  | X |
| `script` |  |  |
| `stashContent` |  | X |
| `verbose` | X | X |

## Dependencies

The step depends on the following Jenkins plugins

* [credentials-binding](https://plugins.jenkins.io/credentials-binding)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)

Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.

