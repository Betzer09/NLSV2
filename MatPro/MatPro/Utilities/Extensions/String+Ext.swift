//
//  String+Ext.swift
//  AnneCraigFitness
//
//  Created by Drew Carver on 6/19/21.
//

import Foundation

extension String {
    /**
     Format's a phone number string to the mask you prefer
     
     ```
     // For example
     
     "12345678901" => "+12345678901"
     "" => ""
     "0" => "+0"
     "412" => "+4 (12"
     "12345678901" => "+1 (234) 567-8901"
     "a1_b2-c3=d4 e5&f6|g7h8" => "+1 (234) 567-8"
     ```
     
     mask example: `+X (XXX) XXX-XXXX`
     */
    func formatPhoneNumber(with mask: String = "(XXX) XXX-XXXX") -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    func isValidPhoneNumber() -> Bool {
        self.formatPhoneNumber(with: "XXXXXXXXXX").count == 10
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var trailingSlash: String {
        self + "/"
    }
    
    func deletePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deleteSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toURL() -> URL? {
        return URL(string: self)
    }
    
    func stripToNumbers() -> String {
        let okayChars = Set("1234567890")
        return self.filter {okayChars.contains($0) }
    }
}
