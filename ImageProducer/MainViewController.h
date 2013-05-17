//
//  MainViewController.h
//  ImageProducer
//
//  Created by clowwindy on 5/16/13.
//  Copyright (c) 2013 clowwindy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainViewController : NSViewController

@property (nonatomic) IBOutlet NSSlider *percentSlider;
@property (nonatomic) IBOutlet NSButton *saveButton;
@property (nonatomic) IBOutlet NSTextField *percentTextField;
@property (nonatomic) IBOutlet NSTextField *fileSizeTextField;
@property (nonatomic) IBOutlet NSTextField *resolutionTextField;
@property (nonatomic) IBOutlet NSImageView *leftImageView;
@property (nonatomic) IBOutlet NSImageView *rightImageView;

-(IBAction) sliderChanged:(id)sender;
-(IBAction) setSliderValue:(id)sender;
-(IBAction) imageDropped:(id)sender;
-(IBAction) saveClicked:(id)sender;
           
@end
