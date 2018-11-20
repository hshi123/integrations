rm -rf $1/*~
rm -rf $1/output
cameralist=`ls $1`
cameradir=$1
carid=$2
echo $cameralist
for i in $cameralist
do
    python2 yaml_conv.py $1/$i
done
rm -rf latest
mkdir -p latest
cp -p $1/output/0101_intrinsics.yaml    latest/onsemi_narrow_intrinsics.yaml
cp -p $1/output/0102_intrinsics.yaml    latest/onsemi_wide_intrinsics.yaml
cp -p $1/output/0103_intrinsics.yaml    latest/onsemi_obstacle_intrinsics.yaml
cp -p $1/output/0104_intrinsics.yaml    latest/onsemi_obstacle_intrinsics.yaml
cp -p $1/output/0105_intrinsics.yaml    latest/spherical_right_forward_intrinsics.yaml
cp -p $1/output/0106_intrinsics.yaml    latest/spherical_right_backward_intrinsics.yaml
cp -p $1/output/0107_intrinsics.yaml    latest/spherical_backward_intrinsics.yaml
cp -p $1/output/0108_intrinsics.yaml    latest/spherical_left_backward_intrinsics.yaml
cp -p $1/output/0109_intrinsics.yaml    latest/spherical_left_forward_intrinsics.yaml
cp -p $1/output/010a_intrinsics.yaml    latest/spherical_left_forward_intrinsics.yaml
cp -p velodyne128_VLS_calibration.yaml latest/velodyne128_VLS_calibration.yaml
cp -p ant_imu_leverarm.yaml latest/ant_imu_leverarm.yaml
cp -p device.pb.txt latest/device.pb.txt
cp -p vehicle_config.pb.txt latest/vehicle_config.pb.txt

sed -i 's/^#carid:.*/#carid:'$carid'/g' latest/ant_imu_leverarm.yaml
sed -i 's/^car_id:.*/car_id: "'$carid'"/g' latest/device.pb.txt
sed -i 's/^vehicle_id.*/vehicle_id: "'$carid'"/g' latest/vehicle_config.pb.txt
cp -rp latest $2
rm -rf latest/.*~

