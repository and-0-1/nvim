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
  {
    type = "java",
    request = "attach",
    name = "Attach to template-service",
    hostName = "template-service",
    port = 8802,
    projectName = "template-service",
    processId = "${command:PickJavaProcess}",
    cwd = "${workspaceFolder}/template-service",
  },
  {
    type = "java",
    request = "attach",
    name = "Attach to profile-service",
    hostName = "profile-service",
    port = 5002,
    projectName = "template-service",
    processId = "${command:PickJavaProcess}",
    cwd = "${workspaceFolder}/profile-service",
  },
}
