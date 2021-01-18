# RomanNumeralFormatter

A `Formatter` subclass that formats numbers as Roman numerals. Supports numbers
from between 0 and 4 million (non-inclusive).

## Usage

To use this formatter, create an instance of `RomanNumeralFormatter` and use it
like so:

### Formatting Numbers

```swift
let formatter = RomanNumeralFormatter()
let string = formatter.string(for: 42) // "XLII"
```

### Parsing Roman Numerals

```swift
let formatter = RomanNumeralFormatter()

var int = NSNumber(integerLiteral: 0) as AnyObject?
let success = formatter.getObjectValue(&int, for: "IX", errorDescription: nil)

if success {
    let intValue = (int as? NSNumber)?.intValue // 9
}
```

## Large Numbers

Most Roman numeral formatters stop at 4,000. However, using the
[Unicode overline character](https://en.wikipedia.org/wiki/Overline#Unicode), we
can represent larger numbers, up to (but not including) 4 million.

```swift
let formatter = RomanNumeralFormatter()
let string = formatter.string(for: 3_999_999) // "M̅M̅M̅C̅M̅X̅C̅I̅X̅CMXCIX"
```
