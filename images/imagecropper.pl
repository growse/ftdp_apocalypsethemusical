#!/usr/bin/perl

use Image::Magick;
use CGI;


$query=new CGI;
my $dimension=280;

$originalsdir = "photos/";

opendir(DIR,$originalsdir);
@files = grep {/^[^\.]/ && -e $originalsdir.$_ } readdir(DIR);
closedir(DIR);

foreach (@files) {
	($name,$ext)=split(/\./,$_);
	$image = new Image::Magick;
	$image->Read($originalsdir.$_);
	$width = $image->Get('width');
	$height = $image->Get('height');
	if ($width > 0 && $height > 0) {
		$percentw = $dimension / $width;
		$percenth = $dimension / $height;
		if ($percenth < $percentw) {
			$desty = (($height * $percentw)-$dimension) / 2;
			$destx = 0;
			$image->Resize(width=>$width*$percentw,height=>$height*$percentw,filter=>'Lanczos');
		} else {
			$destx = (($width * $percenth)-$dimension) / 2;
			$desty = 0;
			$image->Resize(width=>$width*$percenth,height=>$height*$percenth,filter=>'Lanczos');
		}
		$image->Crop($dimension.'x'.$dimension.'+'.$destx.'+'.$desty);
		$image->Set(quality=>65);
		$image->Strip();
		$image->Write($originalsdir.$name.'.th.jpg');	
	}	
}
