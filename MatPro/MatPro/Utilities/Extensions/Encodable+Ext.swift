//
//  Encodable+Ext.swift
//  AnneCraigFitness
//
//  Created by Drew Carver on 6/19/21.
//

import Foundation

extension Encodable {
    func toJsonData() -> Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        return try? jsonEncoder.encode(self)
    }
}
