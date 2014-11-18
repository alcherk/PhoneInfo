//
//  ViewController.m
//  PhoneInfo
//
//  Created by lex on 18/11/14.
//  Copyright (c) 2014 alcherk. All rights reserved.
//

#import "ViewController.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getInfoClick:(id)sender
{
    [self.textView setText:@""];
    // not working for phonenumber
    NSString *num = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
    
    [self appendTextView:[NSString stringWithFormat:@"Phone Number: %@\n\n", num]];
    
    
    
    // not working either
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Preferences/.GlobalPreferences.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@", dict);
    
    // carrier detection
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    [self appendTextView:[NSString stringWithFormat:@"Carrier Name: %@\n", [carrier carrierName]]];
    
    [self appendTextView:[NSString stringWithFormat:@"Mobile Country Code: %@\n", [carrier mobileCountryCode]]];
    [self appendTextView:[NSString stringWithFormat:@"Mobile Network Code: %@\n", [carrier mobileNetworkCode]]];

    [self appendTextView:[NSString stringWithFormat:@"isoCountryCode = %@\n",carrier.isoCountryCode]];
    [self appendTextView:[NSString stringWithFormat:@"allowVOIP = %d\n",carrier.allowsVOIP]];
}

- (void)appendTextView:(NSString*)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAttributedString* attr = [[NSAttributedString alloc] initWithString:text];
        
        [[self.textView textStorage] appendAttributedString:attr];
        [self.textView scrollRangeToVisible:NSMakeRange([[self.textView text] length], 0)];
    });
}

@end
