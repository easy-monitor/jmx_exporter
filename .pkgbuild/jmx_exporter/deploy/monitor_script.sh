ps -fC java | grep jmx_exporter
if [[ $? -ne 0 ]]; then
   echo "lost progress: jmx_exporter"
   exit 1
fi