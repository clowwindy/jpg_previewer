//
//  MainViewController.m
//  ImageProducer
//
//  Created by clowwindy on 5/16/13.
//  Copyright (c) 2013 clowwindy. All rights reserved.
//

#import "MainViewController.h"

#define CHART_SIZE 50

@interface MainViewController () {
    NSData *bitmapData;
    float chartData[2 * CHART_SIZE];
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

- (void)renderChart {
    for (int i = 0; i < CHART_SIZE; i++) {
        float quality = i / (float)(CHART_SIZE - 1);
        NSData *data = [self JPGDataWithImage:_leftImageView.image quality:quality];
        chartData[i * 2] = quality;
        chartData[i * 2 + 1] = data.length;
    }
    [_chartView renderChart:chartData numberOfPoints:CHART_SIZE];
}

- (NSData *)JPGDataWithImage:(NSImage *)image quality:(float)quality {
    NSArray *representations;
    representations = [image representations];
    return [NSBitmapImageRep representationOfImageRepsInArray:representations usingType:NSJPEGFileType properties:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:quality] forKey:NSImageCompressionFactor]];
}

- (void)updateRightImage {
    if (_leftImageView.image) {
        bitmapData = [self JPGDataWithImage:_leftImageView.image quality:0.01 * _percentSlider.floatValue];
        NSImage *rightImage = [[NSImage alloc] initWithData:bitmapData];
        _rightImageView.image = rightImage;
        [_fileSizeTextField setIntegerValue:bitmapData.length];
    } else {
        _rightImageView.image = nil;
        [_fileSizeTextField setIntegerValue:0];
    }
}

- (void)sliderChanged:(id)sender {
    [_percentTextField setStringValue:[NSString stringWithFormat:@"%d", _percentSlider.integerValue]];
    [self updateRightImage];
}

- (void)imageDropped:(id)sender {
    [self sliderChanged:_percentSlider];
    NSImage *image = _leftImageView.image;
    NSData *customimageData = [image TIFFRepresentation];
    NSBitmapImageRep *customimageRep = [NSBitmapImageRep imageRepWithData:customimageData];

    [_resolutionTextField setStringValue:[NSString stringWithFormat:@"%d * %d", customimageRep.pixelsWide, customimageRep.pixelsHigh]];

    [self renderChart];
}

- (void)openFile:(NSString *)filename {
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:filename];
    if (image) {
        _leftImageView.image = image;
        [self imageDropped:self];
    }
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

- (void)windowWillClose:(NSNotification *)notification {
    [[NSApplication sharedApplication] stop:self];
}

@end
