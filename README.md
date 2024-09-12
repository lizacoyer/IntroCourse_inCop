# Introductory Course

IntroCourse R material for "Spetses Simulated Outbreak"

### Background:

This repository contains the R teaching material that can be used (it is not compulsory) during the Simulated Outbreak (SimOb) section of the Introductory Course module of the EPIET (European Programme of Intervention Epidemiology Training), EUPHEM (European Public Health Microbiology) and MediPIET (Mediterranean and Black Sea Programme for Intervention Epidemiology Training) fellowships.

The SimOb is an 4-day exercise where fellows are provided a series of injects through which they will follow a 10-steps framework to investigate a specific outbreak. Some of the injects are dedicated to R-exercises that can be proved quite handy during an outbreak investigation. Those injects are maintained in this repository and are stored as different .qmd files, under the root folder:

- Data_import_cleaning.qmd
- Case_definition.qmd
- Lab_and_Descriptive.qmd
- Univariate.qmd
- Stratified.qmd



# REST (FROM TO HEREFORWARDS) NEEDS UPDATING

For each exercise, a HTML R case study guide has been provided, as well as a .zip folder containing all the required materials (data, scripts and a copy of the guide). The R guides and compressed folders of the associated materials can be accessed online and downloaded from the links [on this web page](https://epiet.github.io/OutbreakInvestigation/).

### Acknowledgements:

This material is based on equivalent practical guides for STATA and ArcGIS, respectively. Each guide is presented as an R markdown document; please see the title pages for copyright details and a list of authors and contributors.

### Requirements:

Each exercise requires the use of one or more teaching datasets, which are included in this repository.

To run the R markdown guides or R templates, participants and facilitators will need to install the following software:

-   R (download and install the latest version from CRAN [here](https://cran.r-project.org/))
-   RStudio (download the latest version as an installer or ready-to-use `.zip` file [here](https://rstudio.com/products/rstudio/download/))
-   Rtools (download and install the latest version from CRAN [here](https://cran.r-project.org/bin/windows/Rtools/))

A list of required R packages and functions, as well as code to install them has been included in the guides and associated materials for each exercise.

### How to download the code for testing:

After installing the above software, if you wish to just run / test the code without making any changes, you can clone this repository either by clicking on the green `Clone or download` button on this page, or by entering the following command into git bash on your computer:

```{r, eval=FALSE}
git clone https://github.com/EPIET/OutbreakInvestigation.git
```

### How to download the code for updating:

*Note:* code maintainers should be proficient in the use of Github. If you have not worked with Github before, please team up with someone that knows how to use Github for version control and is familiar with this repository. You can share the edits you wish to make with them via the issues tab, or alternatively ask them to help you with the steps below.

If you wish to update the code for any of these exercises, follow these steps:

1.  Document the details of bugs or other requests for updates on the [issues tab](https://github.com/EPIET/OutbreakInvestigation/issues) of this repository.
2.  On the `code` tab of this repository, click on the `Master` button and create a new branch by typing a name for your branch in the dialogue box, e.g. `my_updates`.
3.  Follow the on-screen instructions to complete creation of the branch.
4.  Switch to the new branch.
5.  Clone this branch to your computer.
6.  To edit the guide or code for a specific exercise, open the `.Rproj` file inside the folder for that exercise and open the script or R markdown from within the R project. Note the file paths to access data etc are relative to these sub-folders.
7.  To edit this README, open the `.Rproj` file in the root of the repository.
8.  After editing an R markdown, remember to knit it to HTML.
9.  Move the knit outputs (HTML guide and R script) to the `guide` and `rscripts` subfolders, respectively, within the relevant exercise folder.
10. In the `docs` folder in the root directory, you will find the old versions of the HTML guides and .zip folders of materials for each exercise. These need to be replaced every time you edit the material.
11. First, copy and paste the updated HTML guide into the `docs` folder.
12. Next, check the contents of the .zip folder for the exercise you updated, go back into the relevant subfolder and create the .zip folder again. When done, move the .zip folder to the `docs` folder.\
13. It is important that the `docs` folder contains all the up to date guides and materials, as the web page that module participants will be working from and downloading the materials from depends on the contents of this folder.
14. Once done, push your changes back to your branch using git via RStudio or git bash as you prefer.
15. Return to this (online) repository, make sure to switch to your branch if not already on it, and follow the on-screen instructions to make a pull request.
16. Once the repository maintainer has accepted and merged your pull request to the main branch, you should check the [Outbreak Investigation module web page](https://epiet.github.io/OutbreakInvestigation/) to make sure that the guides displayed are the latest ones with your edits.

To provide a printed copy of the R markdown practical guide for participants:

-   Open the relevant R markdown document in RStudio (as above)
-   Click on the `Knit` button and select `Knit to pdf`
-   This will save a .pdf version of the document in your working directory, which can then be printed.

### Maintenance:

This project is currently being maintained by [Amy Mikhail](https://github.com/AmyMikhail).

Contributions are welcome: please contact the maintainer to request access.

To report bugs or make feature requests, please post an issue [here](https://github.com/EPIET/OutbreakInvestigation/issues).
