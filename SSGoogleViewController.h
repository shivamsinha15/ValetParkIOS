//
//  SSGoogleViewController.h
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ASValueTrackingSlider.h"
#import "SSMainViewController.h"





@interface SSGoogleViewController : UIViewController <ASValueTrackingSliderDelegate>

@property(strong,nonatomic) NSMutableArray *peSpaces;
@property(strong,nonatomic) NSMutableArray *peRules;
- (void)setCurrentLocationAsCenterMapView;
@property(strong,nonatomic) SSMainViewController *mainViewController;
@end
