// Script to analyze a folder of insituHCR images with two channels in seperate images
// Enter the basic filename, highest number of files, format of file and open the first file

// Define global variables
dir = File.directory; 
files=102; //adjust number of files
Imagename="D954I852_F00000"; //adjust with base name of images
Imageend=".tif";
// past the thresholds from thresholdmacro
ts = newArray(206.7667,1.00E+30,209.4784,1.00E+30,211,1.00E+30,211.7647,1.00E+30,211.4,1.00E+30,210.8078,1.00E+30,211.9176,1.00E+30,210.8824,1.00E+30,213.4216,1.00E+30,218.8235,1.00E+30,209.9373,1.00E+30,214.1765,1.00E+30,212.6078,1.00E+30,210.9922,1.00E+30,212.7922,1.00E+30,212.0275,1.00E+30,210.8471,1.00E+30,216.5706,1.00E+30,219.2353,1.00E+30,215.4549,1.00E+30,211.6765,1.00E+30,212.2451,1.00E+30,212.7647,1.00E+30,208.5765,1.00E+30,209.4118,1.00E+30,212.6,1.00E+30,213.2824,1.00E+30,209.1961,1.00E+30,209.5647,1.00E+30,211.0588,1.00E+30,207.9882,1.00E+30,210.2863,1.00E+30,211.1569,1.00E+30,209.7843,1.00E+30,210.5,1.00E+30,210.0882,1.00E+30,211.2941,1.00E+30,211.4059,1.00E+30,211.7608,1.00E+30,212.8588,1.00E+30,211.2451,1.00E+30,210.2098,1.00E+30,214.1765,1.00E+30,210.1059,1.00E+30,209.9353,1.00E+30,210.0353,1.00E+30,210.8961,1.00E+30,208.749,1.00E+30,208.1647,1.00E+30,209.4706,1.00E+30)

// Iterate though image directory
for(j=3; j<files+1; j=j+2) {
	
	if (j<10) {
      Imagenumber="00"+j;
   } else if (j<100) {
      Imagenumber="0"+j;
   } else {
      Imagenumber=j;
   }

	if (j<9) {
      ImagenumberC2="00"+(j+1);
   } else if (j<99) {
      ImagenumberC2="0"+(j+1);
   } else {
      ImagenumberC2=j+1;
   }

// Define variables for current iteration through image directory     
    Imagetoopen=dir+Imagename+Imagenumber+Imageend;
	ImagetoopenC2=dir+Imagename+ImagenumberC2+Imageend;
	
	setBatchMode(true);
// Analyze channel 1 + Cell Segmentation and Area measurement
	if (File.exists(Imagetoopen)){
	open(Imagetoopen);
	name = File.nameWithoutExtension;
	
	rename("Image");
	run("Duplicate...", "duplicate");
	rename("Mask1");
	run("Z Project...", "projection=Median");
	run("Gaussian Blur...", "sigma=3");
	setThreshold(ts[j-3], ts[j-2]);
	run("Analyze Particles...", "size=20000-115000 pixel circularity=0.70-1.00 show=[Bare Outlines] exclude clear include add");
	
	selectWindow("Image");
	run("Z Project...", "projection=[Max Intensity]");
	run("Morphological Filters", "operation=[White Top Hat] element=Disk radius=7");
	run("Mexican Hat Filter", "radius=3");

	roiManager("Measure");
	saveAs("Results", dir + name + "_area.csv");
	close("results");
	
	cellnumber = roiManager("count");
	for(i=0; i<cellnumber; i++) {
		roiManager("select", i);
		run("Enlarge...", "enlarge=4 pixel");
		roiManager("Add");
		roiManager("select", i+cellnumber);
		roiManager("Save", dir + i + ".roi");
	}
	roiManager("Deselect");
	roiManager("Delete");
	close("ROI manager");
	for(p=10; p<2001; p=p+10){
		for(i=0; i<cellnumber; i++) {
			roiManager("Open", dir + i + ".roi");
			roiManager("select", i);
			run("Find Maxima...", "prominence=p output=Count");
		}
		saveAs("results",  dir + name + "_" + p + ".csv");
		close("results");
		close("ROI manager");
	}
	// measure intensity
	run("Set Measurements...", "mean redirect=None decimal=3");
	for(i=0; i<cellnumber; i++) {
		selectWindow("MAX_Image-White Top Hat");
		run("ROI Manager...");
		roiManager("Open", dir + i + ".roi");
		roiManager("Select", 0);
		run("Find Maxima...", "prominence=500 output=[Single Points]");
		run("Analyze Particles...", "size=0-1 pixel circularity=0.0-1.00 show=Nothing exclude clear include add");
		close();
		spotnumber = roiManager("count");
		selectWindow("MAX_Image");
		for (q=0; q<spotnumber; q++) {
			roiManager("Select", q);
			run("Enlarge...", "enlarge=2 pixel");
			run("Measure");
		}
		saveAs("Results", dir + name + "_" + i+1 + "_C1_intensity.csv");
		close("results");
		roiManager("Deselect");
		roiManager("Delete");
		close("ROI manager");
	}
	run("Set Measurements...", "area redirect=None decimal=3");
	close();
	close();
	close();
	close();
	close();
	close();

	// switch to channel 2 (NANOG)
	setBatchMode(false);
	setBatchMode(true);
	open(ImagetoopenC2);
	nameC2 = File.nameWithoutExtension;
	run("Z Project...", "projection=[Max Intensity]");
	run("Morphological Filters", "operation=[White Top Hat] element=Disk radius=7");
	run("Mexican Hat Filter", "radius=3");
	for(p=5; p<1001; p=p+5){
		for(i=0; i<cellnumber; i++) {
			roiManager("Open", dir + i + ".roi");
			roiManager("select", i);
			run("Find Maxima...", "prominence=p output=Count");
			
		}
		saveAs("results",  dir + nameC2 + "_" + p + ".csv");
		close("results");
		close("ROI manager");
	}
	// measure intensity
	run("Set Measurements...", "mean redirect=None decimal=3");
	for(i=0; i<cellnumber; i++) {
		selectWindow("MAX_" + nameC2 + "-White Top Hat");
		run("ROI Manager...");
		roiManager("Open", dir + i + ".roi");
		roiManager("Select", 0);
		run("Find Maxima...", "prominence=250 output=[Single Points]");
		run("Analyze Particles...", "size=0-1 pixel circularity=0.0-1.00 show=Nothing exclude clear include add");
		close();
		spotnumber = roiManager("count");
		selectWindow("MAX_" + nameC2 + ".tif");
		for (q=0; q<spotnumber; q++) {
			roiManager("Select", q);
			run("Enlarge...", "enlarge=2 pixel");
			run("Measure");
		}
		saveAs("Results", dir + nameC2 + "_" + i+1 + "_C2_intensity.csv");
		close("results");
		roiManager("Deselect");
		roiManager("Delete");
		close("ROI manager");
	}
	run("Set Measurements...", "area redirect=None decimal=3");
	close();
	close();
	close();
	}
}
setBatchMode(false);