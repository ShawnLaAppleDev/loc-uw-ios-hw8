//
//  GetImageViewController.h
//  
//
//  Created by Parker, Carl (HBO) on 5/18/15.
//
//

#import <UIKit/UIKit.h>
#import "MobileCoreServices/MobileCoreServices.h"
#import "ImageInfo.h"


@class GetImageViewController;


@protocol GetImageViewControllerDelegate <NSObject>

@required

- (void)getImageViewController:(GetImageViewController *)getImageViewController
               didGetImageInfo:(ImageInfo *)imageInfo;

@end


@interface GetImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(instancetype)init;

@property (weak, nonatomic) IBOutlet UIImageView *displayPickedImageView;

@property (nonatomic, weak) id<GetImageViewControllerDelegate> getImageDelegate;

@end
