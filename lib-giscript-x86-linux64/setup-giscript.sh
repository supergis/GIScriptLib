# Rename some *.so library conflict with GIScript2016.
# which on Anaconda3/envs/GISpark/lib/*

echo Rename some *.so conflict with GIScript2016
cd ~/anaconda3/envs/GISpark/lib
echo "Current diretory:"

pwd
echo 
mv libgomp.so.1.0.0 libgomp.so.1.0.0.x
mv libgomp.so.1 libgomp.so.1.x
mv libgomp.so libgomp.so.x
mv libsqlite3.so.0 libsqlite3.so.0.x
mv libsqlite3.so libsqlite3.so.x
mv libstdc++.so.6 libstdc++.so.6.x
mv libstdc++.so libstdc++.so.x

echo Finished.

cd /home/supermap/GISpark
