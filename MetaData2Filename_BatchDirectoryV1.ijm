//This ImageJ macro is designed to process .czi image files within a user-selected directory and its subdirectories. 
//It first prompts the user to choose a folder containing the images. 
//The macro then iteratively processes each file in the folder, as well as any files in subfolders. 
//If the current item is a directory, the macro processes its contents recursively. 
//Before processing a file, the macro checks if it has already been processed (identified by a specific naming pattern at the beginning of the file name). 
//If it has, the file is skipped, and a message is printed. If the file has not been processed, the macro checks if it is a .czi file. 
//If it is not, the file is skipped, and a message is printed. 
//If it is a .czi file, the macro extracts metadata, including the acquisition date and image dimensions. 
//It then creates a new filename using this metadata and renames the file accordingly. Once all files have been processed, the macro displays a completion message.


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
            // Check if the file has already been processed
            alreadyProcessed = alreadyProcessed = matches(list[i], "^\\d{4}-\\d{2}-\\d{2}_C\\d+_Z\\d+_T\\d+_.*");

            if (alreadyProcessed) {
                print("Already processed: " + file);
            } else {
                // Check if the file is a .czi file
                if (endsWith(file, ".czi") || endsWith(file, ".CZI")) {
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
}