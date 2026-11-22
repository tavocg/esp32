#include <stdio.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

void app_main(void)
{
    for (;;) {
        puts("Hello, world!");
        fflush(stdout);
        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}
