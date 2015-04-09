package main

import (
	"github.com/Yelp/terraform-provider-utils/utils"
	"github.com/hashicorp/terraform/plugin"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: utils.Provider,
	})
}
