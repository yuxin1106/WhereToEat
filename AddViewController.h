//
//  ViewController.h
//  WhereToEat
//
//  Created by Yu Xin on 4/15/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Create a typedefBlock with no return type, and two arguments – NSString objects for the text of the Text View and Text Field
typedef void (^CompletionHandler)(NSString *name, NSString *address);

// Make it adhere to the UIT extViewDelegate and UIT extFieldDelegate protocols
@interface AddViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

// Create a public property of the typedefBlock
@property (copy,atomic) CompletionHandler completionHandler;

// Create a public property to set the text of the label telling the user what to enter
@property (weak, nonatomic) IBOutlet UILabel *whatToEnter;


@end

