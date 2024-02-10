run("Set Measurements...", "area mean standard redirect=None decimal=3");
name = getInfo("image.filename");
rename("image1");
run("Duplicate...", " ");
run("Subtract Background...", "rolling=200 light");
run("Gaussian Blur...", "sigma=20");
makeOval(668, 740, 13300, 13300); // Adjust for a size fitting to the field of view
beep();
waitForUser("Waiting for user to position the circle in the center of the well. Press Okay to continue...."); // move circle maually
run("Clear Outside");
setAutoThreshold("Otsu no-reset");
beep();
waitForUser("Waiting for user Adjust/Confirm threshold"); // adjust threshold manually in cases with no colonies
run("Convert to Mask");
run("Watershed");
run("Analyze Particles...", "size=5000-400000 circularity=0.50-1.00 display exclude clear include add");
close("Results");

//Manually delete obvious false ones
selectWindow("image1");
roiManager("Show None");
roiManager("Show All");
beep();
waitForUser("Waiting for user to delete clear false ROIs. Press Okay to continue...."); // move circle maually
roiManager("Save", "/Users/fernkorn/Documents/Clonogenicity_Assay_Analysis/20230213_2d2iL_48hN2B27_6d2iL_onlySpry4/ROIs/"+name+"RoiSet.zip");
selectWindow("image1-1");


selectWindow("image1");
roiManager("Show None");
roiManager("Show All");
roiManager("Deselect");
roiManager("Measure");

saveAs("Results", "/Users/fernkorn/Documents/Clonogenicity_Assay_Analysis/20230213_2d2iL_48hN2B27_6d2iL_onlySpry4/Data/"+name+".csv");
close("Results");
close("ROI Manager");
run("Close All");
