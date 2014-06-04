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

@interface PhotoEditorViewController ()

@property (strong, nonatomic) IBOutlet PhotoEditorView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *cancelPhoto;

@property (weak, nonatomic) IBOutlet UIButton *toggleEditingToolsButton;

@property (weak, nonatomic) IBOutlet UIButton *lineButton;

@property (weak, nonatomic) IBOutlet UIButton *saveImageButton;

@end

@implementation PhotoEditorViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelPhotoEditing:(id)sender {
    [self exitEditor];
}

- (void) finishedSaveImage: (UIImage *) Image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [self exitEditor];
}


- (void) exitEditor{
    [self performSegueWithIdentifier:@"cancelEditorSegue" sender:self];
}

- (IBAction)toggleEditingTools:(id)sender {
    
    if ([self.toggleEditingToolsButton.currentTitle  isEqual: @"Pen"]) {
        self.lineButton.hidden=NO;
        [self.toggleEditingToolsButton setTitle:@"X" forState:UIControlStateNormal];
    } else if ([self.toggleEditingToolsButton.currentTitle  isEqual: @"X"]) {
        self.lineButton.hidden=YES;
        [self.toggleEditingToolsButton setTitle:@"Pen" forState:UIControlStateNormal];
    }
}
- (IBAction)selectPenTool:(id)sender {
    self.photoView.tool = @"pen";
}
- (IBAction)saveImage:(id)sender {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //Need to implement code to first remove overlying buttons etc...
    UIImage *finishedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(finishedImage, self, @selector(finishedSaveImage:didFinishSavingWithError:contextInfo:), nil);
}



- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.photoView.tool isEqualToString:@"pen"]) {
        [self.photoView.drawing addObject:[[NSMutableArray alloc]initWithCapacity:4]];
        CGPoint curPoint = [[touches anyObject] locationInView:self.photoView];
        [self.photoView.drawing.lastObject addObject:[NSNumber numberWithFloat:curPoint.x]];
        [self.photoView.drawing.lastObject addObject:[NSNumber numberWithFloat:curPoint.y]];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.photoView.tool isEqualToString:@"pen"]){
        CGPoint curPoint = [[touches anyObject] locationInView:self.photoView];
        [self.photoView.drawing.lastObject addObject:[NSNumber numberWithFloat:curPoint.x]];
        [self.photoView.drawing.lastObject addObject:[NSNumber numberWithFloat:curPoint.y]];
        [self.photoView setNeedsDisplay];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.photoView.tool isEqualToString:@"pen"]) {
        CGPoint curPoint = [[touches anyObject] locationInView:self.photoView];
        [self.photoView.drawing.lastObject addObject:[NSNumber numberWithFloat:curPoint.x]];
        [self.photoView.drawing.lastObject addObject:[NSNumber numberWithFloat:curPoint.y]];
        [self.photoView setNeedsDisplay];
        NSLog(@"end touch");
    }
}






@end
