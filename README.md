# Introductory Course

IntroCourse R material for "Spetses Simulated Outbreak"

### Background:

This repository contains the R teaching material that can be used (it is not compulsory) during the Simulated Outbreak (SimOb) section of the Introductory Course module of the EPIET (European Programme of Intervention Epidemiology Training), EUPHEM (European Public Health Microbiology) and MediPIET (Mediterranean and Black Sea Programme for Intervention Epidemiology Training) fellowships.

The SimOb is a 5-day exercise where fellows are provided a series of injects through which they will follow a 10-steps framework to investigate a specific outbreak. Some of the injects are dedicated to R-exercises that can be proved quite handy during an outbreak investigation. Those injects are maintained in this repository and are stored as different .qmd files, in the scripts folder:

-   01_Data_import_cleaning.qmd
-   02_Case_definition.qmd
-   03_Lab_and_Descriptive.qmd
-   04_Univariate.qmd
-   05_Stratified.qmd

The file `index.qmd` generates the landing page to a GitHub IO website (publically accessible) which provides a brief introduction to the scripts and links to the rendered HTML page for each script.

The folder `maintenance` contains a parameterised Quarto script to update the onset dates and sample collection dates in the case line list and lab data, respectively. This script should be run by a facilitator or exercise lead each year to update the dates and make sure they correlate with the real-time events, as the exercise is conducted as a live scenario.

If any changes are made to the Quarto scripts, please render them to HTML and move the updated HTML files to the `docs` folder. This will ensure that the content displayed on the GitHub IO website is the latest version.

### Acknowledgements:

This material was developed from the Copenhagen outbreak case study that was originally presented in the fellowship program 'Computer tools in Outbreak Investigations' (CTOI) module. The materials for the live action simulation exercise were developed by Esther Kukielka Zunzunegui and updated by Alberto Mateo. The material is reviewed and updated where needed on an annual basis, prior to the module. Please see the title pages for copyright details and a list of authors and contributors.

To report bugs or make feature requests, please post an issue [here](https://github.com/EPIET/IntroCourse_inCop/issues).
