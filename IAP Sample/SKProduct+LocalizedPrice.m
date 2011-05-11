//
//  SKProduct+LocalizedPrice.m
//
//  Based on code by Troy Brant
//  http://troybrant.net/blog/2010/01/in-app-purchases-a-full-walkthrough/
//

#import "SKProduct+LocalizedPrice.h"


@implementation SKProduct (SKProduct_LocalizedPrice)

- (NSString *)localizedPrice
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:self.priceLocale];
    NSString *formattedString = [numberFormatter stringFromNumber:self.price];
    [numberFormatter release];
    return formattedString;
}

@end
