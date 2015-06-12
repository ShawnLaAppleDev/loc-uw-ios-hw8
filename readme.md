# Homework 8 :: CP 125 iOS App Dev, Spring 2015 #

The files for this homework are also available at the following
repository on GitHub:

>  <https://github.com/carljparker/loc-uw-ios-hw8>

**Note** This readme covers only this homework, but this homework
incorporates code and functionality from several previous homeworks. For
information about the implementation and issues associated with those
homeworks, please see the readme files that accompanied them.


This homework builds on the settings version of the checkin application
by adding localization for the German language. 


## Implementation Notes ##

I localized the strings that appear in `Main.storyboard` and also the
user-facing strings that appear in the app itself. I did not localize 
`LaunchScreen.xib` or non-user-facing strings in the app, such as log
output or cell-reuse identifiers.


## Supported Devices ##

I tested the app on the simulator with an iPhone 5s configuration and on
my own iPhone 5s. 

I also tested on the simulator with an iPad Retina configuration, but
this resulted in a crash with a message that I needed to present using a
popover controller.


## Fixes ##

**Partial Fix** Although the app still displays only the address of a
checkin location, I am now retrieving a lot more information about the
location using reverse geocoding. The code that does that is located in:

    File: MapViewController.m
    Method: - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control


## Known Issues ##

### Issues from Previous Releases ###

The app continues to have the following issues which were in the
original checkin app and have carried over to this version.

- The app crashes reproducibly when I try to run it on the simulator
with an iPad Retina configuration. Based on the error message, this
device seems to require the use of a popover controller. I did not
investigate this issue further.

- The pins which identify locations on the map do not implement a custom
button to check in for that location, but instead use just the standard
detail disclosure button: (i).  This is a usability issue.

- When the user selects a location, the app simply saves the _title_ of
the location, which in most cases is actually the address. It would be
much better to derive a place name and store that in the checkin list.

- The app enables the user to save multiple instances of the same
location.


*** END ***

