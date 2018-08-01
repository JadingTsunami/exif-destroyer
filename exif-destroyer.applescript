set image_files to choose file with prompt "Please select images to EXIF strip:" of type {"public.image"} with multiple selections allowed

set image_count to length of image_files
set progress total steps to image_count
set progress completed steps to 0
set progress description to "Stripping EXIF from images..."
set progress additional description to "Preparing to strip EXIF data."

set good to 0
set total to 0

repeat with a from 1 to length of image_files
	
	set progress additional description to "Stripping EXIF from image " & a & " of " & image_count
	
	try
		set f to item a of image_files
		do shell script "/usr/local/bin/mogrify -strip " & (quoted form of POSIX path of f)
		set good to (good + 1)
	on error
		display dialog "Failed to strip: " & (quoted form of POSIX path of f as string)
	end try
	
	set total to (total + 1)
	set progress completed steps to a
	
end repeat
display dialog "Successfully stripped " & good & " out of " & total & " images."

set progress total steps to 0
set progress completed steps to 0
set progress description to ""
set progress additional description to ""
