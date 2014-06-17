#import "SKStandardController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "common.h"

@implementation SKStandardController
-(BOOL) showHeartImage { return YES; }
-(BOOL) tintNavigationTitleText { return NO; }
-(BOOL) shiftHeartImage { return YES; }
-(NSString*) enabledDescription { return @"test"; }

-(NSArray*) customSpecifiers
{
    return @[
             @{ @"cell": @"PSGroupCell",
                @"footerText": self.enabledDescription
                },
             @{
                 @"cell": @"PSSwitchCell",
                 @"default": @YES,
                 @"defaults": self.defaultsFileName,
                 @"key": @"enabled",
                 @"label": @"ENABLED",
                 @"PostNotification": self.postNotification,
                 @"cellClass": @"SKTintedSwitchCell",
                 @"icon": @"enabled.png"
                 },
             @{ @"cell": @"PSGroupCell" },
             @{
                 @"cell": @"PSLinkCell",
                 @"action": @"loadSettingsListController",
                 @"label": @"OPTIONS",
                 @"icon": @"settings.png",
                 @"cellClass": @"SKTintedCell",
                 },
             @{ @"cell": @"PSGroupCell" },
             @{
                 @"cell": @"PSLinkCell",
                 @"action": @"loadMakersListController",
                 @"label": @"MAKERS",
                 @"icon": @"makers.png",
                 @"cellClass": @"SKTintedCell",
                 },
             @{ @"cell": @"PSGroupCell" },
             @{
                 @"cell": @"PSLinkCell",
                 @"action": @"showSupportDialog",
                 @"label": @"SUPPORT",
                 @"icon": @"support.png",
                 @"cellClass": @"SKTintedCell",
                 }
             ];
}

-(NSString*)postNotification { return @""; }
-(NSString*)defaultsFileName { return @""; }

-(NSString*) emailAddress { return @""; }
-(NSString*) emailBody { return @""; }
-(NSString*) emailSubject { return @""; }

-(void) loadSettingsListController { }
-(void) loadMakersListController { }

-(void) showSupportDialog
{
    MFMailComposeViewController *mailViewController;
    if ([MFMailComposeViewController canSendMail])
    {
        mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:self.emailSubject];
        [mailViewController setMessageBody:self.emailBody isHTML:NO];
        [mailViewController setToRecipients:@[self.emailAddress]];
            
        [self.rootController presentViewController:mailViewController animated:YES completion:nil];
    }

}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(UIColor*) iconColor
{
    if ([self respondsToSelector:@selector(tintColor)])
        return self.tintColor;
    else
        return [UIColor whiteColor];
}
@end