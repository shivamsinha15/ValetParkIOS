//
//  SSSearchViewController.m
//  ValetPark
//
//  Created by Shivam Sinha on 29/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSSearchViewController.h"
#import "SSGoogleLocationModel.h"
#import "SSMainViewController.h"


@interface SSSearchViewController ()

@end

@implementation SSSearchViewController{
    NSMutableArray *searchResults;
    NSMutableArray *searchLocations;
    NSMutableString *searchBarText;
    BOOL setMapToSearchedLocation;
    SSMainViewController *rootViewController;
    
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
  
    searchBarText = [NSMutableString stringWithCapacity:150];
    setMapToSearchedLocation = NO;
    rootViewController  = (SSMainViewController *)[self.navigationController.viewControllers objectAtIndex: 0];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        self.navigationController.navigationBarHidden = YES;
        //        http://stackoverflow.com/questions/1214965/setting-action-for-back-button-in-navigation-controller
        //        NSLog(@"back button was pressed.  We know this is true because self is no longer in the navigation stack.");
        if(setMapToSearchedLocation){
            [rootViewController setMapToCurrentLocation];
        }
        setMapToSearchedLocation = NO;
        
    }
    [super viewWillDisappear:animated];
}

#pragma mark - Search Bar Change

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.googleLocationModels = [NSMutableArray array];
    if ([searchText length] != 0) {
        [searchBarText setString:@""];
        [searchBarText appendString:searchText];
        //http://stackoverflow.com/questions/7061377/how-to-detect-a-pause-in-input-for-uisearchbar-uitextfield
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(populateSearchResults) object:nil];
        [self performSelector:@selector(populateSearchResults) withObject:nil afterDelay:1.5];
    } else {
        [self.tableView reloadData];
    }

}
                                    

-(void) populateSearchResults
{
    
    NSLog(@"%@", searchBarText);
    
    NSURL *googleMapAddressURL = [self createNSURL:searchBarText];
    NSData *jsonData = [NSData dataWithContentsOfURL:googleMapAddressURL];
    NSError *errors = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&errors];
    
  
    
    NSArray *searchLocationArrary = [dataDictionary objectForKey:@"results"];
    
    for (NSDictionary *slDictionary in searchLocationArrary) {
        
        NSString *formattedAddress = [slDictionary objectForKey:@"formatted_address"];
        NSDictionary *locDictionary  = [[slDictionary objectForKey:@"geometry"] objectForKey:@"location"];
        double lat = [[locDictionary objectForKey:@"lat"] doubleValue];
        double lng = [[locDictionary objectForKey:@"lng"] doubleValue];
        NSLog(@"formatted Address: %@, lat: %f, lng: %f",formattedAddress,lat,lng);
        SSGoogleLocationModel *googLoc = [SSGoogleLocationModel googleLocation:formattedAddress :lat :lng];
        [self.googleLocationModels addObject:googLoc];
        
    }
    
    [self.tableView reloadData];
    
}


-(NSURL *)createNSURL:(NSString *)searchString{
    NSMutableString *googleAddressURLString =  [NSMutableString stringWithCapacity:150];
    //https://developers.google.com/maps/documentation/geocoding/
    [googleAddressURLString appendString:@"http://maps.googleapis.com/maps/api/geocode/json?sensor=true&address="];
    [googleAddressURLString appendString:searchString];
    [googleAddressURLString appendString:@" Sydney, NSW, Australia "];
    NSLog(@"Http JSON request to: %@", googleAddressURLString);
    NSString *nonMutableURL = [NSString stringWithString:googleAddressURLString];
    //http://stackoverflow.com/questions/1981390/urlwithstring-returns-nil
    return [NSURL URLWithString:[nonMutableURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}


#pragma mark - Table View

//I think this is by default Regardless
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.googleLocationModels count] > 0) {
        return [self.googleLocationModels count];
    } else {
        return 0;
    }
}

//Populates the cells in table View
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SearchLocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if ([self.googleLocationModels count] > 0) {
        cell.textLabel.text = [[self.googleLocationModels objectAtIndex:indexPath.row] formattedAddress];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    SSGoogleLocationModel *googleModel = [self.googleLocationModels objectAtIndex:indexPath.row];
    NSNumber *currentLat = [NSNumber numberWithDouble:googleModel.lat];
    NSNumber *currentLng = [NSNumber numberWithDouble:googleModel.lng];
    [defaults setObject:currentLat forKey:@"currentLat"];
    [defaults setObject:currentLng forKey:@"currentLng"];
    setMapToSearchedLocation = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
