local dap = require "dap"

dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Attach to mailer",
    hostName = "mailer",
    port = 1044,
    projectName = "mailer",
    processId = "${command:PickJavaProcess}",
    cwd = "${workspaceFolder}/mailer",
  },
}
