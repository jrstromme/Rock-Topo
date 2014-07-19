//
//  PhotoEditorViewController.m
//  Rock-Topo
//
//  Created by John Stromme on 5/11/14.
//  Copyright (c) 2014 John Stromme. All rights reserved.
//

#import "PhotoEditorViewController.h"
#import "PhotoEditorView.h"
#import "cameraViewController.h"
#import "DrawingOverlay.h"
#import "SaveImageSettingsViewController.h"

@interface PhotoEditorViewController ()

@property (strong, nonatomic) IBOutlet PhotoEditorView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *cancelPhoto;

@property (weak, nonatomic) IBOutlet UIButton *toggleEditingToolsButton;

@property (weak, nonatomic) IBOutlet UIButton *lineButton;
@property (weak, nonatomic) IBOutlet UIButton *straightButton;

@property (weak, nonatomic) IBOutlet UIButton *saveImageButton;

@property (weak, nonatomic) IBOutlet UIButton *undoButton;

@property CGPoint staticPoint;

@property NSString *tool;

@property (strong, nonatomic) UIBezierPath *path;

@property (strong, nonatomic) DrawingOverlay *drawingOverlay;

@end

@implementation PhotoEditorViewController


#pragma mark - Lazy-Instantiation
- (DrawingOverlay *) drawingOverlay {
    if (!_drawingOverlay){
        _drawingOverlay = [[DrawingOverlay alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    }
    return _drawingOverlay;
}


-(UIBezierPath *) path {
    if (!_path){
        _path = [UIBezierPath bezierPath];
        [_path setLineWidth:4.0];
    }
    return _path;
}


#pragma mark - classic-overrides
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.photoView addSubview:self.drawingOverlay];
    [self.photoView sendSubviewToBack:self.drawingOverlay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //LoadPhotoFromDirectory
    self.photoView.rockPhoto = self.rockPhoto;
    
    [self.photoView setNeedsDisplay];
    self.photoView.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"pushToRouteInfo"]) {
        SaveImageSettingsViewController *destination = segue.destinationViewController;
        destination.imageToSave = self.rockPhoto;
    }
}


#pragma mark - Button-Work

- (IBAction)cancelPhotoEditing:(id)sender {
    [self exitEditor];
}

- (void) exitEditor{
    [self performSegueWithIdentifier:@"cancelEditorSegue" sender:self];
}

- (IBAction)toggleEditingTools:(id)sender {
    
    if ([self.toggleEditingToolsButton.currentTitle  isEqual: @"X"]) {
        [self hideTools];
        [self deselectTools];
        [self.toggleEditingToolsButton setTitle:@"Pen" forState:UIControlStateNormal];
    } else {
        [self showTools];
    }
}

- (void) hideTools {
    self.lineButton.hidden = YES;
    self.straightButton.hidden = YES;
    [self.toggleEditingToolsButton setTitle:self.tool forState:UIControlStateNormal];
}

- (void) showTools {
    self.lineButton.hidden = NO;
    self.straightButton.hidden = NO;
    [self.toggleEditingToolsButton setTitle:@"X" forState:UIControlStateNormal];
}

- (IBAction)selectPenTool:(id)sender {
    self.tool = @"pen";
    [self hideTools];
}

- (IBAction)selectStraightLine:(id)sender {
    self.tool = @"straight";
    [self hideTools];
}

- (void)deselectTools {
    self.tool = nil;
}

- (IBAction)undo:(id)sender {
    [self.drawingOverlay.paths removeLastObject];
    [self.drawingOverlay setNeedsDisplay];
}


- (IBAction)saveImage:(id)sender {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //Need to implement code to first remove overlying buttons etc...
    [self.cancelPhoto removeFromSuperview];
    [self.toggleEditingToolsButton removeFromSuperview];
    [self.lineButton removeFromSuperview];
    [self.saveImageButton removeFromSuperview];
    [self.undoButton removeFromSuperview];
    UIImage *finishedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.rockPhoto = finishedImage;
    //UIImageWriteToSavedPhotosAlbum(finishedImage, self, @selector(finishedSaveImage:didFinishSavingWithError:contextInfo:), nil);
    [self performSegueWithIdentifier:@"pushToRouteInfo" sender:self];
}

- (void) finishedSaveImage: (UIImage *) Image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [self exitEditor];
}


#pragma mark - Drawing-touches

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.tool isEqualToString:@"pen"]) {
         UITouch *touch = [touches anyObject];
         CGPoint p = [touch locationInView:self.photoView];
         [self.path moveToPoint:p];
        
    } else if ([self.tool isEqualToString:@"straight"]) {
        UITouch *touch = [touches anyObject];
        CGPoint p = [touch locationInView:self.photoView];
        self.staticPoint = p;
    }
    [self.drawingOverlay.paths addObject:self.path];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.tool isEqualToString:@"pen"]){
         UITouch *touch = [touches anyObject];
         CGPoint p = [touch locationInView:self.photoView];
         [self.path addLineToPoint:p];
         [self.drawingOverlay setNeedsDisplay];
    } else if ([self.tool isEqualToString:@"straight"]) {
        UITouch *touch = [touches anyObject];
        CGPoint p = [touch locationInView:self.photoView];
        [self.path removeAllPoints];
        [self.path moveToPoint:self.staticPoint];
        [self.path addLineToPoint:p];
        [self.drawingOverlay.paths removeLastObject];
        [self.drawingOverlay.paths addObject:self.path];
        [self.drawingOverlay setNeedsDisplay];
    }
    
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.tool isEqualToString:@"pen"]) {
        [self touchesMoved:touches withEvent:event];
        self.path = nil;
    } else if ([self.tool isEqualToString:@"straight"]) {
        [self touchesMoved:touches withEvent:event];
    }
    self.path = nil;
    
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.tool isEqualToString:@"pen"]) {
        [self touchesMoved:touches withEvent:event];
    } else if ([self.tool isEqualToString:@"straight"]) {
        [self touchesMoved:touches withEvent:event];
    }
    self.path = nil;
}






@end
