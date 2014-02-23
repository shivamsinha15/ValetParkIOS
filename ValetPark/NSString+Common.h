//
//  NSObject+NSString_Common.h
//  ValetPark
//
//  Created by Shivam Sinha on 23/02/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

-(BOOL)isBlank;
-(BOOL)contains:(NSString *)string;
-(NSArray *)splitOnChar:(char)ch;
-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
-(NSString *)stringByStrippingWhitespace;

@end
