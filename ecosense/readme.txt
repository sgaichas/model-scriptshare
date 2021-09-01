Files used for ecosense runs supplemental to the NE Herring MSE

(I didn't understand R projects or github in 2016 so please forgive me)

See project writeup `MSE_PredsAppendix.pdf` in this repository, source code in `MSE_PredsAppendix.Rmd`

See also https://github.com/sgaichas/herringMSE/tree/master/EcosSenseArchive for GOM model code

Overview of workflow:

1. `GOM_SenseRuns_16.sh` is the main script that runs the AK-ecosim-C code models and calls processing scripts

2. `SenseStats.sh` tallies kept and discarded systems into files and calls discartStat.r

3. `discardStat.r` finds group that crashed and year for each discarded system and makes summary histograms for full model and each species of number of failures for each model run year

4. `ProcessAll.sh` moves through base and scenario folders running 
    4a. `preprocessSence.sh` tailored for filenames in the folder combining everything back into one file
    (see https://github.com/sgaichas/herringMSE/blob/master/EcosSenseArchive/sense/base/preprocessSense.sh)
    
    4b. copying results into a `diffs` folder
    
    4c. running `SenseProcess.sh`: (see https://github.com/sgaichas/herringMSE/blob/master/EcosSenseArchive/sense/diffs/SenseProcess.sh) which calls SenseDiffs.php (https://github.com/sgaichas/herringMSE/blob/master/EcosSenseArchive/sense/diffs/SenseDiffs.php) that actually calculates differences between the base and perturbed runs for each kept system into a single file
    
5. `ProcessPerturb.sh` further organizes files and runs 'ActorQuants.r` to get quantile results by perturbed species for plotting

6. Plotting code may make better use of modern ggplot, etc; these used the calculated quantiles to back out boxes manually
    




