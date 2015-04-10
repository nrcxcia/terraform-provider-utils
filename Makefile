.PHONY: all fmt clean package test itest_% integration .git/hooks/pre-commit

all: fmt .git/hooks/pre-commit test terraform-provider-utils

terraform-provider-utils:
	go build

fmt:
	go fmt ./...

clean:
	make -C yelppack clean
	rm -f terraform-provider-utils

itest_%:
	make -C yelppack $@

package: itest_lucid

test:
	go test -v ./utils/...

integration:
	make -C test

.git/hooks/pre-commit:
	if [ ! -f .git/hooks/pre-commit ]; then ln -s ../../git-hooks/pre-commit .git/hooks/pre-commit; fi

