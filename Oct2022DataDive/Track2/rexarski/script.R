if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, tmap, sf, tmaptools, readxl)

som_ad0 <-
  st_read("https://raw.githubusercontent.com/wmgeolab/geoBoundaries/bd23105a8c738c9475565027b44f7560facd525d/releaseData/gbOpen/SOM/ADM0/geoBoundaries-SOM-ADM0.geojson")
som_ad1 <-
  st_read("https://raw.githubusercontent.com/wmgeolab/geoBoundaries/6c3996830a06c89d805deb324f6e06748b192048/releaseData/gbOpen/SOM/ADM1/geoBoundaries-SOM-ADM1.geojson")
som_ad2 <-
  st_read("https://raw.githubusercontent.com/wmgeolab/geoBoundaries/c3773fec84513e336862c6388cebc7aa8cdff76c/releaseData/gbOpen/SOM/ADM2/geoBoundaries-SOM-ADM2.geojson")

som_pop <- read_csv("Oct2022DataDive/Track2/rexarski/data/somalia/population/som_pplp_adm2_v2.csv")

som_ad2 <-
  som_ad2 %>%
  left_join(som_pop, by = c("shapeName" = "Admin2Name_en")) %>%
  select(-c(T_TL_2005, U_TL_2005, R_TL_2005, U_TL, R_TL, IDP_TL))

ken <-
  st_read("https://raw.githubusercontent.com/wmgeolab/geoBoundaries/3bfad25a5c2f988b7dbb1d96f5da8a63ff32d6ff/releaseData/gbOpen/KEN/ADM2/geoBoundaries-KEN-ADM2.geojson")

ken_pop <- read_excel("Oct2022DataDive/Track2/rexarski/data/kenya/ken_admpop_2019.xlsx",
  sheet = "ken_admpop_ADM2_2019"
) %>%
  select(c(ADM2_NAME, T_TL))

ken <-
  ken %>%
  left_join(ken_pop, by = c("shapeName" = "ADM2_NAME"))

shapes <- list(som_ad0, som_ad1, som_ad2, ken) %>%
  set_names("som_ad0", "som_ad1", "som_ad2", "ken")

som_health_facs <- st_read("Oct2022DataDive/Track2/rexarski/data/somalia/shapefiles/somalia-health-facilities/unicef_health_2005.shp")
ken_health_facs <- st_read("Oct2022DataDive/Track2/rexarski/data/kenya/shapefiles/hotosm_ken_health_facilities_points_shp/hotosm_ken_health_facilities_points.shp")

shapes$som_ad2 <- shapes$som_ad2 %>%
  select(c(shapeName, shapeGroup, T_TL, geometry))
shapes$ken <- shapes$ken %>%
  select(c(shapeName, shapeGroup, T_TL, geometry))

shapes$merged <- shapes$som_ad2 %>%
  bind_rows(shapes$ken) %>%
  rename(Population = T_TL)

tmap_mode("view")


my_map <-
  tm_basemap(c("Esri.WorldGrayCanvas", "OpenStreetMap")) +
  tm_tiles(c(TonerHybrid = "Stamen.TonerHybrid")) +
  tm_shape(shapes$merged,
    name = "Population Choropleth"
  ) +
  tm_polygons(
    border.col = "#333333",
    col = "Population",
    style = "fixed",
    breaks =
      c(1, 100000, 250000, 500000, 1000000, 2000000),
    palette = "YlOrRd",
    n = 5,
    contrast = c(0.2, 0.9),
    title = "Total Population"
  ) +
  tm_shape(som_health_facs,
    name = "Somalian Health Facilities"
  ) +
  tm_dots(
    clustering = TRUE,
    size = 0.1,
    col = "lightblue"
  ) +
  tm_shape(ken_health_facs,
    name = "Kenyan Health Facilities"
  ) +
  tm_dots(
    clustering = TRUE,
    size = 0.1,
    col = "red"
  )

tmap_save(my_map, "Oct2022DataDive/Track2/rexarski/index.html")

styler::style_dir()
