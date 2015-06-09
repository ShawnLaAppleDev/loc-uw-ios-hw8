//
//  CheckinListTableViewController.m
//  checkins-uw-ios-hw6
//
//  Created by Parker, Carl (HBO) on 5/31/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//


#import "CheckinListTableViewController.h"
#import "CheckinTableViewCell.h"
#import "MapViewController.h"

#import "ImageListTableViewController.h"


static NSString *checkinCustomTableCellID = @"checkinCustomCell";


@interface CheckinListTableViewController ()

@property (nonatomic, strong) NSMutableArray *checkinInfoList;

@end

// NSMutableArray *checkinInfoList;


@implementation CheckinListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.checkinInfoList = [[NSMutableArray alloc] init];
    
    self.tableView.delegate = self;
    
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
    return self.checkinInfoList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CheckinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:checkinCustomTableCellID forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    CheckinInfo * checkinInfo = (CheckinInfo *)self.checkinInfoList[indexPath.row];
    
    cell.checkinLocation.text = checkinInfo.location;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", @"didSelectRowAtIndexPath");
    
    CheckinInfo * checkinInfo = (CheckinInfo *)self.checkinInfoList[indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ImageListTableViewController * imageListTableViewController = [sb instantiateViewControllerWithIdentifier:@"MyImageGallery"];
    
    imageListTableViewController.imageInfoList = checkinInfo.imageInfoList;

//    ImageListTableViewController * imageListTableViewController = [[ImageListTableViewController alloc] initWithImageList:checkinInfo.imageInfoList];
    
    [[self navigationController] pushViewController:imageListTableViewController animated:YES];
    
    
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", @"accessoryButtonTappedForRowWithIndexPath");
}


//
// This outlet is called when the Cancel button is tapped to
// dismisss the add-birthday UX.
//
- (IBAction)unwindToList:(UIStoryboardSegue *)segue; {
    
    NSLog(@"%@", @"Done button dismissal of map view & search UX");
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     [super prepareForSegue:segue sender:sender];
    
     //
     // Note that this code doesn't instantiate either the nav or the view controller.
     // By the time that this method, prepareForSegue, is called these destination nav
     // controller and its top view controller already exist. We are just getting
     // references to them here.
     //
     // It is interesting to note also that they use the term "top view controller" here
     // rather than "root view controller"
     //
    UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
    
    MapViewController *mapViewController = (MapViewController *)navigationController.topViewController;
    
    mapViewController.delegate = self;
    
}


- (void)mapViewController:(MapViewController *)mapViewController didGetCheckinInfo:(CheckinInfo *)checkinInfo {
    
    [self.checkinInfoList addObject:checkinInfo];
    
    [self.tableView reloadData];
    
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
