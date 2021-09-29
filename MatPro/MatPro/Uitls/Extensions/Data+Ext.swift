//
//  Data+Ext.swift
//  AnneCraigFitness
//
//  Created by Drew Carver on 6/19/21.
//

import Foundation

extension Data {
    var prettyPrintedJsonString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
    
    var convertToDictionary: [String: Any]? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else { return nil }
        return object
    }
}
