#include <stdio.h>
#include <stdlib.h>

int recurssion(int input) {
    if (input == 0) {
        return 2;
    }
    return (3*input) - (2*(recurssion(input-1))) + 7;
}

int main(int argc, char *argv[]) {

    int input = atoi(argv[1]);
    printf("%d\n", recurssion(input));

    return EXIT_SUCCESS;
}
