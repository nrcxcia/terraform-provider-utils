# terraform-provider-utils

A [Terraform](http://terraform.io) plugin to allow you to do custom templating
(using the Go [text/template](http://golang.org/pkg/text/template/) library
in Terraform.

We [add a few simple functions](http://golang.org/pkg/text/template/#FuncMap) to the defaults:

  * add $variable count - Adds the count to the variable when executed
  * split .argument "X" - Takes the argument and splits it by the second parameter

## Example:

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

and then elsewhere:

    "${utils_template.zk_discovery_yaml.out}"

## Resources

### utils_template

Inputs:

  - template - The template text.
  - vars {} - Variables to pass to the template itself

Outputs:

  - out - The rendered template output


## Further uses

Combining this provider with
[terraform-provider-gitfile](https://github.com/Yelp/terraform-provider-gitfile)
allows terraform to commit the file you've templated to git - which can
be useful for generating YAML or INI type config files for consumption
by other systems (for example puppet).


# License

Apache2 - See the included LICENSE file for more details.

