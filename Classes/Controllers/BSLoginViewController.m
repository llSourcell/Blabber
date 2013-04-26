

#import "BSLoginViewController.h"
#import "BSClient.h"

@interface BSLoginViewController ()

@end

@implementation BSLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[BSClient sharedClient] unsubcribe];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [[BSClient sharedClient] subscribeToChannel:[_topicTextfield text] withUsername:[_usernameTextfield text] successBlock:^{
        [self performSegueWithIdentifier:@"Show Messages" sender:self];
    }];
}

@end
