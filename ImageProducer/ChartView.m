//
// Created by clowwindy on 5/18/13.
//
//


#import <QuartzCore/QuartzCore.h>
#import "ChartView.h"


@implementation ChartView {
    float *_points;
    NSInteger _numberOfPoints;
}

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        _points = NULL;
        _numberOfPoints = 0;
    }

    return self;
}


- (void)renderChart:(const float *)points numberOfPoints:(NSInteger)numberOfPoints {
    if (_points != NULL) {
        free(_points);
    }
    if (numberOfPoints <= 0) {
        return;
    }
    _numberOfPoints = numberOfPoints;
    size_t size = sizeof(float) * 2 * numberOfPoints;
    _points = malloc(size);
    memcpy(_points, points, size);
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect {
    NSGraphicsContext *gcontext = [NSGraphicsContext currentContext];
    CGContextRef context = (CGContextRef)[gcontext graphicsPort];
    CGContextSetStrokeColorSpace(context, CGColorSpaceCreateDeviceRGB());

    // find max
    float maxX = 0, maxY = 0;
    for (int i = 0; i < _numberOfPoints; i++) {
        if (_points[i * 2] > maxX) {
            maxX = _points[i * 2];
        }
        if (_points[i * 2 + 1] > maxY) {
            maxY = _points[i * 2 + 1];
        }
    }
    CGFloat blackColor[] = {0, 0, 0, 0.3};
    CGContextSetStrokeColor(context, blackColor);
    CGContextSetLineWidth(context, 1);
    CGFloat scaleX = self.frame.size.width / maxX;
    CGFloat scaleY = self.frame.size.height / maxY;
    for (int i = 0; i < _numberOfPoints; i++) {
        if (i == 0) {
            CGContextMoveToPoint(context, _points[i * 2] * scaleX, _points[i * 2 + 1] * scaleY);
        }
        CGContextAddLineToPoint(context, _points[i * 2] * scaleX, _points[i * 2 + 1] * scaleY);
    }
    CGContextDrawPath(context, kCGPathStroke);
}

@end