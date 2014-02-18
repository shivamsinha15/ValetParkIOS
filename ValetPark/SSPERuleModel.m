//
//  SSPERuleModel.m
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSPERuleModel.h"

@implementation SSPERuleModel

- (BOOL)ruleIsApplicable:(NSDate *)atTimeDate;{
    return [SSPERuleModel date:atTimeDate isBetweenDate:self.fromTime andDate:self.toTime];
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
