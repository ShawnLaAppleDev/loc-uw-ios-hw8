//
//  GetImageViewController.m
//  
//
//  Created by Parker, Carl (HBO) on 5/18/15.
//
//

#import "AppDelegate.h"
#import "GetImageViewController.h"
#import "ImageInfo.h"

//
// This is a source type that we don't access photos from,
// so use this as a value that represents that we haven't set
// the source type yet.
//
static UIImagePickerControllerSourceType const unSetSourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

@interface GetImageViewController ()

@property UIImagePickerControllerSourceType imageSourceType;

@end

@implementation GetImageViewController


-(instancetype)init {
    
    self = [super init];
    
    if (self)
    {
        //
        // Set this to a value that represents a source we don't use
        //
        self.imageSourceType = unSetSourceType;
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)captureImageIconTapped:(id)sender {
    
    BOOL isCameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    BOOL isPhotoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Image Source", @"Image Source");
                                                                message:NSLocalizedString(@"Select the Source from Which to Capture the Image.", @"Select the Source from Which to Capture the Image.");
                                                         preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (isCameraAvailable) {
        [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString( @"Camera", @"Camera");
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
                                                 NSLog(@"Image Src: Camera");
                                                 
                                                 [self _presentImagePicker:UIImagePickerControllerSourceTypeCamera];
                                             }]];
    }
    
    if (isPhotoLibraryAvailable) {
        [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString( @"Photo Library", @"Photo Library");
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
                                                 NSLog(@"Image Src: Photo Lib");
                                                 
                                                 [self _presentImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
                                                 
                                             }]];
        
    }
    
    [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString( @"Cancel", @"Cancel");
                                           style:UIAlertActionStyleCancel
                                         handler:nil]];
    //
    // Present the action sheet.
    //
    // In the demo, Shawn uses [self showDetailViewController...] here
    //
    [self presentViewController:ac animated:YES completion:nil];

}

-(void) _presentImagePicker:(UIImagePickerControllerSourceType)sourceType {
    
    //
    // Set the property that tracks the source type.
    // We read this property once we have the image,
    // in imagePicerController below, to know whether
    // to save the image to the saved photos album.
    //
    self.imageSourceType = sourceType;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.mediaTypes = @[ (NSString *) kUTTypeImage ];
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSLog( @"@%s", __PRETTY_FUNCTION__ );
    
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    self.displayPickedImageView.image = selectedImage;
    
    //
    // Create an object to access the AppDelegate.
    //
    // I synchronize in the call to shouldSaveToPhotoAlbum
    //
    AppDelegate *aD = [UIApplication sharedApplication].delegate;
    
    if (self.imageSourceType == unSetSourceType) {
        assert("imagePickerController: image source type should be set");
    }
    else if ( (self.imageSourceType == UIImagePickerControllerSourceTypeCamera ) && [aD shouldSaveToPhotoAlbum] ) {
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
    }
    
    ImageInfo *imageInfo = [[ImageInfo alloc] initWithImage:selectedImage];
    
    [self.getImageDelegate getImageViewController:self didGetImageInfo:imageInfo];

    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

//
// Following code taken from techotopia at the following URL:
//
//   http://tinyurl.com/nuwtxnl
//
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *) error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@"Save failed", @"Save failed");
                              message: NSLocalizedString(@"Failed to save image/video", @"Failed to save image/video");
                              delegate: nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK");
                              otherButtonTitles:nil];
        [alert show];
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    NSLog( @"@%s", __PRETTY_FUNCTION__ );
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
