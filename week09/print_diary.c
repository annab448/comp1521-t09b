#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {

	char *diary_path = ".diary";
	char *home_path = getenv("HOME");
	
	// no HOME environment variable
	if (home_path == NULL) {
		home_path = ".";
	}

	int path_len = strlen(home_path) + strlen(diary_path) + 2;
	char path[path_len];

	snprintf(path, path_len, "%s/%s", home_path, diary_path);
	printf("trying to open %s...\n", path);


	FILE *diary_stream = fopen(path, "r");
	if (diary_stream == NULL) {
		perror(path);
		return 1;
	}

	int c;
	while ((c = fgetc(diary_stream)) != EOF) {
		fputc(c, stdout);
	}

	fclose(diary_stream);
}
