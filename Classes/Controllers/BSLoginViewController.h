

#import <UIKit/UIKit.h>

@interface BSLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *topicTextfield;

- (IBAction)login:(id)sender;

@end
