//
//  NTMokujiViewController.m
//  IsinZensin
//
//  Created by ビザンコムマック０９ on 2014/09/12.
//  Copyright (c) 2014年 ビザンコムマック０９. All rights reserved.
//

#import "NTMokujiViewController.h"

#import "NTAppDelegate.h"
#import "NTSerifu2ViewController.h"
#import "NTTableViewCell_1.h"
#import <AVFoundation/AVFoundation.h>

@interface NTMokujiViewController ()
{

@private
	
	//NSArray        *array_Mokuji;
	NSMutableArray *array_Mokuji;
	//NSMutableDictionary *dir_Mokuji;
	NSMutableArray *array_Original;
	//NSMutableDictionary *dir_Original;

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
    
	NSBundle* bundle = [NSBundle mainBundle];
	
	// 固定台詞定義
	//array_Mokuji = [NSArray arrayWithObjects: @"あいさつ", @"日常会話", @"わかれ", nil];
	array_Mokuji = [[NSMutableArray alloc] init];
	//dir_Mokuji = [[NSMutableDictionary alloc] init];
	
	// 読み込むファイルパスを指定
	NSString *path = [bundle pathForResource:@"TitleSerifu" ofType:@"plist"];
	
	// plistの読み込み
	NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile: path];
	
	// エラーをクリア
	BOOL bool_errorflag = YES;
	
	// Titleの読み込み
	for ( NSString *key in [dic allKeys] ) {
		
		// dirの初期化
		NSMutableDictionary *dir_data = [[NSMutableDictionary alloc] init];
		
		// TitleDataのarray
		NSArray *array = (NSArray *)[dic objectForKey: key];
		
		// TitleDataの読み込み
		for ( id obj in array ) {
		
			// Dataの型を文字列に変換
			NSString *str = NSStringFromClass( [obj class] );
			
			// Dataの型を確認
			//if ( [NSStringFromClass( [obj class] ) isEqualToString: @"NSNumber"] ) {
			// 思った通りにNSNumberにならない
			if ( [str isEqualToString: @"__NSCFNumber"] ) {

				//NSNumber *number = obj;
				
				// 順番を足す
				[dir_data setObject: obj forKey: @"jyunban"];
				
				break;
				
			}
			
		}
		
		// Titleを足す
		[dir_data setObject: key forKey: @"title"];
		
		// dir_dataを足す
		[array_Mokuji addObject: dir_data];
		
	}
	
	// 順番通りにsortする
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"jyunban"
																   ascending: YES];
	
	[array_Mokuji sortUsingDescriptors: @[sortDescriptor]];
	
	// エラー処理
	if ( bool_errorflag ) {
		
	}

	bool_errorflag = YES;
	
	// オリジナル台詞定義
	array_Original = [[NSMutableArray alloc] init];
	
	//読み込むファイルパスを指定
	path = [bundle pathForResource:@"OriginalSerifu" ofType:@"plist"];
	
	dic = [NSDictionary dictionaryWithContentsOfFile: path];
	
	for ( NSString *key in [dic allKeys] ) {
		
		[array_Original addObject: key];
		
	}
	
	// エラー処理
	if ( bool_errorflag ) {
		
	}

	//[array_Original addObject: @"11111"];
	
	
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
    
	if ( indexPath.section == 0 ) {
		
		NTTableViewCell_1 *cell_1 = [tableView dequeueReusableCellWithIdentifier: @"Cell_1"
																	forIndexPath: indexPath];
		
		cell_1.switch_Rokuon.on = NO;
		
		NTAppDelegate *app = [[UIApplication sharedApplication] delegate];
		
		app.bool_Rokuon = NO;
		
		return cell_1;
		
	} else if ( indexPath.section == 1 ) {
		
		UITableViewCell *cell_2 = [tableView dequeueReusableCellWithIdentifier: @"Cell_2"
																  forIndexPath: indexPath];
		
		NSDictionary *dir = [array_Mokuji objectAtIndex: indexPath.row];
		
		cell_2.textLabel.text = [dir objectForKey: @"title"];
		
		return cell_2;
		
	} else if ( indexPath.section == 2 ) {
		
		UITableViewCell *cell_3 = [tableView dequeueReusableCellWithIdentifier: @"Cell_2"
																  forIndexPath: indexPath];
		
		cell_3.textLabel.text = [array_Original objectAtIndex: indexPath.row];

		return cell_3;
		
	}

    return nil;
	
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
		
		NSDictionary *dir = [array_Mokuji objectAtIndex: indexPath.row];
		
		NSString *str_mokuji = [dir objectForKey: @"title"];

		[tanmatu setDetailItem: str_mokuji];
		
	}

}

- (void)      tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    
	/*[self performSegueWithIdentifier: @"showDetail"
	 sender: [NSString stringWithFormat:@"%d", indexPath.row + 1]];*/
	
}

@end
