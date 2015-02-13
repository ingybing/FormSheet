//
//  ModalWindowViewController.m
//  FormSheetResize
//
//  Created by David Ingham on 12/02/2015.
//  Copyright (c) 2015 David Ingham. All rights reserved.
//

#import "ModalWindowViewController.h"

@interface ModalWindowViewController ()
@property bool minimised;
@property bool isInitialViewLoadLayout;
@end

#define is_iOS8 ([[[UIDevice currentDevice] systemVersion]floatValue] >= 8)

@implementation ModalWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.minimised = YES;
    self.isInitialViewLoadLayout = YES;
    
    if(is_iOS8)
    {
        // Set initial size in iOS 8 etc.
        self.preferredContentSize = CGSizeMake(300, 300);
    }
}

- (void) viewWillLayoutSubviews
{
    if (self.isInitialViewLoadLayout)
    {
        self.isInitialViewLoadLayout = NO;
        
        if(!is_iOS8)
        {
            // Set initial size in iOS 6,7 etc.
            self.view.superview.bounds = CGRectMake(0, 0, 300, 300);
        }
    }
}

- (IBAction)minMaxTouched:(id)sender
{
    CGRect newSize = CGRectMake(0, 0, 300, 300);
    
    if (self.minimised == YES)
    {
        newSize = CGRectMake(0, 0, 600, 600);
    }
    
    if(is_iOS8)
    {
        // Doesn't Work
        // self.view.superview.bounds = newSize;
        
        // Doesn't seem to do anything either.
        self.preferredContentSize = newSize.size;
    }
    else
    {
        // Works a treat on ios7
        self.view.superview.bounds = newSize;
    }
    
    self.minimised = !self.minimised;
}

- (IBAction)closeTouched:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
