//
//  SSMainViewController.m
//  ValetPark
//
//  Created by Shivam Sinha on 28/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import "SSMainViewController.h"
#import "ASValueTrackingSlider.h"

@interface SSMainViewController ()
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
	self.timeSlider.maximumValue = 670;
    self.timeSlider.popUpViewColor = [UIColor colorWithHue:0.61 saturation:1 brightness:0.9 alpha:0.8];
    self.timeSlider.textColor = [UIColor colorWithHue:0.65 saturation:1 brightness:0.4 alpha:1];
    self.timeSlider.font = [UIFont fontWithName:@"Menlo-Bold" size:15];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
