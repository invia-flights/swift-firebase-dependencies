PLATFORM_IOS = iOS Simulator,name=iPhone 11 Pro Max

CONFIG = debug

default: test

build-all-platforms:
	for platform in \
	  "$(PLATFORM_IOS)" \
	do \
		xcodebuild build \
			-workspace Dependencies.xcworkspace \
			-scheme Dependencies \
			-configuration $(CONFIG) \
			-destination platform="$$platform" || exit 1; \
	done;

test-swift:
	swift test
	swift test -c release

test-linux:
	docker run \
		--rm \
		-v "$(PWD):$(PWD)" \
		-w "$(PWD)" \
		swift:5.7-focal \
		bash -c 'apt-get update && apt-get -y install make && make test-swift'

build-for-library-evolution:
	swift build \
		-c release \
		--target Dependencies \
		-Xswiftc -emit-module-interface \
		-Xswiftc -enable-library-evolution

format:
	swiftformat .

.PHONY: test test-swift test-linux build-for-library-evolution format