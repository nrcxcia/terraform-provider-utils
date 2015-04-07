provider "utils" {}

resource "utils_template" "durp" {
    count = 5
    template = "{{.oof}}"
    vars {
        oof = "${count.index}"
    }
}

resource "utils_template" "blurp" {
    template = <<TEMPLATE
hi hello
{{range $index, $element := split .hi ","}}
  {{add $index 1}}: {{$element}}{{end}}
TEMPLATE
    vars {
        hi = "${join(",", utils_template.durp.*.out)}"
    }
}

output "output" {
    value = "${utils_template.blurp.out}"
}
