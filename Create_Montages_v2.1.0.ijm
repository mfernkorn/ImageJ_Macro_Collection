// Loopes through all files in directory, interactivly set by user, and creates montage.
// Montage includes scale bar (100µm) in merge and appearance can be further specified in run("Make montage"...).
// Important: Scaling factor set to 0.5 for smaller file sizes. For optimal quality set to 1.
// Files have to be single channel tifs. In this case three channels needed.
// Before Use: 
// Manually determine which channels have to be adjusted in Brightness and Contrast. Add setMinAndMax for those channels.

// define source directory and directory to save monatges to.
dir = getDirectory("Choose Source Directory");
list_all = getFileList(dir);

// Specify the subdirectory for saving the montage, based on deleting last subfolder from sir and adding "Montages" instead.
montageDir = substring(dir, 0, lastIndexOf(substring(dir, 0, lengthOf(dir) - 1), "/")+1) + "Montages/"; 

// Turn on batch mode
setBatchMode(true);
// Loop through the files
for (i = 0; i < list_all.length; i = i + 3) {
    // Open three images at a time
    open(dir + list_all[i]);
    open(dir + list_all[i + 1]);
    open(dir + list_all[i + 2]);
    
    // Select channel zero and set LUT, rename image to 0
	selectWindow(list_all[i]);
	rename("0");
	run("Blue");
	setMinAndMax(0, 100);

	// Select channel one and set LUT, rename image to 1
	selectWindow(list_all[i + 1]);
	rename("1");
	run("Green");
	// setMinAndMax(0, 100);
	
	// Select channel two and set LUT, rename image to 2
	selectWindow(list_all[i + 2]);
	rename("2");
	run("Magenta");
	setMinAndMax(0, 150);

	// Make Composite by merge channels and convert to RGB
	run("Merge Channels...", "c2=0 c3=1 c6=2 create keep");
	run("Stack to RGB");
	selectWindow("Composite");
	close();
	
	// Create Montage and add scale bar on composite (RGB)
	run("Images to Stack", "use keep");
	run("Make Montage...", "columns=1 rows=4 scale=0.5 border=25");
	run("Scale Bar...", "width=100 height=8 thickness=15 font=14 color=White background=None location=[Lower Right] horizontal bold hide overlay");
	
	// Find the index of "_Merging_Crop" in the filename
	mergeCropIndex = indexOf(list_all[i], "_Merging_Crop");
	// Extract the substring before "_Merging_Crop"
	Monatage_name = substring(list_all[i], 0, mergeCropIndex);
	// Save and close images
	saveAs("Tiff", montageDir + Monatage_name+"_Montage.tif");
	run("Close All");
}
setBatchMode(false);