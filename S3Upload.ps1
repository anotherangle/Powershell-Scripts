#Script to upload content of folder to some S3 Bucket or some folder within it
$bucket = "//YOUR_BUCKET_NAME//"

Set-Location //PATH WHERE YOUR CONTENT IS//

#Set-Location $source
$files = Get-ChildItem | Select-Object -Property Name

try {
   if(Test-S3Bucket -BucketName $bucket) {
      foreach($file in $files) {
         if(!(Get-S3Object -BucketName $bucket -Key $file.Name)) { ## verify if exist
            Write-Host "Copying file : $file "
            $name="FOLDER_NAME(IF_ANY)/"+$file.Name
            #Write-Output $name
            Write-S3Object -BucketName $bucket -File $file.Name  -Key $name -CannedACLName private
         } 
      }
   } Else {
      Write-Host "The bucket $bucket does not exist."
   }
} catch {
   Write-Host "Error uploading file $file"
}

