# terraform-provider-gitfile

A [Terraform](http://terraform.io) plugin to allow you to do custom templating
from within terraform.

## Example use:

    resource "utils_template" "zk_discovery_yaml" {
    template = <<EOT
    ---
    zookeeper_servers:
    {{range $index, $ip := split .ips ","}}  {{add $index 1}}: {{$ip}}
    {{end}}
    EOT
        vars {
            ips = "${join(",", aws_instance.zk.*.private_ip)}"
        }
    }

## Further uses

Combine this with [terraform-provider-gitfile](https://github.com/Yelp/terraform-provider-gitfile)
to allow terraform to commit the file you've templated to git.

We use this with [per-module hiera data](https://github.com/ripienaar/puppet-module-data) in puppet
to generate things like static YAML maps of hiera data for things like zookeeper discovery.

Our [ENC](https://docs.puppetlabs.com/guides/external_nodes.html) to configure the servers is
driven by the AWS tags terraform apply, but then clients need static lists of the server addresses
in config (which is also usually dropped by puppet), so we just commit the state from terraform
into our puppet repository!

# License

Apache2 - See the included LICENSE file for more details.

