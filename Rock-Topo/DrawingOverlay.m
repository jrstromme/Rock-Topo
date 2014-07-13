//
//  DrawingOverlay.m
//  Rock-Topo
//
//  Created by John Stromme on 7/13/14.
//  Copyright (c) 2014 John Stromme. All rights reserved.
//

#import "DrawingOverlay.h"

@implementation DrawingOverlay

- (NSMutableArray *) paths {
    if (!_paths) {
        _paths = [[NSMutableArray alloc] init];
    }
    return _paths;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setOpaque:NO];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor redColor] setStroke];
    for (UIBezierPath *tempPath in self.paths) {
        [tempPath stroke]; }
}


@end
