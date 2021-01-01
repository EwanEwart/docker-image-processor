package main

import (
	"testing"
)

// test `makeAvatar` function
func TestMakeAvatar(t *testing.T) {

	// test images (srcPath:outPath)
	images := map[string]string{
		"tmp/src/model-1.jpeg": "tmp/out/model-1.jpg",
		"tmp/src/model-2.jpeg": "tmp/out/model-2.jpg",
	}

	// for each image, make an avatar and check if file exists
	for srcPath, outPath := range images {
		err := makeAvatar(srcPath, outPath)

		if err != nil {
			t.Error("Could not save avatar.", err)
		} else if !fileExists(outPath) {
			t.Error("Could not find ouput file.")
		} else {
			t.Logf("Successfully generated \"%v\".", outPath)
		}
	}
}
