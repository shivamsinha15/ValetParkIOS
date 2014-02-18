//
//  SSGoogleViewController.m
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSMainViewController.h"
#import "SSGoogleViewController.h"
#import "SSPESpaceModel.h"
#import "SSPERuleModel.h"



@interface SSGoogleViewController ()

@end

@implementation SSGoogleViewController {
    GMSMapView *mapView_;
    UIColor *red;
    UIColor *green;
    NSDate *today;
    NSDateFormatter *timeDateFormatter;
    NSUserDefaults *standardDefaults;
}

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
    today = [NSDate date];
    timeDateFormatter = [[NSDateFormatter alloc] init];
    [timeDateFormatter setDateFormat:@"HH:mm:ss"];
    
    standardDefaults = [NSUserDefaults standardUserDefaults];
    [self setASValueSliderTrackingDelegate];
    [self displayMap];
    
    @try {
        [self initaliseParkingData];
        [self showPeSpacesOnMap];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
         NSLog(@"finally");
    }

    
    
}


-(void) showPeSpacesOnMap{
   for(SSPESpaceModel *peSpace in self.peSpaces){
        [self drawPloyLines:peSpace.startLat :peSpace.startLng :peSpace.endLat :peSpace.endLng :peSpace.occupied];
    }

//    
//    SSPESpaceModel *peSpace = [self.peSpaces objectAtIndex:0];
//    [self drawPloyLines:peSpace.startLat :peSpace.startLng :peSpace.endLat :peSpace.endLng :peSpace.occupied];
}

-(void) drawPloyLines: (double)startLat :(double)startLng :(double)endLat :(double)endLng :(BOOL)occupied{
        GMSMutablePath *path = [GMSMutablePath path];
//        NSLog(@"startLat %e",startLat);
//        NSLog(@"startLng %e",startLng);
//        NSLog(@"endLat %e",endLat);
//        NSLog(@"endLng %e",endLng);
       [path addLatitude:startLat longitude:startLng];
       [path addLatitude:endLat longitude:endLng];

    //uicolor.org
       GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    
    if(occupied){
        polyline.strokeColor = red;
    } else {
        polyline.strokeColor = green;
    }

    polyline.strokeWidth = 10.f;
    polyline.map = mapView_;
}

- (void) initaliseParkingData{
    [self initColors];
    [self initPESpaces];
    [self initPERules];
}

- (void) initColors{
    green = [UIColor colorWithRed:61/255.0f green:176/255.0f blue:7/255.0f alpha:1.0f];
    red = [UIColor colorWithRed:229/255.0f green:75/255.0f blue:24/255.0f alpha:1.0f];

}

- (void) initPESpaces{
    NSArray *peSpacesArray = [self getModelArray:@"http://54.200.11.164/parking-engine/PESpace/all"];
    self.peSpaces = [NSMutableArray array];
    
    for(NSDictionary *peSpaceData in peSpacesArray){
        SSPESpaceModel *peSpace = [[SSPESpaceModel alloc] init];
        peSpace.id = [[peSpaceData objectForKey:@"id"] intValue];
        peSpace.startLat= [[peSpaceData objectForKey:@"startLat"] doubleValue];
        peSpace.startLng= [[peSpaceData objectForKey:@"startLng"] doubleValue];
        peSpace.endLat= [[peSpaceData objectForKey:@"endLat"] doubleValue];
        peSpace.endLng= [[peSpaceData objectForKey:@"endLng"] doubleValue];
        peSpace.bearing= [[peSpaceData objectForKey:@"bearing"] doubleValue];
        peSpace.address=[peSpaceData objectForKey:@"address"];
        peSpace.occupied= [[peSpaceData objectForKey:@"occupied"] boolValue];
        [self.peSpaces addObject:peSpace];
    }
}

