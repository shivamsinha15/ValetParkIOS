//
//  SSMainViewController.m
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSMainViewController.h"
#import "ASValueTrackingSlider.h"
#import "SSSearchViewController.h"
#import "SSPaymentViewController.h"
#import "SSGoogleViewController.h"


@interface SSMainViewController (){
    NSUserDefaults *defaults;
    SSGoogleViewController *googleViewController;
    SSSearchViewController *searchViewController;
    SSPaymentViewController *paymentViewController;
}
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *timeSlider;

@end

@implementation SSMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTimeSlider];
    [self initLocationManager];
    defaults = [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBarHidden = TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTimeSlider{
    self.timeSlider.maximumValue = 670;
    self.timeSlider.popUpViewColor = [UIColor colorWithHue:0.61 saturation:1 brightness:0.9 alpha:0.8];
    self.timeSlider.textColor = [UIColor colorWithHue:0.65 saturation:1 brightness:0.4 alpha:1];
    self.timeSlider.font = [UIFont fontWithName:@"Menlo-Bold" size:15];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"Segue Identifier: %@",[segue identifier]);
    self.navigationController.navigationBarHidden = FALSE;

    if ([[segue identifier] isEqualToString:@"searchViewSegue"])
    {
        if(!searchViewController){
                searchViewController = [segue destinationViewController];
        }
    }  else if ([[segue identifier] isEqualToString:@"paymentViewSegue"]){
         if(!paymentViewController){
                 paymentViewController = [segue destinationViewController];
         }
    }  else if ([[segue identifier] isEqualToString:@"googleViewSegue"]){
         if(!googleViewController){
            googleViewController = [segue destinationViewController];
         }
    }

}


#pragma mark CoreLocation

//Delegated Method CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
        [manager  stopUpdatingLocation];
        CLLocation* location = [locations lastObject]; // locations is guaranteed to have at least one object
        double latitude = location.coordinate.latitude;
        double longitude = location.coordinate.longitude;
        NSNumber *currentLat = [NSNumber numberWithDouble:latitude];
        NSNumber *currentLng = [NSNumber numberWithDouble:longitude];
        [defaults setObject:currentLat forKey:@"currentLat"];
        [defaults setObject:currentLng forKey:@"currentLng"];
    [self setMapToCurrentLocation];
}

-(void)setMapToCurrentLocation{
    [googleViewController setCurrentLocationAsCenterMapView];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
   [manager stopUpdatingLocation];
    NSLog(@"error%@",error);
    switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"please check your network connection or that you are not in airplane mode" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case kCLErrorDenied:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"user has denied to use current Location " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"unknown network error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
    }

}

- (void)initLocationManager
{
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; //kCLDistanceFilterNone; // 100 m
}

- (IBAction)currentLocationButton:(id)sender {
    [self.locationManager startUpdatingLocation];
}

//Potentially alternative way to received lat/lng
//- (NSString *)deviceLocation {
//    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
//    return theLocation;
//}



@end
