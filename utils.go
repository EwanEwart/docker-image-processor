package main

import "os"

// check if file exists
func fileExists(path string) bool {
	fileInfo, err := os.Stat(path)

	if err != nil {
		return false // return `false` on error
	}

	return !fileInfo.IsDir() // return `true` if file is not a directory
}
