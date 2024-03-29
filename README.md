# ImageJ_Macro_Collection
One of the many, but my very own, collection of ImageJ macros for basic processing of microscopy images.

## Macros

#### Create_Montages_v2.1.0.ijm
Creates image montages (including cingle channel images and Merge image with scale bar) from a folder of images with three channels, saved as seperate images.

#### Segmentation_and_Measurement_v2.0.ijm
2D StarDist based image segmantation including measurement of intensity and area. Loops through all images in a directory, where 3 channels are saved as seperated files.

#### Segment_and_Measure_over_time_v1.0.ijm
Similar to Segmentation_and_Measurement_v2.0.ijm. Additionally processes every n-th time frame from each stack in the directory.

#### thresholdmacro_insituHCR_v1.0.ijm
Manually define/modify a threshold binary masks for single cell in situ HCR images.

#### Spotdetection_insituHCR_v1.0.ijm
Counts in situ HCR spots, using thresholds for cell segmentation from thresholdmacro_insituHCR_v1.0.ijm

#### Spotdetection_insituHCR_with_prominence_interation_v1.0.ijm
Similar to Spotdetection_insituHCR_v1.0.ijm. Additionally performes promince value iteration over the entire 8bit scale to be able to determine optimal prominence value.

#### Colony_Counting_v1.0.ijm.ijm.ijm
Detect and Count colonies stained with alkaline phosphatase from stitched tile scans (e.g. whole 6-well plate well). Based on manual threshold selection and provides opportunity to mannually correct detects spots.
