//$(which go) run $0 $@ ; exit

package main

import (
	"fmt"
	"os"
)

func main() {

	// check length of the arguments
	if len(os.Args) < 3 {
		fmt.Println("Error: Insufficient arguments.")
		os.Exit(1)
	}

	// get srcPath and outPath
	srcPath := os.Args[1]
	outPath := os.Args[2]

	// call `makeAvatar` function
	if err := makeAvatar(srcPath, outPath); err != nil {
		fmt.Println("Opps! Something went wrong.", err)
		os.Exit(1)
	} else {
		fmt.Printf("Success! Image has been generated at %v.\n", outPath)
	}
}
