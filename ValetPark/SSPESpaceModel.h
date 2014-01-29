//
//  SSPESpaceModel.h
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSPESpaceModel : NSObject

@property int id;
@property double startLat;
@property double startLng;
@property double endLat;
@property double endLng;
@property float bearing;

@property (strong,nonatomic) NSString *address;
@property BOOL occupied;
@property (strong,nonatomic) NSArray *ruleIds;

@end
