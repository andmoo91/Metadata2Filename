// batch directory

// Import Bio-Formats plugins
run("Bio-Formats Macro Extensions");

// Prompt the user to select a folder
inputFolder = getDirectory("Select the folder containing the images");

// Process the files in the input folder and its subfolders
processFolder(inputFolder);

// Display completion message
print("Batch processing complete for " + inputFolder);

function processFolder(folder) {
    // Get a list of files in the folder
    list = getFileList(folder);

    // Process each file
    for (i = 0; i < list.length; i++) {
        file = folder + list[i];

        // Check if the current item is a directory
        if (File.isDirectory(file)) {
            // If it's a directory, process its contents
            processFolder(file + "/");
        } else {
            // Check if the file is a .czi file
            if (endsWith(file, ".czi") || endsWith(file, ".CZI")) {
                Ext.setId(file);

                Ext.setId(file);

    // Get the OME core metadata
   	Ext.getSizeX(sizeX);
	Ext.getSizeY(sizeY);
	Ext.getSizeZ(sizeZ);
	Ext.getSizeC(sizeC);
	Ext.getSizeT(sizeT);


    c = sizeC;
    z = sizeZ;
    t = sizeT;
    
    // Get the acquisition date
  
    Ext.getMetadataValue("Information|Document|CreationDate", creationDate);  //980 Metadata in the format 2023-01-10T12:04:58.4845231-05:00
    Ext.getMetadataValue("Information|Document|CreationDate #1", creationDate1);  //980 Metadata in the format 2023-01-10T12:04:58.4845231-05:00

	if (creationDate==0) creationDate = creationDate1;
    
   
    // Extract only the YYYY-MM-DD portion
    acquisitionDate = substring(creationDate, 0, 10);
    
    // Create the new filename
    newFilename = acquisitionDate + "_C" + c + "_Z" + z + "_T" + t + "_" + list[i];
    
 

                // Rename and save the image file
                File.rename(file, folder + newFilename);
            } else {
                // If the file is not a .czi file, print a message and skip it
                print("Not a .czi file: " + file);
            }
        }
    }
}