//
//  PhotoEditorView.h
//  Rock-Topo
//
//  Created by John Stromme on 5/11/14.
//  Copyright (c) 2014 John Stromme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoEditorView : UIView

@property (nonatomic, strong) UIImage *rockPhoto;

@property (strong, nonatomic) NSMutableArray * drawing;

@property (strong,nonatomic) NSString *color;

//@property (strong, nonatomic) NSString *tool;

//@property (strong, nonatomic) NSMutableArray *paths;


@end
