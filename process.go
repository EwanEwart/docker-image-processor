package main

import (
	"fmt"

	"github.com/disintegration/imaging"
)

// generate and save an avatar picture from a photo
func makeAvatar(srcPath string, outPath string) error {

	// check if file exists
	if !fileExists(srcPath) {
		return fmt.Errorf("%v path does not exist or not a file", srcPath)
	}

	/*-----------*/

	// open a source image
	src, err := imaging.Open(srcPath)

	if err != nil {
		return nil
	}

	/*-----------*/

	// find minimum dimension (width or height)
	bounds := src.Bounds()
	size := bounds.Max.X // width

	if bounds.Max.Y < size {
		size = bounds.Max.Y // height
	}

	/*-----------*/

	// modify image
	out := imaging.CropAnchor(src, size, size, imaging.Top) // resize
	out = imaging.Grayscale(out)                            // saturation
	out = imaging.AdjustContrast(out, 10)                   // contrast
	out = imaging.AdjustBrightness(out, 5)                  // brightness

	/*-----------*/

	// save image
	if err := imaging.Save(out, outPath); err != nil {
		return err
	}

	/*-----------*/

	// return `nil` error
	return nil
}
