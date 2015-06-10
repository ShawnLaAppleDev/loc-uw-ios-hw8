# Homework 7 :: CP 125 iOS App Dev, Spring 2015 #

The files for this homework are also available at the following
repository on GitHub:

>  <https://github.com/carljparker/settings-uw-ios-hw7>

This homework builds on the checkin application by adding a saved
setting that is implemented with an app bundle, so that the setting can
be updated using the Settings app on the device.

The setting stores a boolean value which determines whether the checkin
application saves a checkin image taken with the device's camera to the
device's photo album. If YES, the image is saved. The default value, in
the absence of the user changing the setting, is NO.

## Implementation Notes ##

I should save the image only if the image is taken with the camera, not
if the image is just picked from the photo album. However, the method
that would save the image 

    -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

doesn't receive the source as one of its parameters. Therefore, I have
added a private property to the **GetImageViewController** class,
`imageSourceType`, which makes the source type available.

The other condition that must hold in order to save the image is that
the `SaveCameraPhoto` setting should be YES. I added the method 

    - (BOOL) shouldSaveToPhotoAlbum

which synchronizes the app with the settings that are in the bundle and
returns the value of `SaveCameraPhoto`.


## Supported Devices ##

I've tested the app on the simulator with an iPhone 5s configuration and
on my own iPhone 5s. 

I also tested on the simulator with an iPad Retina configuration, but
this resulted in a crash with a message that I needed to present using a
popover controller.


## Fixes ##

Between HW6 and this HW, I fixed an issue that caused the table view to
display _very small_ renderings of the photos saved for a particular
location. The photos are now rendered in a reasonable size. This fix
also results in the table view displaying the date on which the photo
was added.


## Known Issues ##


### New Issues ###

The app crashed reproducibly when I tried to run it on the simulator
with an iPad Retina configuration. Based on the error message, this
device seems to require the use of a popover controller. I did not
investigate this issue any further.


### Issues from Previous Releases ###

The app continues to have the following issues which were in the
original checkin app and have carried over to this version.

- The pins which identify locations on the map do not implement a custom
button to checkin for that location, but instead use just the standard
detail disclosure button: (i).  This is a usability issue.

- When the user selects a location, the app simply saves the _title_ of
the location, which in most cases is actually the address. It would be
much better to derive a place name and store that in the checkin list.

- The app enables the user to save multiple instances of the same
location.

I have ideas about how to fix these things and since this code will be
the foundation for the next two HW assignments, I might end up fixing
some of them. But for this assignment, it is time to call it good and
move on.


*** END ***

