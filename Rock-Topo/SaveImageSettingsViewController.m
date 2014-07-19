//
//  SaveImageSettingsViewController.m
//  Rock-Topo
//
//  Created by John Stromme on 7/13/14.
//  Copyright (c) 2014 John Stromme. All rights reserved.
//

#import "SaveImageSettingsViewController.h"
#import "SaveImageSettingsView.h"
#import "NSMutableDictionary+ImageMetadata.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

@interface SaveImageSettingsViewController ()

@property (strong, nonatomic) NSMutableDictionary *exif;
@property (weak, nonatomic) IBOutlet UIButton *saveImage;
@property CLLocationManager *manager;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnail;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;
@property (weak, nonatomic) IBOutlet UITextField *routeName;
@property (weak, nonatomic) IBOutlet UITextField *routeRating;
@property (weak, nonatomic) IBOutlet UIImageView *imageSavedBackground;

@end

@implementation SaveImageSettingsViewController

- (NSMutableDictionary *) exif {
    if (!_exif) {
        _exif = [[NSMutableDictionary alloc] init];
    }
    return _exif;
}

- (IBAction)tapRecognizer:(id)sender {
    [self.captionTextField resignFirstResponder];
    [self.routeName resignFirstResponder];
    [self.routeRating resignFirstResponder];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.imageThumbnail.image = self.imageToSave;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.manager = [[CLLocationManager alloc]init];
    [self getCurrentLocation];
    self.captionTextField.delegate = self;
    self.captionTextField.tag = 1;
    self.routeName.delegate = self;
    self.routeName.tag = 2;
    self.routeRating.delegate = self;
    self.routeRating.tag = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger textLength = string.length + textField.text.length;
    if (textField.tag == 1) {
        if (textLength > 160) {
            return NO;
        }
    } else if (textField.tag == 2 || textField.tag == 3){
        if (textLength > 30) {
            return NO;
        }
    }
    return YES;
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

- (CLLocation *) getCurrentLocation {
    //self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
    
    return self.manager.location;
}

- (IBAction)saveImageWithMetadata:(id)sender {
    //set up metadata
    [self.exif setImageOrientation:UIImageOrientationRight];
    if (![self.captionTextField.text isEqualToString:@""]) {
        [self.exif setUserComment:self.captionTextField.text];
    }
    //write everything
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:self.imageToSave.CGImage metadata:self.exif completionBlock:^(NSURL *assetURL, NSError *error){
        [self.imageSavedBackground setHidden:NO];
        UIImage *img = [UIImage imageNamed:@"saveScreen"];
        self.imageSavedBackground.image = img;
        [self performSelector:@selector(segueBackToCamera) withObject:self afterDelay:0.5];
    }];
}

- (void) segueBackToCamera {
    [self performSegueWithIdentifier:@"returnToCamera" sender:self];
}

@end
