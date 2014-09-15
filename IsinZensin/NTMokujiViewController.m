//
//  NTMokujiViewController.m
//  IsinZensin
//
//  Created by ビザンコムマック０９ on 2014/09/12.
//  Copyright (c) 2014年 ビザンコムマック０９. All rights reserved.
//

#import "NTMokujiViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "NTSerifu2ViewController.h"
#import "NTTableViewCell_1.h"

@interface NTMokujiViewController ()
{

@private
	
	NSArray        *array_Mokuji;
	NSMutableArray *array_Original;

}

@end

@implementation NTMokujiViewController

- (id)initWithStyle:(UITableViewStyle)style
{

    self = [super initWithStyle:style];
    
	if (self) {
        // Custom initialization
    }
    
	return self;

}

- (void)viewDidLoad
{

    [super viewDidLoad];
    
	// 固定台詞定義
	array_Mokuji = [NSArray arrayWithObjects: @"あいさつ", @"日常会話", @"わかれ", nil];
	
	// オリジナル台詞定義
	array_Original = [[NSMutableArray alloc] init];
	
	[array_Original addObject: @"11111"];
	
	
	//self.tableView.allowsMultipleSelection = NO;
	
	// テーブルデリを設定
	self.tableView.delegate = self;
		
	
	self.navigationItem.title = @"タイトル";
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
																			   target: self
																			   action: @selector(insertNewObject:)];
	self.navigationItem.rightBarButtonItem = addButton;

}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];

}

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{

    return 3;

}

- (NSInteger)tableView: (UITableView *)tableView
 numberOfRowsInSection: (NSInteger)section
{

	if ( section == 0 ) {
		
		return 1;
		
	} else if ( section == 1 ) {
		
		return [array_Mokuji count];
		
	} else if ( section == 2 ) {
		
		return [array_Original count];
		
	} else {
		
		return 0;
		
	}
	
}

- (UITableViewCell *)tableView: (UITableView *)tableView
		 cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    
	UITableViewCell *cell = nil;
	
    if ( indexPath.section == 0 ) {
		
		NTTableViewCell_1 *cell_1 = [tableView dequeueReusableCellWithIdentifier: @"Cell_1"
																	forIndexPath: indexPath];
		
		cell_1.switch_Rokuon = NO;
		
		cell = cell_1;
		
	} else if ( indexPath.section == 1 ) {
		
		cell = [tableView dequeueReusableCellWithIdentifier: @"Cell_2"
											   forIndexPath: indexPath];
		
		cell.textLabel.text = [array_Mokuji objectAtIndex: indexPath.row];
		
	} else if ( indexPath.section == 2 ) {
		
		cell = [tableView dequeueReusableCellWithIdentifier: @"Cell_2"
											   forIndexPath: indexPath];
		
		cell.textLabel.text = [array_Original objectAtIndex: indexPath.row];
		
	}

    return cell;
	
}

- (void)tableView: (UITableView *)tableView
  willDisplayCell: (UITableViewCell *)cell
forRowAtIndexPath: (NSIndexPath *)indexPath
{
	
}

- (void)insertNewObject:(id)sender
{
	
    /*if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];*/
	
}

- (BOOL)    tableView: (UITableView *)tableView
canEditRowAtIndexPath: (NSIndexPath *)indexPath
{

    // Return NO if you do not want the specified item to be editable.
    return YES;

}

- (void) tableView: (UITableView *)tableView
commitEditingStyle: (UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath: (NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // [mokuji removeObjectAtIndex: indexPath.row];
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }

}

- (NSIndexPath *)tableView: (UITableView *)tableView
  willSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
	
	NSInteger section = indexPath.section;
	//NSInteger row     = indexPath.row;
	
	NSLog( @"willSelect = %d", section );
	
	if ( section == 0 ) {
		
		NSLog( @"return = nil" );

		return nil;

	} else if ( section == 1 ) {
		
		return indexPath;
		
	} else if ( section == 2 ) {
		
		NSLog( @"return = nil" );
		
		return nil;

	}
	
	NSLog( @"return = nil" );
	
	return nil;

}


- (void)      tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    

	/*[self performSegueWithIdentifier: @"showDetail"
                              sender: [NSString stringWithFormat:@"%d", indexPath.row + 1]];*/

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

	/*NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
	NSInteger section = indexPath.section;
	NSInteger row     = indexPath.row;
	
	if ( section == 0 ) {
		
	} else if ( section == 1 ) {
		
		id tanmatu = [segue destinationViewController];
		
		[tanmatu setDetailItem: array_Mokuji[row]];
		
	} else if ( section == 2 ) {
		
	}*/
	
	if ( [[segue identifier] isEqualToString: @"showDetail_2"] ) {
		
		id tanmatu = [segue destinationViewController];
		
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		
		[tanmatu setDetailItem: array_Mokuji[indexPath.row]];
		
	}

}

@end
