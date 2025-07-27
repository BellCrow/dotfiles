local lspconfig = require("lspconfig")
lspconfig.yamlls.setup({
	settings = {
		yaml = {
			schemas = {
				-- makes sure to always use the kubernetes schmema if the file names end with ".k8s.yaml"
				kubernetes = "/*.k8s.{yaml, yml}",
				["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "gitlab-ci.{yaml, yml}"

			},
		},
	},
})
