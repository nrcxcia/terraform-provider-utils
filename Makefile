.PHONY: all fmt clean package test itest_%

all: fmt test

fmt:
	go fmt terraform-provider-utils/utils
	go fmt terraform-provider-utils

clean:
	make -C yelppack clean

itest_%:
	make -C yelppack $@

package: itest_lucid

test:
	go test terraform-provider-utils/utils
	go test terraform-provider-utils
