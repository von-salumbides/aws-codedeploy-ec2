pipeline {
  agent any 
  options {
    ansiColor("xterm")
  }
  stages {
    stage("Deploy") {
      environment {
        CODEDEPLOY_APP_NAME   = "devops-poc"
        CODEDEPLOY_GROUP_NAME = "devops-poc"
        CODEDEPLOY_S3_BUCKET  = "devops-poc-bucket"
        AWS_ACCOUNT_ID        = "${AWS_ACCOUNT_ID}"
        AWS_ACCOUNT_ROLE      = "${AWS_ACCOUNT_ROLE}"
      }
      steps {
        script {
          try {
            withAWS(roleAccount: AWS_ACCOUNT_ID, role: AWS_ACCOUNT_ROLE) {
              createDeployment(
                s3Bucket: "${CODEDEPLOY_S3_BUCKET}",
                s3Key: "artifacts/${VERSION_TAG}.zip",
                s3BundleType: 'zip', // [Valid values: tar | tgz | zip | YAML | JSON]
                applicationName: "${CODEDEPLOY_APP_NAME}",
                deploymentGroupName: "${CODEDEPLOY_GROUP_NAME}",
                deploymentConfigName: 'CodeDeployDefault.AllAtOnce',
                description: 'codedeploy deployment',
                waitForCompletion: 'true',
                ignoreApplicationStopFailures: 'false',
                fileExistsBehavior: 'OVERWRITE'
              )
            }
          }
            catch(e){
              println(e)
            throw e
          }
        }
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}