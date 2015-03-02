//
//  ProductDetailHeaderView.m
//  ShopzApp
//
//  Created by Francisco Magdaleno on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "ProductDetailHeaderView.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Twitter/Twitter.h>


//ToastView
#import "ToastView.h"
//controller
#import "AppDelegate.h"

//classes
#import "ProductModel.h"
#import "UIImageView+AFNetworking.h"

/*
const static NSString* RecommendationUrl = @"http://brk.im/src/launch/firebase/recommendation.php?intent=addrec&pid=103&flag=no&comment=can%20try";*/

//const static NSString* RecommendationUrl = @"http://brk.im/src/launch/firebase/recommendation.php?intent=showrec";

const static NSString* RecommendationUrl = @"http://brk.im/src/launch/survey/?";//?pid=102";
@interface ProductDetailHeaderView ()


@property (strong, nonatomic) FBRequestConnection *requestConnection;
@property (strong, nonatomic)ProductModel* product;

@end



@implementation ProductDetailHeaderView

-(void)configureWithProduct:(ProductModel *)product {
    __weak ProductDetailHeaderView *weakSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:product.largeFrontImage];
    UIImage *placeholderImage = [UIImage imageNamed:@"shoes"];
    [self.productImageView setImageWithURLRequest:request
                                 placeholderImage:placeholderImage
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                              
                                              weakSelf.productImageView.image = image;
                                              [weakSelf setNeedsLayout];
                                              
                                          } failure:nil];
    [self.productNameLabel setText:product.name];
    [self.productStoreLabel setText:[NSString stringWithFormat:@"by %@",product.fromStore]];
    //configure description
    [self.reviewsButton setBackgroundColor:BLUE_TINT_COLOR];
    [self.reviewsButton setTitle:@"Ask friends" forState:UIControlStateNormal];
    [self.reviewsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.reviewsButton.layer.cornerRadius = 6.0;
    self.reviewsButton.clipsToBounds = YES;
    self.product = product;
}

#pragma mark buttons
- (IBAction)reviewsPressed:(UIButton *)sender {

    
    //    NSString* graphPath = [[NSString alloc]initWithFormat:@"%@/taggable_friends", [user objectID] ];
    NSString* graphPath = [[NSString alloc]initWithFormat:@"me/feed/" ];
    // create the request object, using the fbid as the graph path
    // as an alternative the request* static methods of the FBRequest class could
    // be used to fetch common requests, such as /me and /me/friends
    
    [ToastView showToastInParentView:self withText:@"Posting on Facebook .." withDuaration:1.0];
    
    __weak ProductDetailHeaderView* weakSelf = self;
    
    if ([[FBSession activeSession] isOpen]) {
        /*
         * if the current session has no publish permission we need to reauthorize
         */
        if ([[[FBSession activeSession] permissions]indexOfObject:@"publish_actions"] == NSNotFound) {
            
            [[FBSession activeSession] requestNewPublishPermissions:[NSArray arrayWithObjects: @"publish_actions",nil] defaultAudience:FBSessionDefaultAudienceFriends
                                                  completionHandler:^(FBSession *session,NSError *error){
                                                      if(error)
                                                          NSLog(@"seesion error: %@", error);

                                                      // keep track of our connection, and start it
                                                      [weakSelf postFBMessage:@"me/feed/" user:nil];
                                                  }];
            
        }else{
            // keep track of our connection, and start it
            [weakSelf postFBMessage:graphPath user:nil];
        }
    }else{
        
        /*
         * Try to post a tweet
         */
        /*
        
        [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObjects: @"publish_actions", nil]
                                           defaultAudience:FBSessionDefaultAudienceFriends
                                              allowLoginUI:NO
                                         completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                             if(error)
                                                 NSLog(@"seesion error: %@", error);

                                             if (!error && status == FBSessionStateOpen) {
                                                 // keep track of our connection, and start it
                                                 NSLog(@"session accessdata %@",[session accessTokenData]);
                                                 [weakSelf postData:graphPath user:nil];
                                                 
                                                 
                                             }else{
                                                 NSLog(@"error");
                                             }
                                         }];
         */
    }
    
    
    


}


