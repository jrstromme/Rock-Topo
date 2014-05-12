//
//  cameraView.h
//  Rock-Topo
//
//  Created by John Stromme on 5/11/14.
//  Copyright (c) 2014 John Stromme. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface cameraView : UIView

@property (nonatomic) AVCaptureSession *session;

@end
