#include <stdio.h>
#include <stdlib.h>

void functional(int number)
{

    int least_recent = 0;
    int middle = 1;
    int most_recent = 1;
    int counter = 0;

    while (counter < number)
    {
        if (counter == 0 || counter == 1)
        {
            printf("%d\n", 1);
            counter += 1;
        }
        else
        {
            int temp = least_recent + middle + most_recent;
            least_recent = middle;
            middle = most_recent;
            most_recent = temp;
            printf("%d\n", temp);
            counter += 1;
        }
    }
}

int main(int argc, char *argv[])
{

    int input = atoi(argv[1]);
    functional(input);

    return EXIT_SUCCESS;
}