-(void)postTwitterMessage: (NSString*) message link:(NSString*) postLink
{
//    https://api.twitter.com/1.1/statuses/update.json?status=Maybe%20he%27ll%20finally%20find%20his%20keys.%20%23peterfalk
    
    /*
    // Objective-C
    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/statuses/show.json";
    NSDictionary *params = @{@"id" : @"20"};
    NSError *clientError;
    
    
    NSURLRequest *request = [[[Twitter sharedInstance] APIClient]
                             URLRequestWithMethod:@"GET"
                             URL:statusesShowEndpoint
                             parameters:params
                             error:&clientError];
    
    if (request) {
        [[[Twitter sharedInstance] APIClient]
         sendTwitterRequest:request
         completion:^(NSURLResponse *response,
                      NSData *data,
                      NSError *connectionError) {
             if (data) {
                 // handle the response data e.g.
                 NSError *jsonError;
                 NSDictionary *json = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:0
                                       error:&jsonError];
             }
             else {
                 NSLog(@"Error: %@", connectionError);
             }
         }];
    }
    else {
        NSLog(@"Error: %@", clientError);
    }
     */
    
    //ACAccount* account =
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Send to text http://stackoverflow.com/",@"status",@"true",@"wrap_links", nil];
    SLRequest *slRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:@"http://api.twitter.com/1.1/statuses/update.json"] parameters:dict];
//    [slRequest setAccount:account];//account is ACAcount type object
    
    [slRequest performRequestWithHandler:^(NSData *responseData,NSHTTPURLResponse *urlResponse, NSError *error){
        NSLog(@"The responseString:%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        
    }];
}



-(void)postFBMessage: (NSString*) graphPath  user:(id<FBGraphUser>)user
{
    FBSession* sessionActive = FBSession.activeSession;

    
    NSLog(@"accessToken: %@", sessionActive.accessTokenData.accessToken);
    
    NSString* recLink = [NSString stringWithFormat:@"%@&pid=%@", RecommendationUrl, self.product.sku ];

    NSLog(@"posting link: %@", recLink);
    
    NSMutableDictionary* paramsSend = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Feedback request from ShopZ",  @"caption",
                                       @"I am thinking of buying this product, please provide you feedback",  @"message",
                                       recLink, @"link",
//                                       @"100009271534258", @"to",
                                       nil];
    
    
    FBRequest *request = [[FBRequest alloc] initWithSession:sessionActive
                                                         graphPath:graphPath
                                                        parameters:paramsSend
                                                        HTTPMethod:@"POST"];
    
    
    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
    // create a handler block to handle the results of the request for fbid's profile
    FBRequestHandler handler =
    ^(FBRequestConnection *connection, id result, NSError *error) {
        // output the results of the request
        [self requestCompleted:connection forFbID:[user objectID] result:result error:error];
    };
    
    
    // add the request to the connection object, if more than one request is added
    // the connection object will compose the requests as a batch request; whether or
    // not the request is a batch or a singleton, the handler behavior is the same,
    // allowing the application to be dynamic in regards to whether a single or multiple
    // requests are occuring
    [newConnection addRequest:request completionHandler:handler];
    
    
    // if there's an outstanding connection, just cancel
    [self.requestConnection cancel];
    self.requestConnection = newConnection;
    [newConnection start];
    
}

- (void)requestCompleted:(FBRequestConnection *)connection
                 forFbID:fbID
                  result:(id)result
                   error:(NSError *)error {
    
    
    // not the completion we were looking for...
    if (self.requestConnection &&
        connection != self.requestConnection) {
        return;
    }
    
    if(error !=nil)
    {
        NSLog(@"facebook post request error: %@ ", error);
        return;
    }else
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Posted for recommendation" message:@"Successfully posted on you Facebook Feed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        NSLog(@"facebook post request succeeded: ");
        [alert show];
    }

    
    // clean this up, for posterity
    self.requestConnection = nil;
    
    
    /*
    NSArray* friends = [result objectForKey:@"data"];
    NSLog(@"Found: %lu friends", (unsigned long)friends.count);

    for (NSDictionary<FBGraphUser>* friend in friends) {
        NSLog(@"I have a friend named %@ with id %@", friend.name, [friend objectID]);
    }
     */
    
}


- (IBAction)sharePressed:(UIButton *)sender {
}

@end
