# Homework 7 :: CP 125 iOS App Dev, Spring 2015 #

The files for this homework are also available at the following
repository on GitHub:

>  <https://github.com/carljparker/settings-uw-ios-hw7>

This homework implements a simple checkin app that enables the user to
search for nearby locations on a map view and select one, which is then
stored in a list. The list is displayed in a table view. By tapping a
row in this table view, the user can add images using the photo library
or the device's camera. These images are associated with the checkin
location for the row that the user tapped.

The basic functionality described above works. That said there are a
number of things about the app that could be improved.

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


## Implementation Issues (or Discoveries) ##

The following issues (or perhaps _discoveries_) came up in the process
of implementing the homework.


### Cannot Push a Navigation Controller ###

It doesn't appear to be possible for a navigation controller to push
another navigation controller.

The following code compiles but fails at runtime with the error:
`'NSInvalidArgumentException', reason: 'Pushing a navigation controller
is not supported'`

    GetImageViewController *getImageViewController = [[GetImageViewController alloc] init];
    GetImageNavController *getImageNavController = [[GetImageNavController alloc] initWithRootViewController:getImageViewController];
    
    [[self navigationController] pushViewController:getImageNavController animated:YES];


### Cannot Segue from a View Controller Embedded in a Nav Controller ###

I tried to do a segue to a navigation controller from a VC embedded in a
navigation controller. 

    - (IBAction)getImage:(id)sender
    {
        NSLog(@"%@", @"Custom Button Clicked");
        [self performSegueWithIdentifier:@"getImage" sender:self];
    }

This failed with an error that said that the sending VC did not have a
segue with the identifier that I specified in the
`performSegueWithIdentifier` call--even though it did. We spent a lot of
time at NSCoders trying to understand why it was failing. We couldn’t
come up with a good explanation, but I did discover that the same segue
works if I am coming from just a VC rather than a VC embedded in a nav
controller. 


## Questions ##

The following questions came up during the course of this homework
assignment. I posted these to the class discussion board.

### What is the Correct LocationManager Request for NSLocationUsageDescription? ###

When we went through the demo for location services, we used some code
similar to the following to request a particular class of authorization
from the user.

    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
          [self.locationManager requestWhenInUseAuthorization];
      }

We determined that the message sent to self.locationManager above needed
to mirror the value that we specified in Info.plist, one of the
following:

    NSLocationWhenInUseUsageDescription
    NSLocationAlwaysUsageDescription

However, if you use Xcode to edit Info.plist and you select a value from
the drop-down list, you get the following friendly string:

    Privacy - Location Usage Description

which gives you the following key in the Info.plist XML:

    <key>NSLocationUsageDescription</key>

In this case, what would be the corresponding message for
`[self.locationManager ...]` to request the user's permissions?  

I did not see anything in the Xcode autocomplete that corresponds to
this key. And if I use either of the other `request...` messages, the
user isn't presented the request to enable location services.


### Why is id<> Required for MKAnnotation? ###

Why do I have to surround the type MKAnnotation with `id<...>`?

I use the following code to remove existing annotations from a MapView
before placing new annotations on it. The `id<...>` around MKAnnotation
seems to be required.

    for (id<MKAnnotation> annotation in self.mapView.annotations )
    {
      [self.mapView removeAnnotation:annotation];
    }


*** END ***

