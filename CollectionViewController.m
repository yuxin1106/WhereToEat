//
//  CollectionViewController.m
//  WhereToEat
//
//  Created by Yu Xin on 4/19/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import "CollectionViewController.h"
#import "CustomCollectionViewCell.h"

@interface CollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionVew;
@property (strong, nonatomic) NSMutableArray* imageArray;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionVew.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background2.png"]];
    [self.collectionVew registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(100,100);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    self.collectionVew.collectionViewLayout = flow;
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    // create file name for file
    NSString  *fileName = @"foodphotos.plist";
    _filePath = [NSString  stringWithFormat:@"%@/%@", path, fileName];
    NSMutableArray* imageArrayFile = [[NSMutableArray alloc] initWithContentsOfFile:_filePath];
    
    if (imageArrayFile)
    {
        self.imageArray = [self convertDataToImage:imageArrayFile];
    }
    else
    {
        self.imageArray = [[NSMutableArray alloc] init];
        [self.imageArray addObject:[UIImage imageNamed:@"sample"]];
        [self saveImageArray];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    /*if (self.imageArray.count == 0)
    {
        return 1;
    }
    else
    {
       return self.imageArray.count;
    }*/
    
   // NSLog(@"numberOfItemsInSection:");
    return self.imageArray.count;
}


- (IBAction)addImageDidPressed:(UIButton *)sender {
    
    UIImagePickerController *ipvc = [[UIImagePickerController alloc] init];
    
    ipvc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipvc.delegate = self;
    
    [self presentViewController:ipvc animated:YES completion:^{}];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imageView.image = [self.imageArray objectAtIndex:indexPath.row];
   // NSLog(@"collectionView cellForItemAtIndexPath");
    return cell;
}

// UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //UIImage *edittedImage = info[UIImagePickerControllerEditedImage];
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
   // self.image = originalImage;
    [self.imageArray addObject:originalImage];
    
    [self saveImageArray];
    
    NSLog(@"%lu",(unsigned long)self.imageArray.count);
    
    [self.collectionVew reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
   // NSLog(@"imagePickerController didFinishPickingMediaWithInfo");

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    NSLog(@"imagePickerControllerDidCancel");
    [picker dismissViewControllerAnimated:YES completion:^{
    }];

    
}

- (void)saveImageArray {
    
    NSMutableArray* dataArray = [self convertImageToData:self.imageArray];
    [dataArray writeToFile:self.filePath atomically:YES];
    // [self.imageArray writeToFile:self.filePath atomically:YES];
    NSLog(@"save");
}

- (NSMutableArray*)convertImageToData:(NSMutableArray*)imageArray {
    NSMutableArray *retVal = [NSMutableArray array];
    for (int i=0; i<imageArray.count; i++)
    {
        NSData *data = UIImagePNGRepresentation(imageArray[i]);
        [retVal addObject:data];
    }
    return retVal;
}

- (NSMutableArray*)convertDataToImage:(NSMutableArray*)dataArray {
    NSMutableArray *retVal = [NSMutableArray array];
    for (int i=0; i<dataArray.count; i++)
    {
        UIImage *image = [UIImage imageWithData:dataArray[i]];
        [retVal addObject:image];
    }
    return retVal;
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
