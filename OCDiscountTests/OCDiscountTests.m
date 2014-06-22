/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <XCTest/XCTest.h>
#import <OCDiscount/OCDiscount.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

@interface OCDiscountTests : XCTestCase
@end

/**
* Dummy tests only to check whether OCDiscount.framework correctly wraps discount.
*/
@implementation OCDiscountTests

- (void)testWoFlags {
    NSString *pathForTableMd = [[NSBundle bundleForClass:[self class]] pathForResource:@"table" ofType:@"markdown"];
    NSString *tableMd = [NSString stringWithContentsOfFile:pathForTableMd encoding:NSUTF8StringEncoding error:NULL];

    NSString *pathForTableHtml = [[NSBundle bundleForClass:[self class]] pathForResource:@"table" ofType:@"html"];
    NSString *tableHtml = [[NSString stringWithContentsOfFile:pathForTableHtml encoding:NSUTF8StringEncoding error:NULL] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    assertThat([tableMd htmlFromMarkdown], is(tableHtml));
}

- (void)testWithFlags {
    NSString *pathForTableMd = [[NSBundle bundleForClass:[self class]] pathForResource:@"table" ofType:@"markdown"];
    NSString *tableMd = [NSString stringWithContentsOfFile:pathForTableMd encoding:NSUTF8StringEncoding error:NULL];

    NSString *pathForNoTableHtml = [[NSBundle bundleForClass:[self class]] pathForResource:@"notable" ofType:@"html"];
    NSString *noTableHtml = [[NSString stringWithContentsOfFile:pathForNoTableHtml encoding:NSUTF8StringEncoding error:NULL] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    assertThat([tableMd htmlFromMarkdownWithFlags:OCStrict], is(noTableHtml));
}

@end
