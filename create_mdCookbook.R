##
##  Creates a html table of the variables as a part of the cookbook
##
sink("cookbook.txt", append= F, type= "output", split=F)
writeLines("#|Variable Name|Description|")
for (id in 1:length(subset)) {
  description <- ""
  myvar <- subset[id];
  if (id == 1) description <- "Subject identifier"
  if (id == 2) description <- "Type of activity"
  if (id > 2) {
  if (grepl("Mean", myvar))
    description <- paste(description, "Mean of ");
  if (grepl("StandardDeviation", myvar))
    description <- paste(description, "Standard deviation of ");
  if (grepl("Magnitude", myvar))
    description <- paste(description, "the magnitude of ");
  if (grepl("Jerk", myvar)) {
    if (grepl("Body", myvar))
      description <- paste(description, "the linear velocity ");
    if (grepl("Gravity", myvar))
      description <- paste(description, "the angular velocity ");    
  }
  else {
    if (grepl("Body", myvar))
      description <- paste(description, "the body acceleration ");
    if (grepl("Gravity", myvar))
      description <- paste(description, "the gravitational acceleration ");    
  }
   if (grepl("Accelerometer", myvar))
    description <- paste(description, "as measured by the accelerometer ");
  if (grepl("Gyroscope", myvar))
    description <- paste(description, "as measured by the gyroscope ")
  if (grepl("X", myvar))
    description <- paste(description, "along the X-axis");
  if (grepl("Y", myvar))
    description <- paste(description, "along the Y-axis");
  if (grepl("Z", myvar))
    description <- paste(description, "along the Z-axis");
  if (grepl("Time",myvar))
    description <- paste(description, " [Time signal]");
  if (grepl("Frequency",myvar))
    description <- paste(description, " [Fast Fourier Transform frequency]");
  }
#  info <- "";
#  info <- c(info, id);
#  info <- c(info, "|");
#  info <- c(info, subset[id]);
#  info <- c(info, "|");
#  info <- c(info, description);
#  info <- c(info, "|");
#  writeLines(info)
  writeLines(paste("|", id, "|", subset[id], "|", description ,"|"));
}
sink()
