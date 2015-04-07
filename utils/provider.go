package utils

import (
	"bytes"
	"fmt"
	"math/rand"
	"github.com/hashicorp/terraform/helper/schema"
	"strings"
	"text/template"
	"github.com/hashicorp/terraform/terraform"
)

func Provider() terraform.ResourceProvider {
	return &schema.Provider{
		Schema: nil,
		ResourcesMap: map[string]*schema.Resource{
			"utils_template": templateResource(),
		},
		ConfigureFunc: nil,
	}
}

func templateResource() *schema.Resource {
	return &schema.Resource{
		Schema: map[string]*schema.Schema {
			"template": &schema.Schema {
				Type: schema.TypeString,
				Required: true,
			},
			"vars": &schema.Schema {
				Type: schema.TypeMap,
				Required: true,
			},
			"out": &schema.Schema {
				Type: schema.TypeString,
				Computed: true,
			},
		},
		Create: TemplateCreateUpdate,
		Read: TemplateCreateUpdate,
		Update: TemplateCreateUpdate,
		Delete: TemplateDelete,
	}
}

func TemplateCreateUpdate(d *schema.ResourceData, meta interface{}) error {
	d.SetId(fmt.Sprintf("%d", rand.Int()))

	template_source := d.Get("template").(string)
	vars := d.Get("vars").(map[string]interface{})

	tmpl := template.New(d.Id())
	tmpl.Funcs(template.FuncMap{
		"add": addFunc,
		"split": strings.Split,
	})
	if tmpl, err := tmpl.Parse(template_source); err != nil {
		return err
	} else {
		var buf bytes.Buffer
		if err := tmpl.Execute(&buf, vars); err != nil {
			return err
		}
		d.Set("out", buf.String())
	}

	return nil
}

func TemplateDelete(d *schema.ResourceData, meta interface{}) error {
	d.SetId("")
	return nil
}


func addFunc(values ...int) int {
	ret := 0
	for _, value := range values {
		ret += value
	}
	return ret
}