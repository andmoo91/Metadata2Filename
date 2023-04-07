// ImageJ Macro to list files in selected directory and its subdirectories

// Prompt user to select a directory
dir = getDirectory("Choose a directory");

// Call the function to print the filenames in the Results window
listFiles(dir, "");

// Function to list the filenames in a directory and its subdirectories
function listFiles(directory, prefix) {
    list = getFileList(directory);

    for (i = 0; i < list.length; i++) {
        file = list[i];
        filepath = directory + file;
        if (File.isDirectory(filepath)) {
            // Print subdirectory name
            print(prefix + "Subfolder: " + file);
            // List the files in the subdirectory
            listFiles(filepath + "/", prefix + "  ");
        } else {
            // Print the file name
            print(prefix + "File: " + file);
        }
    }
}
