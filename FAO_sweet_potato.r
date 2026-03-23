library(readr)
library(dplyr)

d <- as_tibble(read.csv("/home/mikulas-knazovicky/R_directory/FAO_sweet_potato/FAOSTAT_data_en_3-23-2026.csv"))
d

yield <- d  %>% 
    filter(Element == "Yield")
yield

summary(yield)

yield_24 <- yield %>% 
    filter(Year == 2024)

library(ggplot2)

yield_24_plot <- yield_24 %>% 
    filter(Value >= 8000)  %>% 
    ggplot(aes(x = reorder(Area, Value), y = Value)) +
        geom_col() +
        xlab("") +
        ylab("Yield") +
        scale_y_continuous(expand = c(0,0)) +
        theme_classic() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
yield_24_plot

harvested <- d %>% 
    filter(Element == "Area harvested")

harvested %>% 
    ggplot(aes(x = Year, y = Value, groups = Area)) +
    geom_line() +
    geom_point()

harvested_24 <- harvested %>% 
    filter(Year == 2024)

harvested_24_plot <- harvested_24 %>% 
    arrange(Value) %>% 
    filter(Value >= 10000) %>% 
    ggplot(aes(x = reorder(Area, Value), y = Value)) +
        geom_col() +
        xlab("") +
        ylab("Yield") +
        scale_y_continuous(expand = c(0,0)) +
        theme_classic() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
harvested_24_plot


ggsave("yield_24_plot.jpg",
        yield_24_plot,
        width = 10,
        height = 5)

ggsave("harvested_24_plot.jpg",
        harvested_24_plot,
        width = 10,
        height = 5)
