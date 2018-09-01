//
//  YLPSearchTableViewController.m
//  WhereToEat
//
//  Created by Yu Xin on 4/25/17.
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import "YLPSearchTableViewController.h"
#import "AppDelegate.h"
#import <YelpAPI/YLPClient+Search.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPSortType.h>
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPLocation.h>

@interface YLPSearchTableViewController ()
@property (nonatomic) YLPSearch *search;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;
@property (strong, nonatomic) IBOutlet UITextField *keywordTextField;
@property (strong, nonatomic) IBOutlet UITableView *resultTableView;

@end

@implementation YLPSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"load yelp search view controller");
}
- (IBAction)cancelButtonDidPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)searchButtonDidPressed:(UIButton *)sender {
    NSString *location = [NSString stringWithFormat:@"%@,%@", self.cityTextField.text,self.stateTextField.text];
    [[AppDelegate sharedClient] searchWithLocation:location term:self.keywordTextField.text limit:20 offset:0 sort:YLPSortTypeDistance completionHandler:^(YLPSearch *search, NSError *error)
     {
         self.search = search;
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.resultTableView reloadData];
         });
     }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    if (indexPath.item > [self.search.businesses count]) {
        cell.textLabel.text = @"";
    }
    else {
        cell.textLabel.text = self.search.businesses[indexPath.item].name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *name = self.search.businesses[indexPath.item].name;
    NSString *address = [NSString stringWithFormat:@"%@,%@,%@",self.search.businesses[indexPath.item].location.address[0],self.cityTextField.text, self.stateTextField.text];
    
    self.completionHandler(name, address);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
