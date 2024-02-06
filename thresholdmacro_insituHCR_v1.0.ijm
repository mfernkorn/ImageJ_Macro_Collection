// This Macro saves the user defined thresholds to use them for cell segmentation

// Define global variables
dir = File.directory; 
files=194; //adjust number of files
Imagename="D85TF8QR_F00000"; //adjust with base name of images
Imageend=".tif";

// Iterate though image directory
for(j=3; j<files+1; j=j+2) {
	
	if (j<10) {
      Imagenumber="00"+j;
   } else if (j<100) {
      Imagenumber="0"+j;
   } else {
      Imagenumber=j;
   }

// Define variables for current iteration through image directory     
    Imagetoopen=dir+Imagename+Imagenumber+Imageend;

// Analyze channel 1 + Cell Segmentation and Area measurement
if (File.exists(Imagetoopen)){
	open(Imagetoopen);

	run("Z Project...", "projection=Median");
	run("Gaussian Blur...", "sigma=3");
	run("Threshold...");
	waitForUser("set the threshold and press OK");
	getThreshold(lower,upper);
	print(lower);
	print(upper);
	close();
	close();
}}
selectWindow("Log");
saveAs("Text", dir + Imagename + "thresholds.txt");
