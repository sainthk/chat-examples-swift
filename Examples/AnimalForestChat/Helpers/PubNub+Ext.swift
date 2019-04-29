//
//  PubNub+Ext.swift
//  AnimalForestChat
//
//  Created by Craig Lane on 3/14/19.
//

import PubNub

public extension Date {
  var timeToken: NSNumber {
    return NSNumber(value: self.timeIntervalSince1970 * 10000000)
  }

  static func from(_ timeToken: NSNumber) -> Date {
    return Date(timeIntervalSince1970: TimeInterval(floatLiteral: timeToken.doubleValue/10000000))
  }
}

extension PNStatus {
  var error: NSError? {
    guard let errorStatus = self as? PNErrorStatus, errorStatus.isError else {
      return nil
    }

    return NSError(domain: "\(self.stringifiedOperation()) \(self.stringifiedCategory())",
            code: statusCode,
            userInfo: [
              NSLocalizedDescriptionKey: "\(self)",
              NSLocalizedFailureReasonErrorKey: errorStatus.errorData.information
            ])
  }
}

// tag::INIT-1[]
extension PubNub {
  static func configure(with userId: String? = User.defaultValue.uuid, using bundle: Bundle = Bundle.main) -> PubNub {
    // Read Pub/Sub Keys from Info.plist
    let (pubKey, subKey) = bundle.pubSubKeys(for: "PubNub")

    let config = PNConfiguration(publishKey: pubKey, subscribeKey: subKey)
    if let uuid = userId {
      NSLog("Configuring PubNub with \(uuid)")
      config.uuid = uuid
    }

    return PubNub.clientWithConfiguration(config)
  }
}
// end::INIT-1[]
