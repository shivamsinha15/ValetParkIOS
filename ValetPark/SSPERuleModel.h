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
@property (strong,nonatomic) NSString *fromTimeString;
@property (strong,nonatomic) NSString *toTimeString;
@property (strong,nonatomic) NSString *timeLimitString;
@property (strong,nonatomic) NSDate *fromTime;
@property (strong,nonatomic) NSDate *toTime;


@property (strong,nonatomic) NSString *parkingSpaceType;
@property double cost;


@property BOOL occupied;

- (BOOL) ruleIsApplicable:(NSDate *)atTimeDate day:(NSString *) dayOfWeek;
- (BOOL)selectedDayMatchToOrFromRuleDay:(NSString *) dayOfWeek;



@end
