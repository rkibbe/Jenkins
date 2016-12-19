
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
  name 'builders'
  jdk('JDK-17')

  steps {
    configure { node ->
      node / builders {
        'hudson.plugins.xshell.XShellBuilder'(plugin: 'xshell@0.9') {
            commandLine('run-me-as-the-first-build-step')
            executeFromWorkingDir('true')
        }
      }        
    }
}
}

