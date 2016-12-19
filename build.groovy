
job('DSL-codedeploy') {
    scm {
        git('git://github.com:rkibbe/jenkins.git')
		
    }
    triggers {
        scm('H/15 * * * *')
    }
    steps {
        maven('-e clean test')
    }
	configure { Node project -> 
        project / publishers / 'com.amazonaws.codedeploy.AWSCodeDeployPublisher' { 
             s3bucket 'dev-build-artifacts1' 
			 applicationName 'Cerrs.EagleEye'
         } 
     } 

}






