         //
//  SSMainViewController.h
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SSGoogleLocationModel.h"
#import "ASValueTrackingSlider.h"
@class SSAppDelegate;


@interface SSMainViewController : UIViewController <CLLocationManagerDelegate>

//http://stackoverflow.com/questions/13491411/iphone-app-how-to-get-the-current-location-only-once-and-store-that-to-be-used
@property(nonatomic,retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *timeSlider;


- (IBAction)currentLocationButton:(id)sender;
-(void)setMapToCurrentLocation;

@end
