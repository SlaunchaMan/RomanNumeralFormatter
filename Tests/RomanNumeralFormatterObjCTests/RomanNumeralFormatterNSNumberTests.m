//
//  RomanNumeralFormatterNSNumberTests.m
//  RomanNumeralFormatterObjCTests
//
//  Created by Jeff Kelley on 1/17/21.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@import RomanNumeralFormatter;

@interface RomanNumeralFormatterNSNumberTests : XCTestCase

- (void)testAllNumberFormats;

@end

@implementation RomanNumeralFormatterNSNumberTests

- (void)testAllNumberFormats {
    RomanNumeralFormatter *formatter = [[RomanNumeralFormatter alloc] init];
    
    NSArray<NSNumber *> *allNumbers = @[
        [NSNumber numberWithChar:42],
        [NSNumber numberWithInt:42],
        [NSNumber numberWithInteger:42],
        [NSNumber numberWithLong:42],
        [NSNumber numberWithLongLong:42],
        [NSNumber numberWithShort:42],
        [NSNumber numberWithUnsignedChar:42],
        [NSNumber numberWithUnsignedInt:42],
        [NSNumber numberWithUnsignedInteger:42],
        [NSNumber numberWithUnsignedLong:42],
        [NSNumber numberWithUnsignedLongLong:42],
        [NSNumber numberWithUnsignedShort:42]
    ];
    
    for (NSNumber *number in allNumbers) {
        NSLog(@"%@", [NSString stringWithCString:number.objCType
                                        encoding:NSUTF8StringEncoding]);
        
        XCTAssertEqualObjects([formatter stringForObjectValue:number],
                              @"XLII");
    }
}

- (void)testLargeNumberFormatting {
    RomanNumeralFormatter *formatter = [[RomanNumeralFormatter alloc] init];
    
    XCTAssertEqualObjects([formatter stringForObjectValue:@1000000],
                          @"M̅");
}

@end
