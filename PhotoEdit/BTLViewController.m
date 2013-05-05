//
//  BTLViewController.m
//  PhotoEdit
//
//  Created by Benedikt Lotter on 5/4/13.
//  Copyright (c) 2013 Benedikt Lotter. All rights reserved.
//

#import "BTLViewController.h"
#import <Social/Social.h>
#import <CoreImage/CoreImage.h>

@interface BTLViewController ()




@end

@implementation BTLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add adorable axolotl picture
    UIImage *summit = [UIImage imageNamed:@"summit.jpg"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(goCrazy)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = YES;
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)filter1:(id)sender {
    
    NSLog(@"filter1 called");
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"summit" ofType:@"jpg"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    CIImage *beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    

    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    CIImage *outputImage = [filter outputImage];
    
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    self.imageView.image = newImage;
}

- (IBAction)filter2:(id)sender {
    
    NSLog(@"filter2 called");
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"summit" ofType:@"jpg"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    CIImage *beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    
    
    CIFilter *filter = [CIFilter filterWithName:@"CICrystallize"];
    //CIAttributeTypeDistance *radius =
    [filter setValue:beginImage forKey:kCIInputImageKey];
    //[filter set]
    CIImage *outputImage = [filter outputImage];
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    self.imageView.image = newImage;
}

- (IBAction)filter3:(id)sender {
    
    NSLog(@"filter3 called");
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"summit" ofType:@"jpg"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    CIImage *beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    
    
    CIFilter *filter = [CIFilter filterWithName:@"CIDepthOfField"];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    CIImage *outputImage = [filter outputImage];
    
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    self.imageView.image = newImage;

}


- (IBAction)restoreImage:(id)sender {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"summit" ofType:@"jpg"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    CIImage *originalImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    UIImage *outImage = [UIImage imageWithCIImage:originalImage];
    self.imageView.image = outImage;
    
}


- (IBAction)tweet:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Check this out!"];
        [tweetSheet addImage:[self.imageView image]];
        [tweetSheet addURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=f-oyjdZD-lY"]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (IBAction)email:(id)sender {
    
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
        mailComposeViewController.mailComposeDelegate = self;
        [mailComposeViewController setSubject:@"Test email."];
        [mailComposeViewController setToRecipients:@[@"foobar@me.com"]];
        [mailComposeViewController setMessageBody:@"Check this out!" isHTML:NO];
        
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControlleDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
