
job('DSL-Test') {
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
        project / publishers / 'com.cloudbees.jenkins.GitHubCommitNotifier' { 
             resultOnFailure 'FAILURE' 
         } 
     } 

}






