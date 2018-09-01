//
//  ViewController.m
//  WhereToEat
//
//  Created by Yu Xin on 4/15/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self enableOrDisableSaveButton];
    
    [self.addressTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string {
    NSLog(@"%s", __FUNCTION__);
    // everytime user edit enable save
    [self enableOrDisableSaveButton];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"%s", __FUNCTION__);
    // everytime user edit enable save
    [self enableOrDisableSaveButton];
    
    return YES;
}

// Helper method
- (void)enableOrDisableSaveButton {
    // If any of the text field /view is empty, disable the save button
    if (self.addressTextView.text.length == 0 || self.nameTextField.text.length == 0)
    {
        self.saveButton.enabled = NO;
    }
    else
    {
        self.saveButton.enabled = YES;
    }
}

- (IBAction)saveButtonDidPressed:(UIBarButtonItem *)sender {
    NSString *name = self.nameTextField.text;
    NSString *address = self.addressTextView.text;
    
    // invoking the completion handler
    self.completionHandler(name, address);
}

- (IBAction)cancelButtonDidPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.addressTextView resignFirstResponder];
    [self.nameTextField resignFirstResponder];
}








@end
