# multicloudDeploy

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `cfTargets` | no |  |  |
| `enableZeroDowntimeDeployment` | no |  |  |
| `neoTargets` | no |  |  |
| `script` | yes |  |  |
| `source` | yes |  |  |
| `stage` | no |  |  |

* `cfTargets` - Defines the targets to deploy on cloudFoundry.
* `enableZeroDowntimeDeployment` - Defines the deployment type.
* `neoTargets` - Defines the targets to deploy on neo.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `source` - The source file to deploy to the SAP Cloud Platform.
* `stage` - The stage name. If the stage name is not provided, it will be taken from the environment variable 'STAGE_NAME'.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `cfTargets` | X |  |
| `enableZeroDowntimeDeployment` |  |  |
| `neoTargets` | X |  |
| `script` |  |  |
| `source` |  |  |
| `stage` |  |  |

## Dependencies

The step depends on the following Jenkins plugins

* [credentials-binding](https://plugins.jenkins.io/credentials-binding)
* [lockable-resources](https://plugins.jenkins.io/lockable-resources)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)
* [workflow-durable-task-step](https://plugins.jenkins.io/workflow-durable-task-step)

Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.


## Examples

```groovy
multicloudDeploy(
    script: script,
    cfTargets: [[apiEndpoint: 'https://test.server.com', appName:'cfAppName', credentialsId: 'cfCredentialsId', manifest: 'cfManifest', org: 'cfOrg', space: 'cfSpace']],
    neoTargets: [[credentialsId: 'my-credentials-id', host: hana.example.org, account: 'trialuser1']],
    enableZeroDowntimeDeployment: 'true'
)
```
