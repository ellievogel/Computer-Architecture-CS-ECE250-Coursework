#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct players
{
    char name[64];
    int team;
    int opposition;
    struct player *next;
}

void
sort(player **list)
{
    bool sorted = false;
    while (!sorted)
    {
        player *current = *list;
        player *previous = NULL;
        sorted = true;
        while (current != NULL)
        {
            player *next = current->next;
            if (next != NULL && (current->team - current->opposition) < (next->team - next->opposition))
            {
                sorted = false;
                current->next = next->next;
                next->next = current;
                if (previous != NULL)
                {
                    previous->next = next;
                }
                else
                {
                    *list = next;
                }
                current = next;
                next = current->next;
            }
            else if (next != NULL && (current->team - current->opposition) == (next->team - next->opposition) && strcmp(current->name, next->name) > 0)
            {
                sorted = false;
                current->next = next->next;
                next->next = current;
                if (previous != NULL)
                {
                    previous->next = next;
                }
                else
                {
                    *list = next;
                }
                current = next;
                next = current->next;
            }
            previous = current;
            current = next;
        }
    }
}

player *head = NULL;
player *tail = NULL;

int main(int argc, char *argv[])
{
    FILE *fp;
    fp = fopen(argv[1], "r");
    int current_team = 0;
    int current_opposition = 0;
    char current_name[64];
    bool construct = true;

    while (construct)
    {

        fscanf(fp, "%s", current_name);
        if (!strcmp(current_name, "DONE"))
        {
            construct = false;
            break;
        }
        player *currentplayer = (player *)malloc(sizeof(player));
        strcpy(currentplayer->name, current_name);

        fscanf(fp, "%d", &current_team);
        currentplayer->team = current_team;
        fscanf(fp, "%d", &current_opposition);
        currentplayer->opposition = current_opposition;
        currentplayer->next = head;
        head = currentplayer;
    }
    sort(&head);
    while (head != NULL)
    {
        printf("%s %d\n", head->name, head->team - head->opposition);
        player *temp = head->next;
        free(head);
        head = temp;
    }

    fclose(fp);

    return EXIT_SUCCESS;
}
