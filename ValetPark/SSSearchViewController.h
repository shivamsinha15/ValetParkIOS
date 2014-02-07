//
//  SSSearchViewController.h
//  ValetPark
//
//  Created by Shivam Sinha on 29/01/2014.
//  Copyright (c) 2014 SaxStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong) NSArray *titlesArray;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
