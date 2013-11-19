#! /bin/bash
# OUTPUT=`cat sampleGet.log`
# echo "$OUTPUT"
# corr_arr=($(echo "$OUTPUT" | grep "seems corrupted" | sed 's/[^0-9]//g'))
# for f in $(echo "$OUTPUT" | grep "seems corrupted" | sed 's/[^0-9]//g')
# do
# 	echo "FF "$f
# done

# STATUS=`echo Abort_status.log`
cat Abort_status.log | awk -v ind=1 -F: '/Jobs with Wrapper Exit Code : |Jobs Aborted/ && $0 != "" {
	
	print "1 "$1
	print "2 "$2
	print "3 "$3
	print "4 "$4


	split($1,z," ")
	print " Number of jobs for exit code " $2 " = " z[2];
	ab=match($1,"Aborted")
	print $2
	if (($2 != 0)|| (ab > 0)){ #Do one exit code at a time
		getline;
		if (ab > 0)
			getline;
		n=split($2,a,","); # Num of elements in job number list - NOT the same as the number of jobs
		
		ind2=ind; # For job array index, starting at the end of the last set of job numbers

		for (i=1;i<=n;i++) { # Loop through job number arrays - still contains stupid hypens though. Get rid of them
			# print a[i];
			
			if (match(a[i],"-")){
				len_b=split(a[i],b,"-");
				for(j=b[1];j<=b[2];j++){ 
					# add intermediate numbers to array
					jobs[ind]=j;
					ind++;
				}
			} else{
				# ok by itself, add to job array
				jobs[ind]=a[i];
				ind++;
			}
		}

		# Prints out job number for this failure code
		for(c=ind2;c<=ind;c++)
			print jobs[c];
	}
}' 
# do
# 	echo "SHIIIIt" $g
# done


# echo ${corr_arr[@]}
# for i in ${corr_arr[@]}
# do
# 	echo "FF "$i
# done
