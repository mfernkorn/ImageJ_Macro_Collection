

// ImageJ Macro for nuclei segmentation and intensity measurement of three channeled images. 
// These have to be in a single folder and every channel is saved as a sepereated tif
// Naming convention currecntly expects _ch0x.tif with x beeing 0 for nuclei, 1 or 2.
// Measurements are saved for every channel seperatly as a csv with the same name as the corresponding image

// Define Directory of images
dir = getDirectory("Choose Source Directory ");

list = getFileList(dir);
run("Set Measurements...", "area mean standard integrated redirect=None decimal=3");

setBatchMode(true);
// Loop through all files (all threee channels in every loop)
for (i=0; i<list.length; i+=1) {
	open(dir+list[i]);
	rename('stack');
	for (j = 1; j < 170; j+=2) {
		selectImage("stack");
		Stack.setPosition(1,1,j);
		run("Duplicate...", " ");
		rename('image');
		run("Split Channels");
	
		// Segmentation
		selectImage("C1-image");
		run("Command From Macro", "command=[de.csbdresden.stardist.StarDist2D], args=['input':'C1-image', 'modelChoice':'Versatile (fluorescent nuclei)', 'normalizeInput':'true', 'percentileBottom':'1.0', 'percentileTop':'99.8', 'probThresh':'0.7000000000000001', 'nmsThresh':'0.4', 'outputType':'ROI Manager', 'modelFile':'/Users/fernkorn/Desktop/2101_StardistModel_mes.zip', 'nTiles':'1', 'excludeBoundary':'2', 'roiPosition':'Automatic', 'verbose':'false', 'showCsbdeepProgress':'false', 'showProbAndDist':'false'], process=[false]");

	
		// Measure and save measurements as csv files with same name as image
		selectImage("C2-image");
		roiManager("Deselect");
		roiManager("multi-measure measure_all");
		saveAs("Results", dir+list[i]+"_"+j+".csv");
		close("C1-image");
		close("C2-image");
		close("C3-image");
	}
	close();
}
setBatchMode(false);