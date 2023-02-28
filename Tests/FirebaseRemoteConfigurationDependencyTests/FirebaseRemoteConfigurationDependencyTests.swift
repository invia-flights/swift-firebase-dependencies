import FirebaseRemoteConfig
import XCTest

@testable import FirebaseRemoteConfigurationDependency
@testable import FirebaseRemoteConfigurationDependencyLive

final class FirebaseRemoteConfigClientTests: XCTestCase {
	func testConfigure() throws {
		let remoteConfig = TestRemoteConfig()

		var setSettings: RemoteConfigSettings?
		remoteConfig._setRemoteConfigSettings = {
			setSettings = $0
		}
		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		sut.configure(.init(minimumFetchInterval: 1, fetchTimeout: 2))

		XCTAssertEqual(setSettings?.minimumFetchInterval, 1)
		XCTAssertEqual(setSettings?.fetchTimeout, 2)
	}

	func testLastFetchTime() {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._getLastFetchTime = { .distantPast }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = sut.lastFetchTime()

		XCTAssertEqual(result, .distantPast)
	}

	func testSetDefaultsFromPlist() {
		let remoteConfig = TestRemoteConfig()
		var plist: String?
		remoteConfig._setDefaultsFromPlist = { plist = $0 }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		sut.setDefaultsFromPlist("test")

		XCTAssertEqual(plist, "test")
	}

	func testLastFetchStatusIsNoFetchYet() {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._getLastFetchStatus = { .noFetchYet }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = sut.lastFetchStatus()

		XCTAssertEqual(result, .noFetchYet)
	}

	func testLastFetchStatusIsSuccess() {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._getLastFetchStatus = { .success }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = sut.lastFetchStatus()

		XCTAssertEqual(result, .success)
	}

	func testLastFetchStatusIsFailure() {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._getLastFetchStatus = { .failure }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = sut.lastFetchStatus()

		XCTAssertEqual(result, .failure)
	}

	func testLastFetchStatusIsThrottled() {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._getLastFetchStatus = { .throttled }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = sut.lastFetchStatus()

		XCTAssertEqual(result, .throttled)
	}

	func testEnsureInitialized() async throws {
		let remoteConfig = TestRemoteConfig()
		var initialized = false
		remoteConfig._ensureInitialized = { initialized = true }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		try await sut.ensureInitialized()

		XCTAssert(initialized)
	}

	func testFetchNoFetchYet() async throws {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._fetch = { .noFetchYet }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = try await sut.fetch()

		XCTAssertEqual(result, .noFetchYet)
	}

	func testFetchSuccess() async throws {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._fetch = { .success }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = try await sut.fetch()

		XCTAssertEqual(result, .success)
	}

	func testFetchFailure() async throws {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._fetch = { .failure }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = try await sut.fetch()

		XCTAssertEqual(result, .failure)
	}

	func testFetchThrottled() async throws {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._fetch = { .throttled }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = try await sut.fetch()

		XCTAssertEqual(result, .throttled)
	}

	func testFetchWithExpirationDurationNoFetchYet() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedDuration: TimeInterval?
		remoteConfig._fetchWithExpirationDuration = {
			receivedDuration = $0
			return .noFetchYet
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = try await sut.fetchWithExpirationDuration(60)

		XCTAssertEqual(result, .noFetchYet)
		XCTAssertEqual(receivedDuration, 60)
	}

	func testFetchWithExpirationDurationSuccess() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedDuration: TimeInterval?
		remoteConfig._fetchWithExpirationDuration = {
			receivedDuration = $0
			return .success
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = try await sut.fetchWithExpirationDuration(60)

		XCTAssertEqual(result, .success)
		XCTAssertEqual(receivedDuration, 60)
	}

	func testFetchWithExpirationDurationFailure() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedDuration: TimeInterval?
		remoteConfig._fetchWithExpirationDuration = {
			receivedDuration = $0
			return .failure
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = try await sut.fetchWithExpirationDuration(60)

		XCTAssertEqual(result, .failure)
		XCTAssertEqual(receivedDuration, 60)
	}

	func testFetchWithExpirationDurationThrottled() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedDuration: TimeInterval?
		remoteConfig._fetchWithExpirationDuration = {
			receivedDuration = $0
			return .throttled
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let result = try await sut.fetchWithExpirationDuration(60)

		XCTAssertEqual(result, .throttled)
		XCTAssertEqual(receivedDuration, 60)
	}

	func testActivate() async throws {
		let remoteConfig = TestRemoteConfig()
		remoteConfig._activate = { true }

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let activated = try await sut.activate()

		XCTAssert(activated)
	}

	func testStringForKey() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedKey: String?
		var receivedSource: RemoteConfigSource?

		remoteConfig._configValue = { key, source in
			receivedKey = key
			receivedSource = source
			let value = TestRemoteConfigValue()
			value._stringValue = { "abc" }
			return value
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let string = sut.stringForKey("k", .default)

		XCTAssertEqual(string, "abc")
		XCTAssertEqual(receivedKey, "k")
		XCTAssertEqual(receivedSource, .default)
	}

	func testNumberForKey() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedKey: String?
		var receivedSource: RemoteConfigSource?

		remoteConfig._configValue = { key, source in
			receivedKey = key
			receivedSource = source
			let value = TestRemoteConfigValue()
			value._numberValue = { 123 }
			return value
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let number = sut.numberForKey("k", .default)

		XCTAssertEqual(number, 123)
		XCTAssertEqual(receivedKey, "k")
		XCTAssertEqual(receivedSource, .default)
	}

	func testDataForKey() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedKey: String?
		var receivedSource: RemoteConfigSource?

		remoteConfig._configValue = { key, source in
			receivedKey = key
			receivedSource = source
			let value = TestRemoteConfigValue()
			value._dataValue = { .init() }
			return value
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let data = sut.dataForKey("k", .default)

		XCTAssertEqual(data, .init())
		XCTAssertEqual(receivedKey, "k")
		XCTAssertEqual(receivedSource, .default)
	}

	func testBoolForKey() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedKey: String?
		var receivedSource: RemoteConfigSource?

		remoteConfig._configValue = { key, source in
			receivedKey = key
			receivedSource = source
			let value = TestRemoteConfigValue()
			value._boolValue = { true }
			return value
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let bool = sut.boolForKey("k", .default)

		XCTAssertEqual(bool, true)
		XCTAssertEqual(receivedKey, "k")
		XCTAssertEqual(receivedSource, .default)
	}

	func testJSONForKey() async throws {
		let remoteConfig = TestRemoteConfig()
		var receivedKey: String?
		var receivedSource: RemoteConfigSource?

		let exampleJSON =
			try JSONSerialization.jsonObject(with: #"{"test":"test"}"#.data(using: .utf8)!)
				as? [String: String]

		remoteConfig._configValue = { key, source in
			receivedKey = key
			receivedSource = source
			let value = TestRemoteConfigValue()
			value._jsonValue = { exampleJSON as Any }
			return value
		}

		let sut: FirebaseRemoteConfigClient = .live(remoteConfig: remoteConfig)

		let json = sut.jsonForKey("k", .default) as? [String: String]

		XCTAssertEqual(json, exampleJSON)
		XCTAssertEqual(receivedKey, "k")
		XCTAssertEqual(receivedSource, .default)
	}
}
