
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
}

job {
  name "Job with HipChat"
  
  configure { project ->
      
    project / 'properties' << 'jenkins.plugins.hipchat.HipChatNotifier_-HipChatJobProperty' {
      room ''
      startNotification false
    }

    project / 'publishers' << 'jenkins.plugins.hipchat.HipChatNotifier' {
      jenkinsUrl 'http://jenkins/'
      authToken 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      room '76124'
    }
  }
}




