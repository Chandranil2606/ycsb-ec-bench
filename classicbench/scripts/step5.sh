RECORD_COUNT=$1
NUM_NODES=$2
ID=$3
THREADS=$4

#original recrod count 75000000
HOSTS=`cat hosts.txt`
INS_COUNT=`expr $RECORD_COUNT / $NUM_NODES`
INS_START=`expr $INS_COUNT '*' $ID`

CP=build/ycsb.jar
for i in db/cassandra-0.7/lib/*.jar ; do
   CP=$CP:${i}
done
#-load load the workload
#-t run the workload
java -cp $CP com.yahoo.ycsb.Client  -db com.yahoo.ycsb.db.CassandraClient7 -P workloads/workloadb \
-t \
-threads $THREADS \
-p measurementtype=timeseries \
-p recordcount=$RECORD_COUNT \
-p hosts="$HOSTS" \
-p operationcount=1000000 \
-p readproportion=0.33 \
-p updateproportion=0.33 \
-p scanproportion=0 \
-p insertproportion=0.33 \
-s > step5-$ID.out 2> step5-$ID.err

