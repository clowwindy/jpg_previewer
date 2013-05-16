//
//  MainViewController.m
//  ImageProducer
//
//  Created by clowwindy on 5/16/13.
//  Copyright (c) 2013 clowwindy. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)updateRightImage {
    if (_leftImageView.image) {
        NSArray *representations;
        NSData *bitmapData;
        representations = [_leftImageView.image representations];
        bitmapData = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.01 * _percentSlider.floatValue] forKey:NSImageCompressionFactor]];
        NSImage *rightImage = [[NSImage alloc] initWithData:bitmapData];
        _rightImageView.image = rightImage;
    }
}

- (void)sliderChanged:(id)sender {
    [_percentTextField setStringValue:[NSString stringWithFormat:@"%d", _percentSlider.integerValue]];
    [self updateRightImage];
}

- (void)imageDropped:(id)sender {
}

- (void)saveClicked:(id)sender {
}

@end
