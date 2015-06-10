//
//  ImageListTableViewController.m
//  image-picker-uw-ios-hw5
//
//  Created by Parker, Carl (HBO) on 5/19/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//


#import "ImageListTableViewController.h"
#import "GetImageViewController.h"
#import "GetImageNavController.h"


static NSString * imageTableCellID = @"imageCell";
static NSString * customImageCellID = @"customImageCell";

// NSMutableArray * imageInfoList;


@interface ImageListTableViewController ()

@end


@implementation ImageListTableViewController


-(instancetype)initWithImageList:(NSMutableArray *)imageList {
    
    self = [super init];
    
    if (self)
    {
        
        self.imageInfoList = imageList;
        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    
    self.navigationItem.title = @"Checkin Gallery";
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(getImage:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    //
    // Following Shawn's guidance here.
    // For some reason, need to register the custom cell explicitly.
    //
//    [self.tableView registerClass:[ImageTableViewCell class] forCellReuseIdentifier:customImageCellID];
    
    self.tableView.rowHeight = 140;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.imageInfoList.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customImageCellID  forIndexPath:indexPath];
    
    ImageInfo *imageInfo = (ImageInfo *)self.imageInfoList[indexPath.row];
    
    cell.tableImage.image = imageInfo.image;

    //
    // Convert the date taken into a form we can display in the table
    //
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    cell.tableDate.text  = [dateFormatter stringFromDate:imageInfo.dateTaken];
    
    return cell;
    
}

- (IBAction)getImage:(id)sender
{
    NSLog(@"%@", @"Custom Button Clicked");

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GetImageNavController *getImageNavController = [sb instantiateViewControllerWithIdentifier:@"GetImageNav"];
    
    GetImageViewController *getImageViewController  = (GetImageViewController *)getImageNavController.topViewController;
    
    NSLog(@"%@", getImageViewController);
    
    getImageViewController.getImageDelegate = self;
    
    [self presentViewController:getImageNavController animated:YES completion:nil];
    
}


- (void)getImageViewController:(GetImageViewController *)getImageViewController didGetImageInfo:(ImageInfo *)imageInfo {
    
    [self.imageInfoList addObject:imageInfo];
    
    [self.tableView reloadData];
    
}


//
// This outlet is called when the Cancel button is tapped to
// dismisss the add-birthday UX.
//
- (IBAction)unwindToList:(UIStoryboardSegue *)segue; {
    
    NSLog(@"%@", @"Done button dismissal of pick image UX");
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
