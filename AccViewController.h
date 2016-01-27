//
//  AccViewController.h
//  TwitterShmidter
//
//  Created by Alexander Demidovich on 26.01.16.
//  Copyright © 2016 Alexander Demidovich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface AccViewController : UIViewController

@property (nonatomic) NSString *username;

@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIImageView *bannerImage;


@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (strong, nonatomic) IBOutlet UILabel *followerLabel;
@property (strong, nonatomic) IBOutlet UILabel *followingLabel;

@property (strong, nonatomic) IBOutlet UILabel *lastTweetsLabel;

@property (nonatomic) NSArray *arrayTweets;

@end
