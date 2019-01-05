#!/bin/bash
dir_path=$(cd `dirname $0`; pwd )
radar_front_name1=radar_front_novatel_extrinsics.yaml
radar_rear_name1=radar_rear_novatel_extrinsics.yaml
radar_front_name2=radar_front_extrinsics.yaml
radar_rear_name2=radar_rear_extrinsics.yaml
ln -s -f $radar_front_name1 $radar_front_name2
ln -s -f $radar_rear_name1 $radar_rear_name2
