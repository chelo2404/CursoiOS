//
//  AppTweetsViewController.m
//  EjercicioTwitter
//
//  Created by Gerardo Fernandez on 12/22/15.
//  Copyright © 2015 Gerardo Fernandez. All rights reserved.
//

#import "AppSearchResultsViewController.h"
#import "AppSearchResultTableViewCell.h"
#import "iTunesAPI.h"

@interface AppSearchResultsViewController () <UITableViewDelegate, UITableViewDataSource>
@property UITableView* resultsTableView;
@end

@implementation AppSearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Search Results"];
    // Do any additional setup after loading the view.
    NSLog(@"Data received from previous controller: %@", self.resultsData);
    
    self.resultsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self;
    
    self.resultsTableView.rowHeight = 60;
    
    [self.view addSubview:self.resultsTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"resultCell";
    
    AppSearchResultTableViewCell *cell = (AppSearchResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AppSearchResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *result = self.resultsData[indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [result objectForKey:@"artworkUrl60"]]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            cell.artwork.image = [UIImage imageWithData: data];
        });
    });
    
    cell.artistName.text = [result objectForKey:@"artistName"];
    cell.collectionName.text = [result objectForKey:@"collectionName"];
    cell.trackName.text = [result objectForKey:@"trackName"];
    
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsData.count;
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
