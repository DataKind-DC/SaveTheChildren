# Save The Children

## Overview
This mapping project supports Save The Children's Hackathon Track 2 Goal, **Analyzing health care facilities and population**. Understanding the connection between these two factors is essential in gaining insight into the capacity of medical facilities across Somalia, and identifying areas that could be best served through the construction of additional infrastructure and medical support services. For this deliverable we decided to focus on fielding a web map published through Gitlab Pages to ensure broad accessibility. It incorperates an understanding of medical facility locations recorded by   (could be a map with facility locations and population per region or number of health facility per capita for each region)

## Data
For this project we relied data collected by [UNICEF](https://www.unicef.org/) and hosted on the [Humanitarian Data Exchange (HDX)]([https://www.unicef.org/])(https://data.humdata.org/), an organization which seeks to make humanitarian data easy to find and use to shed light on the world's most pressing humanitarian crises. We leveraged five data sources hosted on this website to generate our findings:


- [Somalia Health Facilities](https://data.humdata.org/dataset/somalia-health-facilities). This dataset contains the coverage of health facilities in Somalia as collected by UNICEF as at January 2005
- [Somalia - Subnational Administrative Boundaries](https://data.humdata.org/dataset/geoboundaries-admin-boundaries-for-somalia). This dataset contains the following administrative boundaries: ADM0, ADM1, ADM2. Only ADM2 was used in the visualization.
- [Somalia - Population Density](https://data.humdata.org/dataset/worldpop-population-density-for-somalia)
- [HOTOSM Kenya Health Facilities (OpenStreetMap Export)](https://data.humdata.org/dataset/hotosm_ken_health_facilities).
    - This theme includes all OpenStreetMap features in this area matching: `healthcare IS NOT NULL OR amenity IN (‘doctors’,‘dentist’,‘clinic’,‘hospital’,‘pharmacy’)`
- [Kenya - Subnational Population Statistics](https://data.humdata.org/dataset/cod-ps-ken). Kenya administrative level 0-2 projected 2019 sex and age disaggregated population statistics. Only Level 2 was used.

