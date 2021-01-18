//
//  RomanNumeralFormatterTests.m
//  RomanNumeralFormatterTests
//
//  Created by Jeff Kelley on 1/17/21.
//

import RomanNumeralFormatter
import XCTest

final class RomanNumeralFormatterTests: XCTestCase {

    func testFormattingToString() {
        let formatter = RomanNumeralFormatter()
        
        XCTAssertEqual(formatter.string(for: 1), "I")
        XCTAssertEqual(formatter.string(for: 42), "XLII")
        XCTAssertEqual(formatter.string(for: 867_530), "D̅C̅C̅C̅L̅X̅V̅MMDXXX")
        XCTAssertEqual(formatter.string(for: 1_000_000), "M̅")
        XCTAssertEqual(formatter.string(for: 3_999_999), "M̅M̅M̅C̅M̅X̅C̅I̅X̅CMXCIX")
    }
    
    func testFormattingIllegalValues() {
        let formatter = RomanNumeralFormatter()
        
        XCTAssertNil(formatter.string(for: 0))
        XCTAssertNil(formatter.string(for: -1))
        XCTAssertNil(formatter.string(for: 4_000_000))
    }
    
    func testFormattingAllIntegerTypes() {
        let formatter = RomanNumeralFormatter()
        
        for number in [NSNumber(value: Int8(42)),
                       NSNumber(value: UInt8(42)),
                       NSNumber(value: Int16(42)),
                       NSNumber(value: UInt16(42)),
                       NSNumber(value: Int32(42)),
                       NSNumber(value: UInt32(42)),
                       NSNumber(value: Int64(42)),
                       NSNumber(value: UInt16(42)),
                       NSNumber(value: Int(42)),
                       NSNumber(value: UInt(42))] {
            print(String(cString: number.objCType))
            XCTAssertEqual(formatter.string(for: number), "XLII")
        }
    }
    
    func testParsingRomanNumeralsToIntegers() {
        let formatter = RomanNumeralFormatter()
        
        func assertFormatterParses(_ string: String, to int: Int, file: StaticString = #file, line: UInt = #line) {
            var integer = NSNumber(integerLiteral: 0) as AnyObject?
            
            XCTAssertTrue(formatter.getObjectValue(&integer,
                                                   for: string,
                                                   errorDescription: nil),
                          file: file,
                          line: line)
            
            XCTAssertEqual((integer as? NSNumber)?.intValue,
                           int,
                           file: file,
                           line: line)
        }
        
        assertFormatterParses("I", to: 1)
        assertFormatterParses("XLII", to: 42)
        assertFormatterParses("M̅",to: 1_000_000)
        assertFormatterParses("D̅C̅C̅C̅L̅X̅V̅MMDXXX", to: 867_530)
        assertFormatterParses("M̅M̅M̅C̅M̅X̅C̅I̅X̅CMXCIX", to: 3_999_999)
    }

}
