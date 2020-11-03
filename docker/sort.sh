
wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.1/hadoop-2.7.1.tar.gz

tar -zxvf hadoop-2.7.1.tar.gz

cd hadoop-2.7.1/etc/hadoop

echo "export JAVA_HOME=" > hadoop-env.sh

echo "
<configuration>
    <property>
    <name>hadoop.tmp.dir</name>
    <value>/root/data/tmp_data</value>
    <description>Abase for other temporary directories.</description>
    </property>
    <property>
    <name>fs.default.name</name>
    <value>hdfs://master_node_hostname:9100</value>
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
        <value>master_node_hostname:9200</value>
    </property>
    <property>
        <name>dfs.blocksize</name>
        <value>blocksizeNumBytes</value>
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
        <value>core_number</value>
    </property>
    <property>
        <name>yarn.scheduler.minimum-allocation-mb</name>
        <value>min_mb</value>
        <description></description>
    </property>
    <property>
        <name>yarn.scheduler.maximum-allocation-mb</name>
        <value>max_mb</value>
        <description></description>
    </property>
    <property>
        <name>yarn.nodemanager.resource.memory-mb</name>
        <value>res_md</value>
        <description></description>
    </property>
</configuration>
" > yarn-site.xml

echo "10.10.1.1" > slaves

export HADOOP_HOME=/root/hadoop-2.7.1
export PATH=$PATH:$HADOOP_HOME/bin


# Start HadoopStep 
# 1.Format the HDFS:$ cd hadoop-2.7.1
# $ bin/hadoop namenode -formatStep 
# 2.Start Hadoop:$ sbin/start-all.sh

# Stop Hadoop:
# $ sbin/stop-all.sh