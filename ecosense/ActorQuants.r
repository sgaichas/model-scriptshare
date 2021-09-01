#June 12, 2008  this is the function that does the work along with an actor file derived from any Seed_All file; it produces individual actor quantile files that need concatenation into a large file; trivial in cygwin.
#function to get quantiles from raw data file
#rewrote as R script June 2012

#setwd(getwd())

require("batch")
parseCommandArgs()

datfile <- read.csv(paste(filename, ".csv", sep=""))
actorfile <- read.csv(paste(groupnames, ".csv", sep=""))

#datfile <- subset(datfile[,1:(dim(datfile)[2]-7)]) #beware hard coding!

actors<-actorfile
for (i in 1:nrow(actors))
{
actor<-subset(datfile, Actor==paste(actors[i,]))
actorquants<-sapply(actor[,6:ncol(datfile)], quantile, probs=seq(0,1,0.025), na.rm=T)
actorquants<-t(actorquants)
actorquants<-cbind(rep(paste(actors[i,]),nrow(actorquants)),actorquants)
outname<-paste(filename, actors[i,], "quants.csv", sep="_")
write.csv(actorquants, outname)
if (i==1) allquants<-actorquants
if (i>1) allquants<-rbind(allquants, actorquants)
rm(actor, actorquants, outname)
}
write.csv(allquants, paste(filename, "allquants.csv", sep="_"))
#cleanup workspace, if desired
rm(list=objects()) 


#now try on GOA full results (change to correct directory for different perturbations):
#setwd("D:/WorkSpace/EcosystemMods/GOAecomod/EcoAssess/SenseInC/GOAfits_KeepSenseResults") original files

#GOAactors<-read.csv("GOAactors.csv")
#GOAdata<-read.csv("GOA_AllDiffs1.csv")

#a stray column was added which messes up quantile, so remove it, would be GOAdata<-subset(GOAdata[,1:129])
#also remove the nans for Outside Prod, Discards, Offal, Pelagic Benthic and Outside detritus
#GOAdata<-subset(GOAdata[,1:123])

#quantsforsense(GOAdata, GOAactors)

#concatenating only seeds 1,3,5, and 7 in the EBS to have similar sample size to GOA(change to correct directory for different perturbations):
#setwd("D:/WorkSpace/EcosystemMods/GOAecomod/EcoAssess/SenseInC/EBSfits_KeepSenseResults") original files

#EBSdata<-read.csv("EBS_Seed1357Diffs1.csv")

#same with this one, checked it and the added column X is empty, so stripped it off here too.
#out<-EBSdata$X
#write.csv(out, "out.txt")

#EBSdata<-subset(EBSdata[,1:134])

#quantsforsense(EBSdata, EBSactors)
