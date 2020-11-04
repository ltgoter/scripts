#!/bin/bash
set -x

cd ~

# wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.1/hadoop-2.7.1.tar.gz
wget http://archive.apache.org/dist/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz

tar -zxvf hadoop-2.7.1.tar.gz

cd hadoop-2.7.1/etc/hadoop


apt-get update && apt-get install -y software-properties-common

add-apt-repository ppa:openjdk-r/ppa

apt-get update && apt-get -y install  openjdk-8-jdk 

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" > hadoop-env.sh

echo "
<configuration>
    <property>
    <name>hadoop.tmp.dir</name>
    <value>/root/data/tmp_data</value>
    <description>Abase for other temporary directories.</description>
    </property>
    <property>
    <name>fs.default.name</name>
    <value>hdfs://10.10.1.2:9100</value>
    </property>
</configuration>" >core-site.xml

echo "
<configuration>
    <property>
    <name>dfs.name.dir</name>
    <value>/root/data/metadata</value>
    <description> </description>
    </property>
    <property>
    <name>dfs.data.dir</name>
    <value>/root/data/hdfs_data</value>
    <description> </description>
    </property>
    <property>
    <name>dfs.replication</name>
    <value>1</value>
    </property>
</configuration>" > hdfs-site.xml


echo "
<configuration>
    <property>
        <name>mapred.job.tracker</name>
        <value>10.10.1.2:9200</value>
    </property>
    <property>
        <name>dfs.blocksize</name>
        <value>100m</value>
    </property>
</configuration>
" > mapred-site.xml

echo "
<configuration>
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>hostname</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.resource.cpu-vcores</name>
        <value>32</value>
    </property>
    <property>
        <name>yarn.scheduler.minimum-allocation-mb</name>
        <value>10</value>
        <description></description>
    </property>
    <property>
        <name>yarn.scheduler.maximum-allocation-mb</name>
        <value>1024</value>
        <description></description>
    </property>
    <property>
        <name>yarn.nodemanager.resource.memory-mb</name>
        <value>32000</value>
        <description></description>
    </property>
</configuration>
" > yarn-site.xml

echo "10.10.1.1" > slaves
echo "10.10.1.2" > masters

export HADOOP_HOME=/root/hadoop-2.7.1
export PATH=$PATH:$HADOOP_HOME/bin


# Start HadoopStep 
# 1.Format the HDFS:$ cd hadoop-2.7.1
# $ bin/hadoop namenode -format
# 2.Start Hadoop:$ sbin/start-all.sh

# Stop Hadoop:
# $ sbin/stop-all.sh

cd ~

apt-get install scala

wget https://archive.apache.org/dist/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz

tar -zxvf spark-1.5.2-bin-hadoop2.6.tgz
cd spark-1.5.2-bin-hadoop2.6/conf
cp spark-env.sh.template spark-env.sh


#Editspark-env.sh
echo "
SPARK_MASTER_IP=10.10.1.2
export SCALA_HOME=/usr/share/java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export HADOOP_HOME=/root/hadoop-2.7.1
export HADOOP_CONF_DIR=/root/hadoop-2.7.1/etc/hadoop
export SPARK_EXECUTOR_INSTANCES=32
export SPARK_EXECUTOR_CORES=32
export SPARK_EXECUTOR_MEMORY=32G
export SPARK_DRIVER_MEMORY=32G" >> spark-env.sh

cp spark-defaults.conf.template spark-defaults.conf

# vim spark-defaults.conf
echo "
spark.master                     spark://10.10.1.2:7077
spark.eventLog.enabled           true
spark.default.parallelism 100
spark.storage.memoryFraction 0.4
spark.shuffle.memoryFraction 0.6
spark.shuffle.manager hash
spark.shuffle.compress true
spark.broadcast.compress true
spark.shuffle.file.buffer 64k
spark.storage.unrollFraction 0.5
spark.serializer org.apache.spark.serializer.KryoSerializer
spark.rdd.compress true " >>spark-defaults.conf

echo "10.10.1.1" > slaves
echo "10.10.1.2" > masters

export SPARK_HOME=/root/spark-1.5.2-bin-hadoop2.6
export PATH=$PATH:$SPARK_HOME/sbin



apt-get install -y make g++

git clone http://125.39.136.212:8090/BigDataBench/BigDataBench_V5.0_BigData_MicroBenchmark.git

# ./prepare.sh




