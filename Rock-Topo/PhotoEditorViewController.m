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

@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *cancelPhoto;

- (IBAction)cancelPhotoEditing:(id)sender;


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
    self.photoView.image = self.rockPhoto;
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
    [self performSegueWithIdentifier:@"cancelEditorSegue" sender:self];
}
@end
