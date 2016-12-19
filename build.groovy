
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
            buildFile('dir1/build.proj')
            args('check')
            args('another')
            passBuildVariables()
            continueOnBuildFailure()
            unstableIfWarnings()
        }
	configure { Node project -> 
        project / publishers / 'com.amazonaws.codedeploy.AWSCodeDeployPublisher' { 
             s3bucket 'dev-build-artifacts1' 
			 applicationName 'Cerrs.EagleEye'
         } 
     } 

}
}






