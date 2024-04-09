#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

void chmod_if_needed(char *path) {
	// get mode info from file
	struct stat s;

	if (stat(path, &s) != 0) {
		perror(path);
		exit(1);
	}

	// do i need to change it?
	mode_t mode = s.st_mode;
	if (mode & S_IWOTH) {
		// change the file
		mode = mode & (~S_IWOTH);
		printf("changing %s... ", path);
		if (chmod(path, mode) != 0) {
			perror(path);
			exit(1);
		}
		printf(" done!\n");

	} else {
		printf("%s is not publically writable.\n", path);
	}

}

int main(int argc, char *argv[]) {
	
	for (int i = 1; i < argc; i++) {
		chmod_if_needed(argv[i]);
	}
	return 0;
}
