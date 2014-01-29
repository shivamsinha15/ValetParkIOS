//
//  SSGoogleViewController.m
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSGoogleViewController.h"
#import "SSPESpaceModel.h"
#import "SSPERuleModel.h"
#import <GoogleMaps/GoogleMaps.h>

@interface SSGoogleViewController ()

@end

@implementation SSGoogleViewController {
    GMSMapView *mapView_;
    UIColor *red;
    UIColor *green;
    
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
    [self displayMap];
    [self initaliseParkingData];
    [self showPeSpacesOnMap];
    
    
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
        peRule.fromTime= [peRuleData objectForKey:@"fromTime"];
        peRule.toTime= [peRuleData objectForKey:@"toTime"];
        peRule.timeLimit=[peRuleData objectForKey:@"timeLimit"];
        [self.peRules addObject:peRule];
    }
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

@end
