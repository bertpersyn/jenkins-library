# whitesourceExecuteScan

## Description

BETA

With this step [WhiteSource](https://www.whitesourcesoftware.com) security and license compliance scans can be executed and assessed.

WhiteSource is a Software as a Service offering based on a so called unified agent that locally determines the dependency
tree of a node.js, Java, Python, Ruby, or Scala based solution and sends it to the WhiteSource server for a policy based license compliance
check and additional Free and Open Source Software Publicly Known Vulnerabilities detection.

!!! note "Docker Images"
    The underlying Docker images are public and specific to the solution's programming language(s) and therefore may have to be exchanged
    to fit to and support the relevant scenario. The default Python environment used is i.e. Python 3 based.

!!! warn "Restrictions"
    Currently the step does contain hardened scan configurations for `scanType` `'pip'` and `'go'`. Other environments are still being elaborated,
    so please thoroughly check your results and do not take them for granted by default.
    Also not all environments have been thoroughly tested already therefore you might need to tweak around with the default containers used or
    create your own ones to adequately support your scenario. To do so please modify `dockerImage` and `dockerWorkspace` parameters.
    The step expects an environment containing the programming language related compiler/interpreter as well as the related build tool. For a list
    of the supported build tools per environment please refer to the [WhiteSource Unified Agent Documentation](https://whitesource.atlassian.net/wiki/spaces/WD/pages/33718339/Unified+Agent).

## Prerequisites

Your company has registered an account with WhiteSource and you have enabled the use of so called `User Keys` to manage
access to your organization in WhiteSource via dedicated privileges. Scanning your products without adequate user level
access protection imposed on the WhiteSource backend would simply allow access based on the organization token.

## Parameters

| name | mandatory | default | possible values |
|------|-----------|---------|-----------------|
| `agentDownloadUrl` | no | `https://github.com/whitesource/unified-agent-distribution/releases/latest/download/${config.agentFileName}` |  |
| `agentFileName` | no | `wss-unified-agent.jar` |  |
| `agentParameters` | no | `` |  |
| `buildDescriptorExcludeList` | no | `[]` |  |
| `buildDescriptorFile` | no | scanType=`golang`:`./Gopkg.toml`<br />scanType=`maven`:`./pom.xml`<br />scanType=`mta`:`<empty>`<br />scanType=`npm`:`./package.json`<br />scanType=`pip`:`./setup.py`<br />scanType=`sbt`:`./build.sbt`<br />scanType=`dub`:`./dub.json` |  |
| `configFilePath` | no | `./wss-unified-agent.config` |  |
| `createProductFromPipeline` | no | `true` |  |
| `cvssSeverityLimit` | no | `-1` | `-1` to switch failing off, any `positive integer between 0 and 10` to fail on issues with the specified limit or above |
| `dockerImage` | no | scanType=`golang`:`golang:1.12-stretch`<br />scanType=`maven`:`maven:3.5-jdk-8`<br />scanType=`mta`:`<empty>`<br />scanType=`npm`:`node:8-stretch`<br />scanType=`pip`:`python:3.7.2-stretch`<br />scanType=`sbt`:`hseeberger/scala-sbt:8u181_2.12.8_1.2.8`<br />scanType=`dub`:`buildpack-deps:stretch-curl` |  |
| `dockerWorkspace` | no | scanType=`golang`:`/home/dep`<br />scanType=`maven`:`/home/java`<br />scanType=`mta`:`<empty>`<br />scanType=`npm`:`/home/node`<br />scanType=`pip`:`/home/python`<br />scanType=`sbt`:`/home/scala`<br />scanType=`dub`:`/home/dub` |  |
| `emailAddressesOfInitialProductAdmins` | no | `[]` |  |
| `installCommand` | no |  |  |
| `licensingVulnerabilities` | no | `true` | `true`, `false` |
| `parallelLimit` | no | `15` |  |
| `reporting` | no | `true` | `true`, `false` |
| `scanType` | no |  | `golang`, `maven`, `mta`, `npm`, `pip`, `sbt`, `dub` |
| `script` | yes |  |  |
| `securityVulnerabilities` | no | `true` | `true`, `false` |
| `stashContent` | no | scanType=`golang`:`[buildDescriptor, opensourceConfiguration, checkmarx]`<br />scanType=`maven`:`[buildDescriptor, opensourceConfiguration]`<br />scanType=`mta`:`[buildDescriptor, opensourceConfiguration]`<br />scanType=`npm`:`[buildDescriptor, opensourceConfiguration]`<br />scanType=`pip`:`[buildDescriptor, opensourceConfiguration]`<br />scanType=`sbt`:`[buildDescriptor, opensourceConfiguration]`<br />scanType=`dub`:`[buildDescriptor, checkmarx]` |  |
| `timeout` | no | `0` |  |
| `verbose` | no | `false` | `true`, `false` |
| `vulnerabilityReportFileName` | no | `piper_whitesource_vulnerability_report` |  |
| `vulnerabilityReportTitle` | no | `WhiteSource Security Vulnerability Report` |  |
| `whitesource/jreDownloadUrl` | no |  |  |
| `whitesource/orgAdminUserTokenCredentialsId` | no |  |  |
| `whitesource/orgToken` | yes |  |  |
| `whitesource/productName` | yes |  |  |
| `whitesource/productToken` | no |  |  |
| `whitesource/productVersion` | no |  |  |
| `whitesource/projectNames` | no |  |  |
| `whitesource/serviceUrl` | no | `https://saas.whitesourcesoftware.com/api` |  |
| `whitesource/userTokenCredentialsId` | yes |  |  |

* `agentDownloadUrl` - URL used to download the latest version of the WhiteSource Unified Agent.
* `agentFileName` - Locally used name for the Unified Agent jar file after download.
* `agentParameters` - Additional parameters passed to the Unified Agent command line.
* `buildDescriptorExcludeList` - List of build descriptors and therefore modules to exclude from the scan and assessment activities.
* `buildDescriptorFile` - Explicit path to the build descriptor file.
* `configFilePath` - Explicit path to the WhiteSource Unified Agent configuration file.
* `createProductFromPipeline` - Whether to create the related WhiteSource product on the fly based on the supplied pipeline configuration.
* `cvssSeverityLimit` - Limit of tollerable CVSS v3 score upon assessment and in consequence fails the build, defaults to  `-1`.
* `dockerImage` - Docker image to be used for scanning.
* `dockerWorkspace` - Docker workspace to be used for scanning.
* `emailAddressesOfInitialProductAdmins` - The list of email addresses to assign as product admins for newly created WhiteSource products.
* `installCommand` - Install command that can be used to populate the default docker image for some scenarios.
* `licensingVulnerabilities` - Whether license compliance is considered and reported as part of the assessment.
* `parallelLimit` - Limit of parallel jobs being run at once in case of `scanType: 'mta'` based scenarios, defaults to `15`.
* `reporting` - Whether assessment is being done at all, defaults to `true`.
* `scanType` - Type of development stack used to implement the solution.
* `script` - The common script environment of the Jenkinsfile running. Typically the reference to the script calling the pipeline step is provided with the `this` parameter, as in `script: this`. This allows the function to access the `commonPipelineEnvironment` for retrieving, e.g. configuration parameters.
* `securityVulnerabilities` - Whether security compliance is considered and reported as part of the assessment.
* `stashContent` - List of stashes to be unstashed into the workspace before performing the scan.
* `timeout` - Timeout in seconds until a HTTP call is forcefully terminated.
* `verbose` - Whether verbose output should be produced.
* `vulnerabilityReportFileName` - Name of the file the vulnerability report is written to.
* `vulnerabilityReportTitle` - Title of vulnerability report written during the assessment phase.
* `whitesource/jreDownloadUrl` - URL used for downloading the Java Runtime Environment (JRE) required to run the WhiteSource Unified Agent.
* `whitesource/orgAdminUserTokenCredentialsId` - Jenkins credentials ID referring to the organization admin's token.
* `whitesource/orgToken` - WhiteSource token identifying your organization.
* `whitesource/productName` - Name of the WhiteSource product to be created and used for results aggregation.
* `whitesource/productToken` - Token of the WhiteSource product to be created and used for results aggregation, usually determined automatically.
* `whitesource/productVersion` - Version of the WhiteSource product to be created and used for results aggregation, usually determined automatically.
* `whitesource/projectNames` - List of WhiteSource projects to be included in the assessment part of the step, usually determined automatically.
* `whitesource/serviceUrl` - URL to the WhiteSource server API used for communication, defaults to `https://saas.whitesourcesoftware.com/api`.
* `whitesource/userTokenCredentialsId` - Jenkins credentials ID referring to the product admin's token.

## Step configuration

We recommend to define values of step parameters via [config.yml file](../configuration.md).

In following sections of the config.yml the configuration is possible:

| parameter | general | step/stage |
|-----------|---------|------------|
| `agentDownloadUrl` |  | X |
| `agentFileName` |  | X |
| `agentParameters` |  | X |
| `buildDescriptorExcludeList` |  | X |
| `buildDescriptorFile` |  | X |
| `configFilePath` |  | X |
| `createProductFromPipeline` |  | X |
| `cvssSeverityLimit` |  | X |
| `dockerImage` |  | X |
| `dockerWorkspace` |  | X |
| `emailAddressesOfInitialProductAdmins` |  | X |
| `installCommand` |  | X |
| `licensingVulnerabilities` |  | X |
| `parallelLimit` |  | X |
| `reporting` |  | X |
| `scanType` | X | X |
| `script` |  |  |
| `securityVulnerabilities` |  | X |
| `stashContent` |  | X |
| `timeout` |  | X |
| `verbose` | X | X |
| `vulnerabilityReportFileName` |  | X |
| `vulnerabilityReportTitle` |  | X |
| `whitesource/jreDownloadUrl` | X | X |
| `whitesource/orgAdminUserTokenCredentialsId` | X | X |
| `whitesource/orgToken` | X | X |
| `whitesource/productName` | X | X |
| `whitesource/productToken` | X | X |
| `whitesource/productVersion` | X | X |
| `whitesource/projectNames` | X | X |
| `whitesource/serviceUrl` | X | X |
| `whitesource/userTokenCredentialsId` | X | X |

## Dependencies

The step depends on the following Jenkins plugins

* [credentials-binding](https://plugins.jenkins.io/credentials-binding)
* [docker](https://plugins.jenkins.io/docker)
* [kubernetes](https://plugins.jenkins.io/kubernetes)
* [pipeline-utility-steps](https://plugins.jenkins.io/pipeline-utility-steps)
* [workflow-basic-steps](https://plugins.jenkins.io/workflow-basic-steps)
* [workflow-cps](https://plugins.jenkins.io/workflow-cps)
* [workflow-cps-global-lib](https://plugins.jenkins.io/workflow-cps-global-lib)
* [workflow-durable-task-step](https://plugins.jenkins.io/workflow-durable-task-step)

The kubernetes plugin is only used if running in a kubernetes environment.
Transitive dependencies are omitted.

The list might be incomplete.

Consider using the [ppiper/jenkins-master](https://cloud.docker.com/u/ppiper/repository/docker/ppiper/jenkins-master)
docker image. This images comes with preinstalled plugins.


## Exceptions

None

## Examples

```groovy
whitesourceExecuteScan script: this, scanType: 'pip', productName: 'My Whitesource Product', userTokenCredentialsId: 'companyAdminToken', orgAdminUserTokenCredentialsId: 'orgAdminToken', orgToken: 'myWhitesourceOrganizationToken'
```
