//
//  RomanNumeralFormatter.swift
//  RomanNumeralFormatter
//
//  Created by Jeff Kelley on 1/17/21.
//

import Foundation
import IsNotEmpty

public class RomanNumeralFormatter: Formatter {
    
    private static let values: [Int: String] = [
        1_000_000: "M̅",
        900_000: "C̅M̅",
        500_000: "D̅",
        400_000: "C̅D̅",
        100_000: "C̅",
        90_000: "X̅C̅",
        50_000: "L̅",
        40_000: "X̅L̅",
        10_000: "X̅",
        9_000: "I̅X̅",
        5_000: "V̅",
        4_000: "I̅V̅",
        1_000: "M",
        900: "CM",
        500: "D",
        400: "CD",
        100: "C",
        90: "XC",
        50: "L",
        40: "XL",
        10: "X",
        9: "IX",
        5: "V",
        4: "IV",
        1: "I"
    ]
    
    private static func convert<T: BinaryInteger>(_ value: T) -> String? {
        guard 4_000_000 > value else { return nil }
        
        guard 0 < value else { return nil }
        
        var value = value
        var string = ""
        
        let keys = values.keys.sorted().reversed()
        
        while value > 0,
              let key = keys.first(where: { value >= $0 }),
              let nextStringComponent = values[key] {
            string.append(nextStringComponent)
            value -= T(key)
        }
        
        return string
    }
    
    public override func string(for obj: Any?) -> String? {
        guard let number = obj as? NSNumber else {
            return nil
        }
        
        switch String(cString: number.objCType) {
        case "c":
            return Self.convert(number.int8Value)
        case "i":
            return Self.convert(number.intValue)
        case "s":
            return Self.convert(number.int16Value)
        case "l":
            return Self.convert(number.int32Value)
        case "q":
            return Self.convert(number.int64Value)
        case "C":
            return Self.convert(number.uint8Value)
        case "I":
            return Self.convert(number.uintValue)
        case "S":
            return Self.convert(number.uint16Value)
        case "L":
            return Self.convert(number.uint32Value)
        case "Q":
            return Self.convert(number.uint64Value)
        default:
            return nil
        }
    }
    
    public override func getObjectValue(
        _ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?,
        for string: String,
        errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?
    ) -> Bool {
        var result: Int = 0
        
        let keys = Self.values
            .sorted { (lhs, rhs) -> Bool in lhs.value.count < rhs.value.count }
            .reversed()
        
        var string = string
        
        while let next = keys.first(where: { string.hasPrefix($0.value) }) {
            result += next.key
            string.removeFirst(next.value.count)
        }
        
        guard result > 0, result < 4_000_000 else {
            error?.pointee = "Invalid roman numeral."
            return false
        }
        
        obj?.pointee = NSNumber(value: result)
        return true
    }
    
}
