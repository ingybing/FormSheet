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
@property CGRect windowBounds;
@end

#define is_iOS8 ([[[UIDevice currentDevice] systemVersion]floatValue] >= 8)

@implementation ModalWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Start with a minimised window size.
    self.minimised = YES;
    self.windowBounds = CGRectMake(0, 0, 300, 300);
   
    if(is_iOS8)
    {
        // Set initial size in iOS 8 etc.
        self.preferredContentSize = self.windowBounds.size;
    }
}

- (void) viewWillLayoutSubviews
{
    // Resize the window based on it's current required size.
    // The supeview bounds only seems to actually changed on screen
    // if changed inside this method.
    self.view.superview.bounds = self.windowBounds;
}

- (IBAction)minMaxTouched:(id)sender
{
    // Toggle the dimensions of the window bases on minimised / maximised state.
    if (self.minimised == YES)
    {
        self.windowBounds = CGRectMake(0, 0, 600, 600);
    }
    else
    {
        self.windowBounds = CGRectMake(0, 0, 300, 300);
    }
    
    // Set some value that will get overridden in viewWillLayoutSubviews
    // You need to change the view bounds or it won't actually invoke a layout.
    self.view.superview.bounds = CGRectMake(0, 0, 100, 100);
    
    // Toggle minimised state before we layout.
    self.minimised = !self.minimised;
    
    // Manually request a layout. Since the superview bounds have been changed
    // to a temporary value it should cause a layout where we set the real
    // desired size.
    [self.view.superview layoutIfNeeded];
}

- (IBAction)closeTouched:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
