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
    [self.rockPhoto drawInRect:[[UIScreen mainScreen]bounds]];
}



@end
