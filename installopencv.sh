echo 'Installing opencv in version 3 to /opt/opencv'
set -e 
mkdir tmp
cd tmp 

 mkdir opencv3
 cd opencv3/
git clone https://github.com/opencv/opencv_contrib.git
git clone https://github.com/opencv/opencv.git
 cd opencv/
 mkdir release
 cd release/
 cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_CXX_FLAGS="-march=native" -D OPENCV_EXTRA_MODULES_PATH="../../opencv_contrib/modules" -D CMAKE_INSTALL_PREFIX=/opt/opencv-3-dev ..
 make -j 8
 sudo make install
 cd ..
 mkdir debug
 cd debug/
 cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_FLAGS="-march=native" -D OPENCV_EXTRA_MODULES_PATH="../../opencv_contrib/modules" -D CMAKE_INSTALL_PREFIX=/opt/opencv-3-dev-dbg ..
 make -j 8
 sudo make install
 cd ../../../
 sudo ln -s /opt/opencv-3-dev-dbg/ /opt/opencv3
 sudo ln -s /opt/opencv3/ /opt/opencv
