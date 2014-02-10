//
//  SSGoogleLocation.m
//  ValetPark
//
//  Created by Shivam Sinha on 8/02/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSGoogleLocationModel.h"

@implementation SSGoogleLocationModel

- (id) initAddressLatLng:(NSString *)formattedAddress latitude:(double)lat longitude:(double)lng{
    self = [super init];
    if (self){
        [self setFormattedAddress:formattedAddress];
        [self setLat:lat];
        [self setLng:lng];
    }
    return self;
}

+ (id)googleLocation:(NSString *)formattedAddress :(double)lat :(double)lng{
    return [[self alloc] initAddressLatLng:formattedAddress latitude:lat longitude:lng];
}

@end
