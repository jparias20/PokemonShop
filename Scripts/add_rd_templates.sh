#!/bin/bash

# Directory where Xcode is typically installed
XCODE_DIR="/Applications"

# Find the latest Xcode app by modification date
LATEST_XCODE=$(ls -t "$XCODE_DIR" | grep -E '^Xcode.*\.app$' | head -n 1)

# Check if an Xcode app was found
if [ -n "$LATEST_XCODE" ]; then
    echo "Latest Xcode App: $LATEST_XCODE"
else
    echo "No Xcode app found in $XCODE_DIR"
fi

# Define xctemplate
RD_TEMPLATE=" RD.xctemplate"

# Define the source templates path
SOURCE_TEMPLATE_PATH="Templates"

# Define the target directory where you want to copy the template
TARGET_DIRECTORY="/Applications/${LATEST_XCODE}/Contents/Developer/Library/Xcode/Templates/File Templates/MultiPlatform"

# Expand the ~ to the full path
TARGET_DIRECTORY=$(eval echo $TARGET_DIRECTORY)

# Check if the source template exists
if [ ! -d "$SOURCE_TEMPLATE_PATH" ]; then
    echo "Source template does not exist: $SOURCE_TEMPLATE_PATH"
    exit 1
fi

# Define TARGET_DIRECTORY_SOURCE
TARGET_DIRECTORY_SOURCE="$TARGET_DIRECTORY/Source"

# Define TARGET_DIRECTORY_USER_INTERFACE
TARGET_DIRECTORY_USER_INTERFACE="$TARGET_DIRECTORY/User Interface"

# Define Class Swift File RD.xctemplate to the target directory
SOURCE_CLASS_TEMPLATE_PATH="$SOURCE_TEMPLATE_PATH/Class Swift File$RD_TEMPLATE"

# Copy Class Template in xcode templates
cp -R "$SOURCE_CLASS_TEMPLATE_PATH" "$TARGET_DIRECTORY_SOURCE"

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Template $SOURCE_CLASS_TEMPLATE_PATH copied successfully."
    echo "to $TARGET_DIRECTORY_SOURCE"
    echo " "
else
    echo "Failed to copy the template. $SOURCE_CLASS_TEMPLATE_PATH"
fi

# Define Class Swift File RD.xctemplate to the target directory
SOURCE_STRUCT_TEMPLATE_PATH="$SOURCE_TEMPLATE_PATH/Struct Swift File$RD_TEMPLATE"

# Copy Struct Template in xcode templates
cp -R "$SOURCE_STRUCT_TEMPLATE_PATH" "$TARGET_DIRECTORY_SOURCE"

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Template $SOURCE_STRUCT_TEMPLATE_PATH copied successfully."
    echo "to $TARGET_DIRECTORY_SOURCE"
    echo " "
else
    echo "Failed to copy the template. $SOURCE_STRUCT_TEMPLATE_PATH"
fi

# Define Class Swift File RD.xctemplate to the target directory
SOURCE_SWIFTUI_TEMPLATE_PATH="$SOURCE_TEMPLATE_PATH/SwiftUI View$RD_TEMPLATE"

# Copy SwiftUI Template in xcode templates
cp -R "$SOURCE_SWIFTUI_TEMPLATE_PATH" "$TARGET_DIRECTORY_USER_INTERFACE"

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Template $SOURCE_SWIFTUI_TEMPLATE_PATH copied successfully"
    echo "to $TARGET_DIRECTORY_USER_INTERFACE"
    echo " "
else
    echo "Failed to copy the template. $SOURCE_SWIFTUI_TEMPLATE_PATH"
fi
