//
//  SearchManager.h
//  shopZ
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 brk.im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResultsModel.h"
#import "MacysSearchResultModel.h"
#import "RecommendationCollectionModel.h"
#import "AFNetworking.h"
@interface SearchManager : NSObject



+ (void) searchForProduct: (NSString*) searchFor
                               fromStore:(NSString* ) store
                                  filter: (NSString*) filter
                                 success:(void (^)( id responseObject))success
                                 failure:(void (^)(NSError *error))failure;

+ (void) queryRecommendationsForProduct: (NSString*) pid
                                success:(void (^)( id responseObject))success
                                failure:(void (^)(NSError *error))failure;


@end
