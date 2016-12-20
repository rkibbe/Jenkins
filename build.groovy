
job('DSL-codedeploy') {
    scm {
        git('git://github.com:rkibbe/jenkins.git')
		
    }
    triggers {
        scm('H/15 * * * *')
    }
    steps {
        msBuild {
            msBuildInstallation('MSBuild 1.8')
            buildFile('.\\EagleEye.sln')
            args('')
            args('')
            passBuildVariables()
            continueOnBuildFailure()
            unstableIfWarnings()
        }
	configure { Node project -> 
        project / publishers / 'com.amazonaws.codedeploy.AWSCodeDeployPublisher' { 
             s3bucket 'dev-build-artifacts1' 
			 applicationName 'Cerrs.EagleEye'
			 deploymentGroup 'Cerrs.EagleEye'
			 deploymentMethod 'deploy'
			 region 'us-east-1'
			 includes '**'
			 excludes '*.csproj'
			 subdirectory 'EagleEye'
			 awsAccessKey 'AKIAJSJRXSVMYSRKY36Q'
			 awsSecretKey '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'
			 credentials 'awsAccessKey'
			 
         } 
     } 

}
}






