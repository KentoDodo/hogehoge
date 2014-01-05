+(NSString*)sendImage:(UIImage*)_image url:(NSString*)url {
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMEOUT_INTERVAL];
    request.HTTPMethod=@"POST";
    //    request.HTTPBody=[[NSString stringWithFormat:@"image=%@",[self image2string:_image]] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody=[[NSData alloc] initWithData:UIImagePNGRepresentation(_image)];
    NSError *error=nil;
    NSData *response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        NSLog(@"error to send image.");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Communication error" message:@"Communication error...\nYou can enable wifi function." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return nil;
    } else if (!response) {
        NSLog(@"failed to send image.");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Communication error" message:@"Communication failed...\nYou can enable wifi function." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return nil;
    }
    if (!response) return nil;
    return [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
}