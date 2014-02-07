//
//  SSSearchViewController.m
//  ValetPark
//
//  Created by Shivam Sinha on 29/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSSearchViewController.h"

@interface SSSearchViewController ()

@end

@implementation SSSearchViewController

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
  
  
    self.titlesArray = [NSArray arrayWithObjects:@"Getting started with WordPress",	@"Whitespace in Web Design: What It Is and Why You Should Use It",
                        @"Adaptive Images and Responsive SVGs - Treehouse Show Episode 15",
                        @"Productivity is About Constraints and Concentration",
                        @"A Guide to Becoming the Smartest Developer on the Planet",
                        @"Teacher Spotlight: Zac Gordon",
                        @"Do You Love What You Do?",
                        @"Applying Normalize.css Reset - Quick Tip",
                        @"How I Wrote a Book in 3 Days",
                        @"Responsive Techniques, JavaScript MVC Frameworks, Firefox 16 | Treehouse Show Episode 14", nil];
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
        
    }
    [super viewWillDisappear:animated];
}

#pragma mark - Search Bar Change

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSMutableString *stringChange = [NSMutableString stringWithCapacity:150];
    [stringChange appendString:searchText];
    
    NSLog(stringChange);
  
    [self.tableView reloadData];
}




#pragma mark - Table View

//I think this is by default Regardless
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SearchLocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = self.titlesArray[indexPath.row];
    } else {
        cell.textLabel.text = self.titlesArray[indexPath.row];
    }

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
