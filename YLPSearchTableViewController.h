//
//  YLPSearchTableViewController.h
//  WhereToEat
//
//  Created by Yu Xin on 4/25/17.
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLPClient;
@class YLPSearch;

// Create a typedefBlock with no return type, and two arguments – NSString objects for the text of the Text View and Text Field
typedef void (^CompletionHandler)(NSString *name, NSString *address);

@interface YLPSearchTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

// Create a public property of the typedefBlock
@property (copy,atomic) CompletionHandler completionHandler;


@end
