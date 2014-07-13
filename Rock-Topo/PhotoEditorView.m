//
//  PhotoEditorView.m
//  Rock-Topo
//
//  Created by John Stromme on 5/11/14.
//  Copyright (c) 2014 John Stromme. All rights reserved.
//

#import "PhotoEditorView.h"
#import "cameraViewController.h"

@interface PhotoEditorView ()


@end

@implementation PhotoEditorView

/*
- (NSString *) tool {
    if (!_tool) {
        _tool = @"";
    }
    return _tool;
}

- (NSMutableArray *) paths {
    if (!_paths) {
        _paths = [[NSMutableArray alloc] init];
    }
    return _paths;
}*/


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.userInteractionEnabled = YES;
    return self;
}




- (void) drawRect:(CGRect)rect {
    
    /*
    if (!self.drawing) {
        self.drawing = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.rockPhoto drawInRect:[[UIScreen mainScreen]bounds]];
    if ([self.tool isEqualToString:@"pen"]){
        if ([self.drawing count] > 0) {
            CGContextSetLineWidth(ctx, 5);
            for (int i=0; i < [self.drawing count]; i++) {
                NSArray *array = [self.drawing objectAtIndex:i];
                if ([array count] > 2) {
                    float x = [[array objectAtIndex:0] floatValue];
                    float y = [[array objectAtIndex:1] floatValue];
                    CGContextBeginPath(ctx);
                    CGContextMoveToPoint(ctx, x, y);
                    for (int j = 2; j < [array count]; j+=2) {
                        x = [[array objectAtIndex:j] floatValue];
                        y = [[array objectAtIndex:j+1] floatValue];
                        CGContextAddLineToPoint(ctx, x, y);
                    }
                    CGContextStrokePath(ctx);
                }
            }
        }
    }
    */
    [self.rockPhoto drawInRect:[[UIScreen mainScreen]bounds]];
    
    //THIS IS THE PART THAT IS RUNNING SLOW. NEED TO SUBVIEW????
    
    /*
    if ([self.tool isEqualToString:@"pen"] || [self.tool isEqualToString:@"straight"]){
        [[UIColor blackColor] setStroke];
        for (UIBezierPath *tempPath in self.paths) {
            [tempPath stroke];
        }
        //[self.path stroke];
        //[self.straightPath stroke];
    }*/
}



@end
