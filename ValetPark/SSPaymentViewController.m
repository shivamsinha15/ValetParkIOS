//
//  SSPaymentViewController.m
//  ValetPark
//
//  Created by Shivam Sinha on 29/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSPaymentViewController.h"

@interface SSPaymentViewController ()

@end

@implementation SSPaymentViewController

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
	// Do any additional setup after loading the view.
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


@end
