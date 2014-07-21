//
//  cameraViewController.h
//  Rock-Topo
//
//  Created by John Stromme on 5/11/14.
//  Copyright (c) 2014 John Stromme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cameraViewController : UIViewController

@property (nonatomic,readonly) UIImage *capturedImage;

@property (nonatomic) BOOL loadWithCamera;

@end
