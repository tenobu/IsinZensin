//
//  NTSerifu2ViewController.m
//  IsinZensin
//
//  Created by ビザンコムマック０９ on 2014/09/13.
//  Copyright (c) 2014年 ビザンコムマック０９. All rights reserved.
//

#import "NTSerifu2ViewController.h"

#import "NTToolbar.h"
#import <AVFoundation/AVFoundation.h>

@interface NTSerifu2ViewController ()
{
	
@private
	
	NSString *string_Link;

	NSString *string_Mokuji;
	NSArray *array_Serifu;
	
	AVSpeechSynthesizer *speechSynthesizer;
	
}

@end

@implementation NTSerifu2ViewController

- (id)initWithStyle: (UITableViewStyle)style
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
	
	//読み込むファイルパスを指定
	NSString *path = [bundle pathForResource: @"TitleSerifu"
									  ofType: @"plist"];
	
	// plistの読み込み
	NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile: path];
	
	// エラーをクリア
	BOOL bool_errorflag = YES;
	
	// Titleの読み込み
	for ( NSString *key in [dic allKeys] ) {

		if ( [key isEqualToString: string_Mokuji] ) {
	
			[self.navigationItem setTitle: string_Mokuji];
			
			NSArray *array = (NSArray *)[dic objectForKey: string_Mokuji];

			for ( id obj in array ) {
				
				// Dataの型を文字列に変換
				NSString *str = NSStringFromClass( [obj class] );
				
				// Dataの型を確認
				if ( [str isEqualToString: @"__NSCFArray"] ) {
					
					// NSArrayを入れる
					array_Serifu = (NSArray *)obj;
					
					break;
					
				}

			}
			
			[self.tableView reloadData];
			
			bool_errorflag = NO;

			continue;
			
		}
		
	}
	
	// エラー処理
	if ( bool_errorflag ) {
		
	}
	
	// テーブルデリを設定
	self.tableView.delegate = self;
	
	// 音声合成を初期化
	speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
	
	
	/*self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
																			   target: self
																			   action: @selector(insertNewObject:)];
	self.navigationItem.rightBarButtonItem = addButton;*/

	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
																			   target: self
																			   action: @selector(insertNewObject:)];
	
	UIBarButtonItem *editButton = self.editButtonItem;
	
	editButton.style = UIBarButtonItemStyleBordered;
	
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	NTToolbar *toolbar = [[NTToolbar alloc] initWithFrame: CGRectMake( 0.0f, 0.0f, 110.0f, 44.0f )];
	
	toolbar.backgroundColor = [UIColor clearColor];
	toolbar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
	UIBarButtonItem *toolbarBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toolbar];
	
	toolbar.items = [NSArray arrayWithObjects:space, editButton, addButton, nil];
	
	self.navigationItem.rightBarButtonItem = toolbarBarButtonItem;

}

- (void)didReceiveMemoryWarning
{
	
    [super didReceiveMemoryWarning];
	
}

- (void)setDetailItem: (NSString *)str
{

	string_Mokuji = str;
	
	//for ( NSString *string_mokuji in )
    /*if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }*/

}

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
	
    return 1;
	
}

- (NSInteger)tableView: (UITableView *)tableView
 numberOfRowsInSection: (NSInteger)section
{
	
	return [array_Serifu count];
		
}

- (UITableViewCell *)tableView: (UITableView *)tableView
		 cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell"
															forIndexPath: indexPath];
	
	cell.textLabel.text = [array_Serifu objectAtIndex: indexPath.row];
	
    return cell;
	
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

- (NSIndexPath *)tableView: (UITableView *)tableView
  willSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
	
	[self onnseiOutput: array_Serifu[indexPath.row]];
	
	return indexPath;
	
}

- (void)onnseiOutput: (NSString *)string
{
	
	//NSLog(@"%@", string);
	
	AVSpeechUtterance      *utterance = [AVSpeechUtterance speechUtteranceWithString: string];
	AVSpeechSynthesisVoice *JVoice    = [AVSpeechSynthesisVoice voiceWithLanguage: @"ja-JP"];
	
	// 音声の日本語化
	utterance.voice =  JVoice;
	
	// NSLog( @"bool_AudioResult == %d", bool_AudioResult );
	
	// 音声の発生
	[speechSynthesizer speakUtterance: utterance];
	
}

@end
