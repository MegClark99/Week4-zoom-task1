chaff <- read.table("chaff.txt", header = TRUE)

library(tidyverse)

chaff<- chaff%>% 
  pivot_longer(names_to = "sex", 
               values_to = "mass",
               cols = everything())

file <-  "chaff.txt"
write.table(chaff, 
            file, 
            quote = FALSE,
            row.names = FALSE)

str(chaff)
library(Rmisc)
chaffsummary <- summarySE(chaff, measurevar = "mass", groupvar = "sex")

t.test(data = chaff, mass~sex, paired = TRUE)
# t = -2.5168, df = 19, p-value = 0.02098

library(ggplot2)
library(ggpubr)


fig1 <- ggplot(data = chaffsummary, aes(x = sex, y = mass) ) +
  geom_errorbar(aes( ymin = mass, 
                     ymax = mass), 
                width = .5, 
                colour = "red",
                size = 1) +
  geom_errorbar(aes( ymin = mass - se, 
                     ymax = mass + se), 
                width = .7, 
                colour = "red")


# figure saving settings
units <- "in"  
fig_w <- 3.5
fig_h <- fig_w
dpi <- 300
device <- "tiff" 

ggsave("fig1.tiff",
       plot = fig1,
       device = device,
       width = fig_w,
       height = fig_h,
       units = units,
       dpi = dpi)

