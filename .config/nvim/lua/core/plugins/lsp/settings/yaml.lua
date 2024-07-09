return {
  yaml = {
    keyOrdering = false,
    format = { enabled = false },
    validate = false,
    completion = true,
    hover = true,

    -- disable built-in schemaStore 
    schemaStore = {
      enable = false,
      url = "",
    },

    schemas = require("schemastore").yaml.schemas(),
  },

  redhat = {
    telemetry = {
      enabled = false,
    },
  },
}
