//
//  NTSerifu2ViewController.m
//  IsinZensin
//
//  Created by ビザンコムマック０９ on 2014/09/13.
//  Copyright (c) 2014年 ビザンコムマック０９. All rights reserved.
//

#import "NTSerifu2ViewController.h"

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
	NSString *path = [bundle pathForResource:@"TitleSerifu" ofType:@"plist"];
	
	NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
	
	BOOL bool_errorflag = YES;
	
	for ( NSString *key in [dic allKeys] ) {

		if ( [key isEqualToString: string_Mokuji] ) {
	
			[self.navigationItem setTitle: string_Mokuji];
			
			array_Serifu = (NSArray *)[dic objectForKey: string_Mokuji];
			
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
