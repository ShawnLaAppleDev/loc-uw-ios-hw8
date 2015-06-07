# Homework 7 :: CP 125 iOS App Dev, Spring 2015 #

The files for this homework are also available at the following
repository on GitHub:

>  <https://github.com/carljparker/settings-uw-ios-hw7>

This homework builds on the checkin application by adding a saved
setting using an app bundle, so that the setting can be updated using
the Settings app on the device.

The setting stores a boolean value which determines whether the checkin
application saves a checkin image taken with the device's camera to the
devices photo album. If YES, the image is saved. The default value, in
the absence of the user changing the settings, is NO.

I should save the image only if the image is taken with the camera, not
if the image is just picked from the photo album. However, the method
that would save the image 

    -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

doesn't receive the source as one of its parameters. Therefore, I have
added a private property to the GetImageViewController class,
`imageSourceType`, which makes the source type available.

The other condition that must hold in order to save the image is that
the `SaveCameraPhoto` should be YES. I added the method 

    - (BOOL) shouldSaveToPhotoAlbum

which synchronizes the app with the settings that are in the bundle and
returns the value of `SaveCameraPhoto`.

This homework implements a simple checkin app that enables the user to
search for nearby locations on a map view and select one, which is then
stored in a list. The list is displayed in a table view. By tapping a
row in this table view, the user can add images using the photo library
or the device's camera. These images are associated with the checkin
location for the row that the user tapped.

## Known Issues ##

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

In addition to the above, I'm pretty sure that the app contains some
extraneous code that is not called, but which was introduced when I
experimented with ways to get the view transitions to work. And since
that code is commented, there are also extraneous comments that should
be removed.

I have ideas about how to fix all of these things and since this code
will be the foundation for the next two HW assignments, I might end up
fixing some of them. But for this assignment, it is time to call it good
and move on.


*** END ***