- (void) initPERules{
    NSArray *peRuleArray = [self getModelArray:@"http://54.200.11.164/parking-engine/PERule/all"];
    self.peRules = [NSMutableArray array];
    
    for(NSDictionary *peRuleData in peRuleArray){
        SSPERuleModel *peRule = [[SSPERuleModel alloc] init];
        peRule.id = [[peRuleData objectForKey:@"id"] intValue];
        peRule.fromDay = [peRuleData objectForKey:@"fromDay"];
        peRule.toDay = [peRuleData objectForKey:@"toDay"];
        peRule.cost= [[peRuleData objectForKey:@"cost"] doubleValue];
        peRule.fromTimeString= [peRuleData objectForKey:@"fromTime"];
        peRule.toTimeString= [peRuleData objectForKey:@"toTime"];
        peRule.timeLimitString=[peRuleData objectForKey:@"timeLimit"];
        [self populateFromAndToTime:&peRule];
        [self.peRules addObject:peRule];
    }
}


- (void) populateFromAndToTime:(SSPERuleModel**)peRule{
    NSDate *fromTime = [self getTime: [*peRule fromTimeString]];
    NSDate *toTime = [self getTime: [*peRule toTimeString]];
    [*peRule setFromTime:fromTime];
    [*peRule setToTime:toTime];

}


// Time Format: http://54.200.11.164/parking-engine/PERule/all
//http://stackoverflow.com/questions/12624025/nsdate-but-no-nstime-how-to-convert-a-string-representation-of-time-without-d
- (NSDate *) getTime:(NSString *) timeAsString {
    

    NSArray *removedMilliSec = [timeAsString componentsSeparatedByString: @"."];
    NSString *hhmmssAsString = removedMilliSec[0];
    NSDate *fromTime = [timeDateFormatter dateFromString:hhmmssAsString];
    

    return fromTime;
}

- (NSArray *) getModelArray:(NSString *) urlString {
   
    NSURL *peModelUrl = [NSURL URLWithString:urlString];
    NSData *jsonData = [NSData dataWithContentsOfURL:peModelUrl];
    NSError *errors = nil;
    if(errors){
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&errors];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayMap{
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.814460029617955
                                                            longitude:151.00626159872712
                                                                 zoom:18];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
}


//Two ways to implement: http://stackoverflow.com/questions/15026923/how-to-setcenter-mapview-with-location-in-google-maps-sdk-for-ios
- (void)setCurrentLocationAsCenterMapView{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CLLocationDegrees lat = [[defaults objectForKey:@"currentLat"] doubleValue];
    CLLocationDegrees lng = [[defaults objectForKey:@"currentLng"] doubleValue];
    CLLocationCoordinate2D currentLoc = CLLocationCoordinate2DMake(lat, lng);
    [mapView_ animateToLocation:currentLoc];
}

-(void)selectedTimeHasBeenUpdated:(NSDate *)selectedTime setTimeLabel:(NSString *)timeLabel{
    NSMutableString *output = [NSMutableString stringWithCapacity:150];
    [output appendString: @"Google View Controller ASValueTrackingSliderDelegateCalled "];
    [output appendString: timeLabel];
    NSLog(@"%@",output);
    [self checkIfRulesAreApplicable:selectedTime setTimeLabel:timeLabel];
}


-(void)checkIfRulesAreApplicable:selectedTime setTimeLabel:timeLabel{
    for (SSPERuleModel *peRule in self.peRules){
        [peRule ruleIsApplicable:selectedTime];
    }
}

-(void) setASValueSliderTrackingDelegate{
    // Both these methods for getting the MainViewController returned back nil:
    //SSMainViewController *rootViewController = (SSMainViewController *)[self.navigationController.viewControllers objectAtIndex: 0];
    
    //http://stackoverflow.com/questions/5968703/how-to-find-root-uiviewcontroller
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //SSMainViewController *rootViewController = (SSMainViewController *)window.rootViewController;
    
    [self.mainViewController.timeSlider setDelegate:self];
}


@end
