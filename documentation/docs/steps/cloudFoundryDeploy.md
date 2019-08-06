# cloudFoundryDeploy

## Description

Deploys an application to a test or production space within Cloud Foundry.
Deployment can be done

* in a standard way
* in a zero downtime manner (using a [blue-green deployment approach](https://martinfowler.com/bliki/BlueGreenDeployment.html))

!!! note "Deployment supports multiple deployment tools"
    Currently the following are supported:

    * Standard `cf push` and [Bluemix blue-green plugin](https://github.com/bluemixgaragelondon/cf-blue-green-deploy#how-to-use)
    * [MTA CF CLI Plugin](https://github.com/cloudfoundry-incubator/multiapps-cli-plugin)

!!! note
Due to [an incompatible change](https://github.com/cloudfoundry/cli/issues/1445) in the Cloud Foundry CLI, multiple buildpacks are not supported by this step.
If your `application` contains a list of `buildpacks` instead a single `buildpack`, this will be automatically re-written by the step when blue-green deployment is used.

!!! note
Cloud Foundry supports the deployment of multiple applications using a single manifest file.
This option is supported with Piper.

In this case define `appName: ''` since the app name for the individual applications have to be defined via the manifest.
You can find details in the [Cloud Foundry Documentation](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html#multi-apps)

## Prerequisites

* Cloud Foundry organization, space and deployment user are available
* Credentials for deployment have been configured in Jenkins with a dedicated Id

    ![Jenkins credentials configuration](../images/cf_credentials.png)

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `cloudFoundry/apiEndpoint` | no | `https://api.cf.eu10.hana.ondemand.com` |  |
| `cloudFoundry/appName` | no |  |  |
| `cloudFoundry/credentialsId` | yes |  |  |
| `cloudFoundry/manifest` | no |  |  |
| `cloudFoundry/org` | yes |  |  |
| `cloudFoundry/space` | yes |  |  |
| `deployTool` | no | `cf_native` | 'cf_native', 'mtaDeployPlugin' |
| `deployType` | no | `standard` | 'standard', 'blue-green' |
| `dockerImage` | no | deployTool=`cf_native`:`s4sdk/docker-cf-cli`<br />deployTool=`mtaDeployPlugin`:`s4sdk/docker-cf-cli` |  |
| `dockerWorkspace` | no | deployTool=`cf_native`:`/home/piper`<br />deployTool=`mtaDeployPlugin`:`/home/piper` |  |
| `keepOldInstance` | no | `false` | true, false |
| `mtaDeployParameters` | no | `-f` |  |
| `mtaExtensionDescriptor` | no | `` |  |
| `mtaPath` | no | `` |  |
| `script` | yes |  |  |
| `smokeTestScript` | no | `blueGreenCheckScript.sh` |  |
| `smokeTestStatusCode` | no | `200` |  |
| `stashContent` | no | `[deployDescriptor, pipelineConfigAndTests]` |  |

* `cloudFoundry/apiEndpoint` - Cloud Foundry API endpoint.
* `cloudFoundry/appName` - Defines the name of the application to be deployed to the Cloud Foundry space.
* `cloudFoundry/credentialsId` - Credentials to be used for deployment.
* `cloudFoundry/manifest` - Defines the manifest to be used for deployment to Cloud Foundry.
* `cloudFoundry/org` - Cloud Foundry target organization.
* `cloudFoundry/space` - Cloud Foundry target space.
* `deployTool` - Defines the tool which should be used for deployment.
* `deployType` - Defines the type of deployment, either `standard` deployment which results in a system downtime or a zero-downtime `blue-green` deployment.
* `dockerImage` - Name of the docker image that should be used. If empty, Docker is not used and the command is executed directly on the Jenkins system.
* `dockerWorkspace` - Kubernetes only: Specifies a dedicated user home directory for the container which will be passed as value for environment variable `HOME`.
* `keepOldInstance` - In case of a `blue-green` deployment the old instance will be deleted by default. If this option is set to true the old instance will remain stopped in the Cloud Foundry space.
* `mtaDeployParameters` - Defines additional parameters passed to mta for deployment with the mtaDeployPlugin.
* `mtaExtensionDescriptor` - Defines additional extension descriptor file for deployment with the mtaDeployPlugin.
* `mtaPath` - Defines the path to *.mtar for deployment with the mtaDeployPlugin.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `smokeTestScript` - Allows to specify a script which performs a check during blue-green deployment. The script gets the FQDN as parameter and returns `exit code 0` in case check returned `smokeTestStatusCode`. More details can be found [here](https://github.com/bluemixgaragelondon/cf-blue-green-deploy#how-to-use) <br /> Currently this option is only considered for deployTool `cf_native`.
* `smokeTestStatusCode` - Expected status code returned by the check.
* `stashContent` - Specific stashes that should be considered for the step execution.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `cloudFoundry/apiEndpoint` |  | X |
| `cloudFoundry/appName` |  | X |
| `cloudFoundry/credentialsId` |  | X |
| `cloudFoundry/manifest` |  | X |
| `cloudFoundry/org` |  | X |
| `cloudFoundry/space` |  | X |
| `deployTool` |  | X |
| `deployType` |  | X |
| `dockerImage` |  | X |
| `dockerWorkspace` |  | X |
| `keepOldInstance` |  | X |
| `mtaDeployParameters` |  | X |
| `mtaExtensionDescriptor` |  | X |
| `mtaPath` |  | X |
| `script` |  |  |
| `smokeTestScript` |  | X |
| `smokeTestStatusCode` |  | X |
| `stashContent` |  | X |

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


## Example

```groovy
cloudFoundryDeploy(
    script: script,
    deployType: 'blue-green',
    cloudFoundry: [apiEndpoint: 'https://test.server.com', appName:'cfAppName', credentialsId: 'cfCredentialsId', manifest: 'cfManifest', org: 'cfOrg', space: 'cfSpace'],
    deployTool: 'cf_native'
)
```
