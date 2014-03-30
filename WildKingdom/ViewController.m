//
//  ViewController.m
//  WildKingdom
//
//  Created by Aaron Dufall on 29/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "ViewController.h"
#import "FlickrPhotoCell.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

@implementation ViewController
{
    NSArray *photos;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *searchTerm = @"bear";
	NSString *apiURL = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&format=json&nojsoncallback=1",kFlickrAPIKey,searchTerm];
    NSURL *url = [NSURL URLWithString:apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error;
        NSDictionary *responseJSON;
        responseJSON =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        photos = [[responseJSON objectForKey:@"photos"]objectForKey:@"photo"];
        [self.myCollectionView reloadData];
    }];
    
    
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"flickrCell"];


}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [photos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *photo = [photos objectAtIndex:indexPath.row];
    NSString *farmId = photo[@"farm"];
    NSString *serverId = photo[@"server"];
    NSString *photoId = photo[@"id"];
    NSString *secret = photo[@"secret"];
    NSString *urlString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_s.jpg",farmId, serverId, photoId, secret];
    NSURL *imageURL = [NSURL URLWithString:urlString];
    
    
    FlickrPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"flickrCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
