#include <stdio.h>
#include <string.h>
#include <errno.h>

#define MAX_LINE_LEN 4096

void search_stream(FILE* stream, char stream_name[], char search_for[]) {
	// search stream for search term and print lines that contain it

	char line[MAX_LINE_LEN];
	int line_no = 1;

	while (fgets(line, MAX_LINE_LEN, stream) != NULL) {
		if (strstr(line, search_for) != NULL) {
			printf("%s: %d: %s", stream_name, line_no, line);
		}
		line_no++;
	}
}

int main(int argc, char *argv[]) {
	if (argc < 2) {
		fprintf(stderr, "Usage: %s search_term <filenames>\n", argv[0]);
		return 1;
	} else if (argc == 2) {
		// search stdin
		search_stream(stdin, "<stdin>", argv[1]);
	} else {
		// search through files
		for (int arg = 2; arg < argc; arg++) {
			// search term in argv[1]
			// file name argv[arg]
			FILE *input = fopen(argv[arg], "r");
			if (input == NULL) {
				// error - couldn't open file for some reason
				fprintf(stderr, "%s: %s: %s", argv[0], argv[arg], strerror(errno));
				return 1;
			}
			// no problems!
			search_stream(input, argv[arg], argv[1]);
			fclose(input);
		}
	}
	return 0;
}
