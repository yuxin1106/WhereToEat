//
//  TableViewController.m
//  WhereToEat
//
//  Created by Yu Xin on 4/16/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import "TableViewController.h"
#import "EatingplacesModel.h"
//#import "AddViewController.h"
#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "YLPSearchTableViewController.h"

@interface TableViewController ()
// Create a private property for the model and use its singleton method
@property (strong, nonatomic) EatingplacesModel* model;
@property (nonatomic) float destLat;
@property (nonatomic) float destLong;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background2.png"]];
    //self.tableView.backgroundColor = [UIColor clearColor];
    //self.tableView.opaque = NO;
    // set up model
    self.model = [EatingplacesModel sharedModel];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// Update the data source and delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // #warning Incomplete implementation
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // #warning Incomplete implementation, return the number of rows
    return [self.model numberOfEatingplaces];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableRow" forIndexPath:indexPath];
    
    // Configuring the cell...
    Eatingplace* eatingplace = [self.model eatingplaceAtIndex:indexPath.row];
    // Title
    cell.textLabel.text = eatingplace.name;
    
    return cell;
}

// Override to support editing the table view
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        [self.model removeEatingplaceAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
        
}



// prepare for segue
/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"CellToMap" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Check to make sure the segue.identifier is equal to the string that you entered for the identifier in the storyboard
    if ([segue.identifier isEqualToString:@"TableToAdd"])
    {
        //AddViewController *addVC = segue.destinationViewController;
        YLPSearchTableViewController *ylpVC = segue.destinationViewController;
        
        // declare / define completion handler
        ylpVC.completionHandler = ^(NSString *name, NSString *address)
        {
            [self.model insertWithName:name address:address];
            [self.tableView reloadData];
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
    else if ([segue.identifier isEqualToString:@"CellToMap"])
    {
        MapViewController *mapVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       // UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        mapVC.address = [self.model eatingplaceAtIndex:indexPath.row].address;
        mapVC.name = [self.model eatingplaceAtIndex:indexPath.row].name;
    }
    
}


@end

































