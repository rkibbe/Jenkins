
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
  name('builders')
  steps {
    shell('echo AAA')
  }
  configure {
    it / builders << 'hudson.plugins.xshell.XShellBuilder' {
      commandLine('123')
    }
  }
  steps {
    shell('echo BBB')
  }
  configure {
    it / builders << 'hudson.plugins.xshell.XShellBuilder' {
      commandLine('456')
    }
  }
}


