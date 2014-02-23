//
//  SSPERuleModel.m
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSPERuleModel.h"
#import "SSPERuleModel.h"
#import "NSString+Common.h"

@implementation SSPERuleModel

- (BOOL)ruleIsApplicable:(NSDate *)atTimeDate day:(NSString *) dayOfWeek{
    BOOL timeIsInBetweenRuleToFromTimes = [SSPERuleModel date:atTimeDate isBetweenDate:self.fromTime andDate:self.toTime];
    return (timeIsInBetweenRuleToFromTimes && [self selectedDayMatchToOrFromRuleDay: dayOfWeek]);
}

-(BOOL)selectedDayMatchToOrFromRuleDay:(NSString *) dayOfWeek{
    if([self.fromDay contains: dayOfWeek] || [self.toDay contains: dayOfWeek]){
        return YES;
    }
    return NO;
}


//http://stackoverflow.com/questions/1072848/how-to-check-if-an-nsdate-occurs-between-two-other-nsdates
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
    	return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
    	return NO;
    
    return YES;
}


@end
