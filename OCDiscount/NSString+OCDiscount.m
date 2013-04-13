/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "NSString+OCDiscount.h"
#import "markdown.h"

// discount re-defines if(x) to if((x) != 0) in its config.h and AppCode treats the following use of 'if' as macros.
#undef if

@implementation NSString (OCDiscount)

- (NSString *)htmlFromMarkdown {
    return [self htmlFromMarkdownWithFlags:(OCMarkdownFlag) 0];
}

- (NSString *)htmlFromMarkdownWithFlags:(OCMarkdownFlag)flags {
    const char *cStr = [self UTF8String];

    Document *mdDoc = mkd_string(cStr, (int) strlen(cStr), flags);
    if (!mdDoc) {
        return NULL;
    }

    if (!mkd_compile(mdDoc, flags)) {
        return NULL;
    }

    char *cStrHtml = NULL;
    int cStrHtmlLength = mkd_document(mdDoc, &cStrHtml);

    if (cStrHtmlLength == 0) {
        return NULL;
    }

    NSString *result = [[NSString alloc] initWithBytes:cStrHtml length:(NSUInteger) cStrHtmlLength encoding:NSUTF8StringEncoding];
    return [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
