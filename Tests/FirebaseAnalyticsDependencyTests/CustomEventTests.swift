import Foundation
import XCTest
@testable import FirebaseAnalyticsDependency
@testable import FirebaseAnalyticsDependencyLive

struct PostPublished: Eventable {
	struct Parameters: Equatable, Encodable {
		let title: String
		let likes: Int
		let tags: [String]
		let rating: Double
	}

	var name: String { "PostPublished" }
	var parameters: Parameters
}

class CustomEventTests: XCTestCase {
	func testEncoding() async throws {
		var analytics = TestAnalytics()
		var receivedEvent: String?
		var receivedParameters: [String: Any]?
		analytics._logEvent = { event, parameters in
			receivedEvent = event
			receivedParameters = parameters
		}

		let event: PostPublished = .init(parameters: .init(
			title: "Hello",
			likes: 3,
			tags: ["foo", "bar"],
			rating: 4.5
		))

		let sut: FirebaseAnalyticsClient = .live(analytics: analytics)
		_ = try await sut.log(
			.custom(.build(from: event))
		)
		XCTAssertEqual(receivedEvent, "PostPublished")
		XCTAssertEqual(receivedParameters?["title"] as? String, "Hello")
		XCTAssertEqual(receivedParameters?["likes"] as? Int, 3)

		let tags = try XCTUnwrap(receivedParameters?["tags"] as? NSArray)
		let firstTag = try XCTUnwrap(tags[0] as? Event.Custom.Value)
		XCTAssertEqual(firstTag, .string("foo"))
		let secondTag = try XCTUnwrap(tags[1] as? Event.Custom.Value)
		XCTAssertEqual(secondTag, .string("bar"))

		XCTAssertEqual(receivedParameters?["rating"] as? Double, 4.5)
	}
}
