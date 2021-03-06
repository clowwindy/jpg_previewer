//
//  MainViewController.h
//  ImageProducer
//
//  Created by clowwindy on 5/16/13.
//  Copyright (c) 2013 clowwindy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ChartView.h"

@interface MainViewController : NSViewController<NSWindowDelegate>

@property (nonatomic) IBOutlet NSSlider *percentSlider;
@property (nonatomic) IBOutlet NSButton *saveButton;
@property (nonatomic) IBOutlet NSTextField *percentTextField;
@property (nonatomic) IBOutlet NSTextField *fileSizeTextField;
@property (nonatomic) IBOutlet NSTextField *resolutionTextField;
@property (nonatomic) IBOutlet NSImageView *leftImageView;
@property (nonatomic) IBOutlet NSImageView *rightImageView;
@property (nonatomic) IBOutlet ChartView *chartView;

-(IBAction) sliderChanged:(id)sender;
-(IBAction) setSliderValue:(id)sender;
-(IBAction) imageDropped:(id)sender;
-(IBAction) saveClicked:(id)sender;

-(void)openFile:(NSString *)filename;
           
@end
