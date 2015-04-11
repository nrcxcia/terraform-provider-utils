.PHONY: all fmt .git/hooks/pre-commit terraform-provider-utils clean package test itest_%

all: fmt .git/hooks/pre-commit test terraform-provider-utils

fmt:
	go fmt ./...

clean:
	make -C yelppack clean
	rm -f terraform-provider-utils
	rm -rf test/example.git test/checkout test/terraform.tfstate.backup test/terraform.tfstate

terraform-provider-utils: test
	go build

dev: terraform-provider-utils
	cp terraform-provider-utils $$(echo $$GOPATH|sed -e's/://')/bin

integration: dev
	make -C test

itest_%:
	make -C yelppack $@

package: itest_lucid

test:
	go test -v ./utils/...

.git/hooks/pre-commit:
	if [ ! -f .git/hooks/pre-commit ]; then ln -s ../../git-hooks/pre-commit .git/hooks/pre-commit; fi

