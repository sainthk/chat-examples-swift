//
//  PNConfiguration+Ext.swift
//  RCDemo
//
//  Created by Craig Lane on 4/10/19.
//

import Foundation
// tag::INIT-1[]
import PubNub

extension PNConfiguration {
  static func keys(fromBundle bundle: Bundle) -> (pubKey: String, subKey: String) {
    // Read Pub/Sub Keys from Info.plist
    let pubnubInfoDictionary = bundle.object(forInfoDictionaryKey: "PubNub") as? [String: String]
    let pubKey = pubnubInfoDictionary?["PubKey"] ?? ""
    let subKey = pubnubInfoDictionary?["SubKey"] ?? ""

    if pubKey.isEmpty || subKey.isEmpty {
      NSLog("Please verify that your pub/sub keys are set inside the RCDemo.<CONFIG>.xcconfig files.")

      // This will only crash on debug configurations
      assertionFailure("Please ensure that your Pub/Sub keys are set inside the RCDemo.xcconfig files")
    }

    return (pubKey, subKey)
  }
}
// end::INIT-1[]