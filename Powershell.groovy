job('example') {
  steps {
    powerShell('...')
  }
  publishers {
    archiveXUnit {
      msTest {
        pattern('path/to/test/results')
      }
    }
  }
}
