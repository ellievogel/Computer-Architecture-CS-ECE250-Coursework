#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

int log2(int n)
{
    int r = 0;
    while ((n >>= 1) != 0)
        r++;
    return r;
}

int ones(int num_ones)
{
    return (1 << num_ones) - 1;
}

int main(int argc, char *argv[])
{
    struct frame
    {
        bool valid;
        bool dirty;
        char *data;
        int tag;
        int address;
        int start_of_block;
    } frame;

    FILE *fp;
    fp = fopen(argv[1], "r");

    int cache = atoi(argv[2]);
    int cache_in_bytes = cache * 1024;
    int associativity = atoi(argv[3]);
    int block_size = atoi(argv[4]);

    int frames = cache_in_bytes / block_size;
    int sets = (frames / associativity);

    char *memory = (char *)calloc(1 << 24, sizeof(char));

    struct frame **cache_table = (struct frame **)calloc(sets, sizeof(struct frame *));
    for (int row = 0; row < sets; row++)
    {
        cache_table[row] = (struct frame *)calloc(associativity, sizeof(struct frame));
        for (int col = 0; col < associativity; col++)
        {
            cache_table[row][col].data = (char *)calloc(block_size, sizeof(char));
        }
    }

    int index_bits = log2(sets);
    int offset_bits = log2(block_size);
    int tag_bits = 24 - index_bits - offset_bits;

    char load_or_store[10];
    char buffer[64];
    int address = 0;
    int access = 0;

    while (fscanf(fp, "%s", load_or_store) != EOF)
    {
        fscanf(fp, "%s", buffer);
        sscanf(buffer, "%x", &address);

        fscanf(fp, "%d", &access);

        bool hit = false;

        int block_offset = address & ones(offset_bits);

        int index = (address >> offset_bits) & ones(index_bits);
        // printf("%d this is the index\n", index);
        int tag = address >> (offset_bits + index_bits);

        bool load = (strcmp(load_or_store, "load") == 0);

        int i = 0;
        while (!hit && i < associativity)
        {
            // printf("%s %d \n", "tag it is looking for: ", tag);
            if (cache_table[index][i].tag == tag && (cache_table[index][i].valid == true))
            {
                // printf("%s %d %s %d", "current tag for index", i, ": ", cache_table[index][i].tag);
                // cache_table[index][i].address = address;
                hit = true;
                // printf("%d %s \n", i, "what block we are hitting");
                struct frame *hit_frame = (struct frame *)malloc(sizeof(frame));
                hit_frame->data = (char *)malloc(block_size);
                memcpy(hit_frame->data, cache_table[index][i].data, block_size);
                hit_frame->address = cache_table[index][i].address;
                hit_frame->valid = cache_table[index][i].valid;
                hit_frame->dirty = cache_table[index][i].dirty;
                hit_frame->tag = cache_table[index][i].tag;
                hit_frame->start_of_block = cache_table[index][i].start_of_block;

                for (int way_index = i; way_index > 0; way_index--)
                {
                    cache_table[index][way_index].address = cache_table[index][way_index - 1].address;
                    memcpy(cache_table[index][way_index].data, cache_table[index][way_index - 1].data, block_size);
                    cache_table[index][way_index].valid = cache_table[index][way_index - 1].valid;
                    cache_table[index][way_index].tag = cache_table[index][way_index - 1].tag;
                    cache_table[index][way_index].dirty = cache_table[index][way_index - 1].dirty;
                    cache_table[index][way_index].start_of_block = cache_table[index][way_index - 1].start_of_block;
                }
                cache_table[index][0].address = hit_frame->address;
                memcpy(cache_table[index][0].data, hit_frame->data, block_size);
                cache_table[index][0].valid = hit_frame->valid;
                cache_table[index][0].tag = hit_frame->tag;
                cache_table[index][0].dirty = hit_frame->dirty;
                cache_table[index][0].start_of_block = hit_frame->start_of_block;

                printf("%s 0x%x %s", load_or_store, address, "hit ");

                if (load)
                {
                    // printf("%d \n", block_offset);
                    // printf("%d \n", cache_table[index][0].start_of_block);
                    // printf("%d \n", access);
                    for (int i = 0; i < access; i++)
                    {
                        printf("%02hhx", hit_frame->data[block_offset + i]);
                    }
                }
                else
                {
                    for (int i = 0; i < access; i++)
                    {
                        fscanf(fp, "%02hhx", &cache_table[index][0].data[block_offset + i]);
                    }
                    cache_table[index][0].dirty = true;
                }
                printf("\n");
            }
            i++;
        }
        if (hit == false)
        {
            struct frame replacement = cache_table[index][associativity - 1];
            if (replacement.valid == true)
            {
                printf("%s 0x%x", "replacement", replacement.start_of_block);

                if (replacement.dirty)
                {
                    for (int i = 0; i < block_size; i++)
                    {
                        memory[replacement.start_of_block + i] = replacement.data[i];
                    }
                    printf("%s \n", " dirty");
                }
                else
                {
                    printf("%s \n", " clean");
                }
            }

            for (int way_index = associativity - 1; way_index > 0; way_index--)
            {
                cache_table[index][way_index].address = cache_table[index][way_index - 1].address;
                memcpy(cache_table[index][way_index].data, cache_table[index][way_index - 1].data, block_size);
                cache_table[index][way_index].valid = cache_table[index][way_index - 1].valid;
                cache_table[index][way_index].tag = cache_table[index][way_index - 1].tag;
                cache_table[index][way_index].dirty = cache_table[index][way_index - 1].dirty;
                cache_table[index][way_index].start_of_block = cache_table[index][way_index - 1].start_of_block;
            }

            cache_table[index][0].valid = true;
            cache_table[index][0].dirty = false;
            cache_table[index][0].tag = tag;
            // printf("%s %d \n", "tag of loaded block: ", tag);
            cache_table[index][0].start_of_block = address - block_offset;
            cache_table[index][0].address = address;
            for (int i = 0; i < block_size; i++)
            {
                cache_table[index][0].data[i] = memory[cache_table[index][0].start_of_block + i];
            }

            // debugging

            if (load)
            {
                printf("%s 0x%x %s", load_or_store, address, "miss ");
                for (int i = 0; i < access; i++)
                {
                    printf("%02hhx", cache_table[index][0].data[block_offset + i]);
                }
            }
            else
            {

                for (int i = 0; i < access; i++)
                {
                    fscanf(fp, "%02hhx", &cache_table[index][0].data[block_offset + i]);
                }

                cache_table[index][0].dirty = true;
                printf("%s 0x%x %s", load_or_store, address, "miss");
            }
            printf("%s", "\n");
        }
    }

    for (int row = 0; row < sets; row++)
    {
        free(cache_table[row]);
    }
    free(memory);
    free(cache_table);
    fclose(fp);
    return EXIT_SUCCESS;
}