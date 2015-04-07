package main

import (
	"github.com/hashicorp/terraform/plugin"
	"terraform-provider-utils/utils"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: utils.Provider,
	})
}
