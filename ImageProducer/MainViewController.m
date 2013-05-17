//
//  MainViewController.m
//  ImageProducer
//
//  Created by clowwindy on 5/16/13.
//  Copyright (c) 2013 clowwindy. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
    NSData *bitmapData;
}

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

- (void)load {
}

- (void)updateRightImage {
    if (_leftImageView.image) {
        NSArray *representations;
        representations = [_leftImageView.image representations];
        bitmapData = [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.01 * _percentSlider.floatValue] forKey:NSImageCompressionFactor]];
        NSImage *rightImage = [[NSImage alloc] initWithData:bitmapData];
        _rightImageView.image = rightImage;
        [_fileSizeTextField setIntegerValue:bitmapData.length];
    }
}

- (void)sliderChanged:(id)sender {
    [_percentTextField setStringValue:[NSString stringWithFormat:@"%d", _percentSlider.integerValue]];
    [self updateRightImage];
}

- (void)imageDropped:(id)sender {
    [self sliderChanged:_percentSlider];
    NSImage *image = _leftImageView.image;
    [_resolutionTextField setStringValue:[NSString stringWithFormat:@"%d * %d", (int)image.size.width, (int)image.size.height]];
}

- (void)saveClicked:(id)sender {
    NSString *filename = [NSString stringWithFormat:@"%lld.jpg", (uint64_t)([[NSDate date] timeIntervalSince1970])];
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDownloadsDirectory inDomains:NSUserDomainMask] lastObject];
    if (url) {
        BOOL result = [bitmapData writeToURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", url, filename]] atomically:YES];
        if (!result) {
            NSAlert *alert = [[NSAlert alloc] init];
            alert.messageText = @"保存失败";
            [alert runModal];
        }
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = @"保存失败，找不到下载目录";
        [alert runModal];
    }
}

- (void)setSliderValue:(id)sender {
    NSButton *button = sender;
    [_percentSlider setStringValue:button.title];
    [self sliderChanged:_percentSlider];
}

@end
