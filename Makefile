PLATFORM_IOS = iOS Simulator,name=iPhone 11 Pro Max

CONFIG = debug

default: test

test-swift:
	swift test
	swift test -c release

format:
	swiftformat .

.PHONY: test test-swift test-linux build-for-library-evolution format