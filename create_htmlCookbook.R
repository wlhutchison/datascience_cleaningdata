##
##  Creates a html table of the variables as a part of the cookbook
##
sink("cookbook.html", append= F, type= "output", split=F)
writeLines("<table>")
writeLines("<th>")
writeLines("#<td>Variable Name</td><td>Description</td>")
writeLines("</th>")
for (id in 1:length(subset)) {
  description <- ""
  myvar <- subset[id];
  if (id == 1) description <- "Subject id code"
  if (id == 2) description <- "Type of activity"
  if (id > 2) {
  if (grepl("Mean", myvar))
    description <- c(description, "Mean of ");
  if (grepl("StandardDeviation", myvar))
    description <- c(description, "Standard deviation of ");
  if (grepl("Magnitude", myvar))
    description <- c(description, "the magnitude of ");
  if (grepl("Jerk", myvar)) {
    if (grepl("Body", myvar))
      description <- c(description, "the linear velocity ");
    if (grepl("Gravity", myvar))
      description <- c(description, "the angular velocity ");    
  }
  else {
    if (grepl("Body", myvar))
      description <- c(description, "the body acceleration ");
    if (grepl("Gravity", myvar))
      description <- c(description, "the gravitational acceleration ");    
  }
   if (grepl("Accelerometer", myvar))
    description <- c(description, "as measured by the accelerometer ");
  if (grepl("Gyroscope", myvar))
    description <- c(description, "as measured by the gyroscope ")
  if (grepl("X", myvar))
    description <- c(description, "along the X-axis");
  if (grepl("Y", myvar))
    description <- c(description, "along the Y-axis");
  if (grepl("Z", myvar))
    description <- c(description, "along the Z-axis");
  if (grepl("Time",myvar))
    description <- c(description, " [Time signal in Hz]");
  if (grepl("Frequency",myvar))
    description <- c(description, " [Fast Fourier Transform frequency in Hz]");
  }
  writeLines("<tr>");
  writeLines(c("<td>", id, "</td><td>", subset[id], "</td><td>", description ,"</td>"));
  writeLines("</tr>")
}
writeLines("</table>")
sink()