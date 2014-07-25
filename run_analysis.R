#             Description of the experiment
#
# The experiments have been carried out with a group of 30 volunteers
# within an age bracket of 19-48 years. Each person performed six 
# activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
# STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
# waist. Using its embedded accelerometer and gyroscope, we captured 
# 3-axial linear acceleration and 3-axial angular velocity at a 
# constant rate of 50Hz. The experiments have been video-recorded
# to label the data manually. The obtained dataset has been randomly
# partitioned into two sets, where 70% of the volunteers was selected
# for generating the training data and 30% the test data. 

# The sensor signals (accelerometer and gyroscope) were pre-processed
# by applying noise filters and then sampled in fixed-width sliding 
# windows of 2.56 sec and 50% overlap (128 readings/window). The sensor
# acceleration signal, which has gravitational and body motion 
# components, was separated using a Butterworth low-pass filter
# into body acceleration and gravity. The gravitational force is
# assumed to have only low frequency components, therefore a filter
# with 0.3 Hz cutoff frequency was used. From each window, a vector
# of features was obtained by calculating variables from the time 
# and frequency domain. See 'features_info.txt' for more details. 

# For each record it is provided:
#   ======================================
#   
# - Triaxial acceleration from the accelerometer (total acceleration) 
#   and the estimated body acceleration.
# - Triaxial Angular velocity from the gyroscope. 
# - A 561-feature vector with time and frequency domain variables. 
# - Its activity label. 
# - An identifier of the subject who carried out the experiment.

## open data to use.
testX<-read.table("./test/X_test.txt",sep="") # Train set
testY<-read.table("./test/y_test.txt") # Train labelstestX$label<-testY

trainX<-read.table("./train/X_train.txt") # Train set
trainY<-read.table("./train/y_train.txt") # Train labels

X<-rbind(trainX,testX) # 561 features matrix, with both train and test sets
Y<-rbind(trainY,testY) # 1 column matrix, with both train and test set

strain<-read.table("./train/subject_train.txt") # train subject set
stest<-read.table("./test/subject_test.txt") # test subject set

subject<-rbind(strain,stest) #Matrix to be combined with the other

features<-read.table("./features.txt") # names of 561 variables

#subset of matrix only with mean() and std() function as from features

Dataset<-X[,features$V1[grepl("mean()",features$V2)|
                      grepl("std()",features$V2)]] 

z<-as.factor(Y[,1])
activity<-read.table("./activity_labels.txt") # Activity codes meaning
#Renaming activity
Z<-factor(z,levels=as.factor(activity$V1),labels=activity$V2) # Setting labels to values.

# add activity and subject to the database
Dataset<-cbind(Z,Dataset) 
Dataset<-cbind(as.factor(subject[,1]),Dataset)

colnames(Dataset)<-c("subject","label",as.vector(features$V2[grepl("mean()",features$V2)|
                                       grepl("std()",features$V2)])) # naming the columns 

summary(Dataset$subject)
#reshape Dataset to make tidyData
Tidy<-aggregate(Dataset,by=list(Dataset$subject,Dataset$label),FUN=mean)
Tidy<-Tidy[,-c(3,4)] # eliminate subject and label columns set as NA

#Rename Columns
colnames(Tidy)<-c("subject","label",as.vector(features$V2[grepl("mean()",features$V2)|
                                                               grepl("std()",features$V2)])) # naming the columns 

# Make readable the columns, eliminating the second 'Body' in the name.
sep<-strsplit(names(Tidy), 'fBodyBody')
names<-NULL
for(i in 1:81){
  if(length(sep[[i]])<2) names<-c(names,sep[[i]][1])
  else names<-c(names,paste("Body",sep[[i]][2]))
}
colnames(Tidy)<-names

write.table(Tidy,"./TidyData.txt")
