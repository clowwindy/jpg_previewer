//
//  IPRAppDelegate.h
//  ImageProducer
//
//  Created by clowwindy on 05/16/13.
//  Copyright (c) 2013 clowwindy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainViewController.h"

@interface IPRAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet MainViewController *mainViewController;

@end