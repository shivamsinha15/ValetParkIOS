//
//  SSGoogleLocation.h
//  ValetPark
//
//  Created by Shivam Sinha on 8/02/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSGoogleLocationModel : NSObject

@property (strong, nonatomic) NSString *formattedAddress;

@property double lat;
@property double lng;
// Designated Initializer
- (id) initAddressLatLng:(NSString *)formattedAddress latitude:(double)lat longitude:(double)lng;

//Convenience Constructor
+ (id)googleLocation:(NSString *)formattedAddress :(double)lat :(double)lng;

@end



//Invoking With and Without Paramater Names: http://stackoverflow.com/questions/14660091/xcode-4-6-used-as-the-name-of-the-previous-parameter-rather-than-as-part-of-the
//
//1. Without
//+ (NSString *)addFormatPrice:(double)dblPrice :(BOOL)booRemoveCurSymbol;
//[NSString addFormatPrice:0.3 :YES]
//
//2. With
//+ (NSString *)addFormatPrice:(double)dblPrice removeCurSymbol:(BOOL)booRemoveCurSymbol;
//[NSString addFormatPrice:0.3 removeCurSymbol:YES]
//
//
