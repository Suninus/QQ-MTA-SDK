//
//  ThirdViewController.m
//  MTA-Demo
//
//  Created by tyzual on 10/27/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "ThirdViewController.h"
#import "MTA.h"
#import "MTAFeedback.h"

@interface ThirdViewController ()
@property (retain, nonatomic) IBOutlet UITextView *fbMsg;
@property (retain, nonatomic) IBOutlet UITextField *repId;
@property (retain, nonatomic) IBOutlet UITextField *repMsg;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;


@property (retain, nonatomic) UIImage *screenshot;

@end

@implementation ThirdViewController

- (IBAction)touchView:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"用户反馈";
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
	}
	return self;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onPickImg:(id)sender {
	UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
	}
	UIImagePickerController * picker = [[UIImagePickerController alloc]init];
	picker.delegate = self;
	picker.allowsEditing=YES;
	picker.sourceType=sourceType;
	[self presentViewController:picker animated:YES completion:nil];

}

- (IBAction)onSendFbMsg:(id)sender {
	NSString *fbMsg = self.fbMsg.text;
	[MTA postFeedBackFiles:fbMsg screenshot:self.screenshot callback:^(BOOL bSuccess, NSString *msg) {
		NSString *title = nil;
		if (bSuccess) {
			title = @"成功";
		} else {
			title = @"有错误发生";
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
														message:msg
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];

		[alert show];
	}];
}

- (IBAction)getLastRep:(id)sender {
	[MTA getFeedBackMessage:0 numLine:1 callback:^(BOOL bSuccess, NSString *msg, NSArray<MTAFeedBack*>* datas) {
		if (bSuccess) {
			if ([datas count] > 0) {
				MTAFeedBack *fb = [datas objectAtIndex:0];
				NSString *msg = [NSString stringWithFormat:@"反馈id:%@\n用户:%@\n反馈时间:%@\n反馈内容:%@", fb.feedBackId, fb.userName, fb.date, fb.content];
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功"
															message:msg
															delegate:nil
															cancelButtonTitle:@"OK"
															otherButtonTitles:nil];
				
				[alert show];

			}
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有错误发生"
															message:msg
															delegate:nil
															cancelButtonTitle:@"OK"
															otherButtonTitles:nil];
			[alert show];
		}
	}];

}

- (IBAction)reply:(id)sender {
	NSNumber *repId = @([self.repId.text integerValue]);
	[MTA replyFeedBackMessage:repId content:self.repMsg.text callback:^(BOOL bSuccess, NSString *msg) {
		NSString *title = nil;
		if (bSuccess) {
			title = @"成功";
		} else {
			title = @"有错误发生";
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
														message:msg
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];

		[alert show];
	}];

}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
	self.screenshot = [info objectForKey:UIImagePickerControllerEditedImage];
	self.imgView.contentMode = UIViewContentModeScaleAspectFit;
	self.imgView.image = self.screenshot;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissViewControllerAnimated:YES completion:nil];
}

@end
