//
//  SSPERuleModel.h
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSPERuleModel : NSObject

@property int id;
@property (strong,nonatomic) NSString *fromDay;
@property (strong,nonatomic) NSString *toDay;
@property (strong,nonatomic) NSString *fromTime;
@property (strong,nonatomic) NSString *toTime;
@property (strong,nonatomic) NSString *timeLimit;

@property (strong,nonatomic) NSString *parkingSpaceType;
@property double cost;



@property float startLat;
@property float startLng;
@property float endLat;
@property float endLng;
@property float bearing;



@property BOOL occupied;


@end
