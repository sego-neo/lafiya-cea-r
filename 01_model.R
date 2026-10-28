#1.Input Table(RP base case, 2025 Q1)
cost_total <-215817
doses <- 74909
cyp_per_dose <- 0.25
additionality_base <-0.94
daly_mat_rp <- 3135
daly_chd_rp <- 17050

lafiya <- function(additionality = 0.94, include_child = TRUE) {
  scale <- additionality/additionality_base
  dalys_m <- daly_mat_rp *scale
  dalys_c <- if (include_child) daly_chd_rp*scale else 0
  c(cost_per_daly_total= cost_total/(dalys_m + dalys_c),
    cost_per_daly_mat = cost_total/dalys_m,
    cost_per_daly_chd = if (include_child) cost_total/dalys_c else NA)
}
lafiya(0.94) 
lafiya(0.70) 
lafiya(0.70, include_child=FALSE)
#Note: three verified outputs (10.69 / 68.84 / 12.66 at 0.94) for lafiya(0.94)

#2. Sensitivity Grid
#Load tidyverse package
install.packages("tidyverse")
install.packages("skimr")
library(tidyverse)
library(skimr)
grid <- expand_grid(add = seq(0.5, 1.0, by = 0.05),
                    child = c(TRUE, FALSE)) |>
  mutate(cpd = map2_dbl(add, child, ~ lafiya(.x, include_child = .y)[[1]]))
grid

View(grid)
print(grid, n = Inf)
lafiya (1)

#3. Sensitivity Analysis Chart
install.packages("ggthemes")
library(ggthemes)
p <- ggplot(grid, aes(add, cpd, colour = child)) +
  geom_line(linewidth = 1) +
  labs(x = "Additionality", y = "Cost per DALY averted (USD)",
       colour = "Child DALYs included",
       title = "Lafiya Nigeria CEA — sensitivity to additionality") +
  geom_vline(xintercept = 0.94, linetype = "dashed", colour = "grey50") +
  scale_x_continuous(labels = scales::percent) +
  theme_minimal()
ggsave("sensitivity.png", p, width = 7, height = 4, dpi = 150)




