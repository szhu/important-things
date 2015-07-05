set path_to_course_materials ~/Code/cs/grading/course-materials
set -x CLASSPATH $CLASSPATH $path_to_course_materials/lib/* .
set -x PATH $PATH $path_to_course_materials/lib/pygrader $path_to_course_materials/lib/reader_scripts
