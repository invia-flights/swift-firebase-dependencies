//
//  File.swift
//  
//
//  Created by Quico Moya on 28.02.23.
//

import Foundation

public extension Event {
	struct AdImpression: Equatable {
		public init(
			adPlatform: String? = nil,
			adFormat: String? = nil,
			adSource: String? = nil,
			adUnitName: String? = nil,
			value: Money? = nil
		) {
			self.adPlatform = adPlatform
			self.adFormat = adFormat
			self.adSource = adSource
			self.adUnitName = adUnitName
			self.value = value
		}

		public let adPlatform: String?
		public let adFormat: String?
		public let adSource: String?
		public let adUnitName: String?
		public let value: Money?
	}
}
