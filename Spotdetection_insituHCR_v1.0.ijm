// Script to analyze a folder of insituHCR images with two channels in seperate images
// Enter the basic filename, highest number of files, format of file and open the first file

// Define global variables
dir = File.directory; 
files=306; //adjust number of files
Imagename="D85RV8SM_F00000"; //adjust with base name of images
Imageend=".tif";
// past the thresholds from thresholdmacro
ts = newArray(208.8,1.00E+30,209.1,1.00E+30,209.6176,1.00E+30,209.6333,1.00E+30,210.4373,1.00E+30,210.2882,1.00E+30,216.9118,1.00E+30,214.0784,1.00E+30,209.6118,1.00E+30,208.7,1.00E+30,208.4118,1.00E+30,210.8176,1.00E+30,210.8039,1.00E+30,209.9843,1.00E+30,210.1765,1.00E+30,210.8843,1.00E+30,210.5902,1.00E+30,211.5922,1.00E+30,211.0196,1.00E+30,209.2333,1.00E+30,209.1569,1.00E+30,207.0294,1.00E+30,211.1686,1.00E+30,210.5333,1.00E+30,211.2882,1.00E+30,207.7588,1.00E+30,210.3235,1.00E+30,205.7686,1.00E+30,211.9529,1.00E+30,214.3961,1.00E+30,209.6824,1.00E+30,217.202,1.00E+30,216.6961,1.00E+30,214.8216,1.00E+30,215,1.00E+30,210.3137,1.00E+30,216.5902,1.00E+30,210.0235,1.00E+30,209.9078,1.00E+30,210.2647,1.00E+30,216.7863,1.00E+30,213.1569,1.00E+30,210.9,1.00E+30,211.8588,1.00E+30,211.849,1.00E+30,211.0686,1.00E+30,208.2471,1.00E+30,213.2196,1.00E+30,209.3039,1.00E+30,209.9412,1.00E+30,211.0392,1.00E+30,210.598,1.00E+30,216.0667,1.00E+30,214.1235,1.00E+30,212.6118,1.00E+30,218.9235,1.00E+30,214.7059,1.00E+30,216.6118,1.00E+30,216.7,1.00E+30,226.6059,1.00E+30,214.8471,1.00E+30,215.4294,1.00E+30,210.3118,1.00E+30,225.3059,1.00E+30,210.9137,1.00E+30,211.7196,1.00E+30,207.6745,1.00E+30,212.1294,1.00E+30,210.4706,1.00E+30,207.9451,1.00E+30,210.3882,1.00E+30,206.7588,1.00E+30,212.5294,1.00E+30,213.8471,1.00E+30,214.4765,1.00E+30,211.9059,1.00E+30,210.4902,1.00E+30,209.2961,1.00E+30,212.4,1.00E+30,212.1451,1.00E+30,215.2118,1.00E+30,215.5569,1.00E+30,215.8647,1.00E+30,213.2,1.00E+30,214.2255,1.00E+30,213.298,1.00E+30,213.3882,1.00E+30,211.5,1.00E+30,213.1118,1.00E+30,211.8784,1.00E+30,210.6176,1.00E+30,213.7941,1.00E+30,211,1.00E+30,217.8235,1.00E+30,212.5941,1.00E+30,214.5667,1.00E+30,218.1098,1.00E+30,217.9294,1.00E+30,219.9549,1.00E+30,216.7941,1.00E+30,220.3412,1.00E+30,216.5294,1.00E+30,215.4431,1.00E+30,213.4706,1.00E+30,214.2706,1.00E+30,212.3078,1.00E+30,213.9647,1.00E+30,210.5686,1.00E+30,210.0039,1.00E+30,211.4,1.00E+30,211.2471,1.00E+30,213.3118,1.00E+30,216.1824,1.00E+30,215.8137,1.00E+30,214.2176,1.00E+30,214.2412,1.00E+30,219.651,1.00E+30,214.9216,1.00E+30,214.4412,1.00E+30,216.502,1.00E+30,210.6,1.00E+30,216.6941,1.00E+30,214.2353,1.00E+30,211.6235,1.00E+30,216.298,1.00E+30,220.2118,1.00E+30,212.4353,1.00E+30,214.5882,1.00E+30,215.9882,1.00E+30,216.4294,1.00E+30,217.8824,1.00E+30,213.0686,1.00E+30,213.9471,1.00E+30,216.1725,1.00E+30,213.1863,1.00E+30,217.1333,1.00E+30,216.9529,1.00E+30,215.3667,1.00E+30,214.0078,1.00E+30,212.7647,1.00E+30,212.0294,1.00E+30,211.7118,1.00E+30,212.3431,1.00E+30,214.7647,1.00E+30,214.1765,1.00E+30,216.2118,1.00E+30,212.7647,1.00E+30,214.5529,1.00E+30,213.8196,1.00E+30,219.4941,1.00E+30,216.6824,1.00E+30,213.549,1.00E+30)

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
	run("Analyze Particles...", "size=20000-150000 pixel circularity=0.70-1.00 show=[Bare Outlines] exclude clear include add");
	
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
	for(i=0; i<cellnumber; i++) {
		roiManager("Open", dir + i + ".roi");
		roiManager("select", i);
		run("Find Maxima...", "prominence=500 output=Count");
	}
	saveAs("results",  dir + name + "_" + 500 + ".csv");
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

	// switch to channel 2
//	setBatchMode(false);
//	setBatchMode(true);
	open(ImagetoopenC2);
	nameC2 = File.nameWithoutExtension;
	run("Z Project...", "projection=[Max Intensity]");
	run("Morphological Filters", "operation=[White Top Hat] element=Disk radius=7");
	run("Mexican Hat Filter", "radius=3");
	for(i=0; i<cellnumber; i++) {
		roiManager("Open", dir + i + ".roi");
		roiManager("select", i);
		run("Find Maxima...", "prominence=250 output=Count");
		}
	saveAs("results",  dir + nameC2 + "_" + 250 + ".csv");
	close("results");
	close("ROI manager");
	
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
setBatchMode(false);