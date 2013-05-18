//
// Created by clowwindy on 5/18/13.
//
//


#import <Foundation/Foundation.h>


@interface ChartView : NSView

-(void)renderChart:(const float *)points numberOfPoints:(NSInteger)numberOfPoints;

@end