//
//  AccViewController.m
//  TwitterShmidter
//
//  Created by Alexander Demidovich on 26.01.16.
//  Copyright © 2016 Alexander Demidovich. All rights reserved.
//

#import "AccViewController.h"

@interface AccViewController ()

@end

@implementation AccViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getTwitterInfo];
    
}


- (void)getTwitterInfo {
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        
        if (granted) {
            
            NSLog(@"if granted");
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];

           if (accounts.count > 0) {
               
                NSLog(@"if accounts.count > 0");
               
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:
                                             SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:
                                             [NSDictionary dictionaryWithObject:_username forKey:@"screen_name"]];
                
                [twitterRequest setAccount:twitterAccount];
                
                [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if ([urlResponse statusCode] == 429) {
                            NSLog(@"Rate limit!");
                            return ;
                        }
                        
                        if (error) {
                            NSLog(@"Error: %@", error.localizedDescription);
                            return ;
                        }
                        
                        if (responseData) {
                            NSError *error = nil;
                            _arrayTweets = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            
                            NSString *screen_name = [(NSDictionary *)_arrayTweets objectForKey:@"screen_name"];
                            NSString *name = [(NSDictionary *)_arrayTweets objectForKey:@"name"];
                            
                            NSInteger tweets = [[(NSDictionary *)_arrayTweets objectForKey:@"statuses_count"] integerValue];
                            NSInteger following = [[(NSDictionary *)_arrayTweets objectForKey:@"friends_count"] integerValue];
                            NSInteger followers = [[(NSDictionary *)_arrayTweets objectForKey:@"followers_count"] integerValue];
                            
                            NSString *profileImageURL = [(NSDictionary*)_arrayTweets objectForKey:@"profile_image_url_https"];
                            NSString *bannerImageURL = [(NSDictionary*)_arrayTweets objectForKey:@"profile_banner_url"];
                            NSString *lastTweet = [[(NSDictionary*)_arrayTweets objectForKey:@"status"] objectForKey:@"text"];
                            
                            _nameLabel.text = name;
                            _usernameLabel.text = screen_name;
                            
                            _tweetsLabel.text = [NSString stringWithFormat:@"%ld", tweets];
                            _followerLabel.text = [NSString stringWithFormat:@"%ld", followers];
                            _followingLabel.text = [NSString stringWithFormat:@"%ld", following];
                            
                            _lastTweetsLabel.text = lastTweet;
                            
                            [self getProfileImageForURLString:profileImageURL];
                            
                            if (bannerImageURL) {
                                NSString *bannerURL = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageURL];
                                [self getBannerNameForURLString:bannerURL];
                            }
                            else{
                                _bannerImage.backgroundColor = [UIColor grayColor];
                            }
                          
                          
                        }
                    });
                }];
               
           } else
               NSLog(@"No twitter account on device");
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = _username;
}

- (void)getProfileImageForURLString:(NSString*) string {
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _profileImage.image = [UIImage imageWithData:data];
}

- (void)getBannerNameForURLString:(NSString*) string {
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _bannerImage.image = [UIImage imageWithData:data];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
